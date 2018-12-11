#!/usr/bin/env bash

## This file shouldn't need to be modified unless you want to override something.
## Use the '.env' file located in the root of the poppy repo to configure.

WORKSPACE=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd);

NO_REBUILD=false
AUTO_RUN=false
RUN_POPPY=true
RUN_POPPY_DEPS=false

while getopts "iaeo" OPTION
do
	case ${OPTION} in
	    i)
	        INIT_SETUP=true
            echo "Initializing Development Environment"
			;;
		a)
			echo "Auto run enabled"
			AUTO_RUN=true
			;;
		e)
			echo "Running init container setup script (sni_upsert, flavor creation, etc)"
			echo "* poppy-server must be running *"
            exec docker-compose -f "$WORKSPACE/docker-compose.yml" exec poppy-server init-poppy-setup
            exit 0
			;;
        o)
            echo "Run only Poppy Dependencies"
            RUN_POPPY_DEPS=true
            ;;
		?)
		    echo "Usage:"
		    echo "------"
            echo "  -i  (Initialize Development Env) Populates config files with the values from the .env file"
			echo "  -a  (AUTO_RUN) Start containers automatically"
			echo "  -e  (RUN Poppy-server Init Script... runs scripts such as sni_upsert, flavor creation, etc)"
			echo "  -o  (Only Run Dependencies) Like '-p' but will not start the poppy-server or poppy-worker services"
			exit 0
			;;
	esac
done

if [[ "$AUTO_RUN" = true ]] && [[ "$RUN_POPPY_DEPS" = true ]]; then
    echo "The '-a' and '-o' flags are mutually exclusive"
    exit 1
fi


if [[ ! -f "$WORKSPACE/docker/dev/poppy.conf" ]] && [[ "$INIT_SETUP" = false ]]; then
    echo " ** Existing poppy.conf not found -- running initial setup ** "
    INIT_SETUP=true
fi

if [[ "$INIT_SETUP" = true ]]; then
    echo "Running initial setup script"

    echo "[*] copy the requirements so they can be cached within docker"
    {
        find "$WORKSPACE/requirements" -name "*.txt" -exec cat "{}" \; | grep -v "^-r"
        cat "$WORKSPACE/doc/requirements.txt"
        cat "$WORKSPACE/tests/test-requirements.txt"
    }  | sort | uniq | tee "$WORKSPACE/docker/dev/dev-requirements.txt"

    find "$WORKSPACE/requirements" -name "*.txt" -exec cat "{}" \; | sort
    # Check for a "dev" poppy config first, fall back to generating a new one from .env

    if [[ -f "$HOME/.poppy/poppy-dev.conf" ]]; then
        echo "[*] poppy-dev.conf found -- copying instead of generating a new config"
        cp "$HOME/.poppy/poppy-dev.conf" "$WORKSPACE/docker/dev/poppy.conf"
    else
        echo "[*] loading vars from .env"
        set -a
        . "$WORKSPACE/.env"
        set +a

        if [[ "$(uname -s)" = "Darwin" ]]; then
            # Using docker for mac
            unset DOCKER_HOST

            if [[ ! -x "/usr/local/bin/gettext" ]]; then
                    echo "[*] installing gettext via homebrew"
                    brew install gettext
                    brew link gettext --force
            fi
            if [[ ! -x "/usr/local/bin/ip" ]]; then
                echo "[*] installing iproute2mac via homebrew"
                brew install gettext iproute2mac
            fi
        fi
        export HOST_IP=$(ip route get 1 | awk '{print $NF;exit}')
        cd "$WORKSPACE/docker/dev"
        # Generate a new poppy.conf from the .env file
        cat poppy.conf.template | envsubst > poppy.conf
    fi


    echo "Setup Complete"
    echo "You can now use docker-compose as usual,"
    echo "or re-run this script with flags like '$0 -a' (auto run) or '$0 -o' "
    echo "(dependencies only) to quickly interact with services"
    echo ""
fi

cd "$WORKSPACE"

if [[ "$AUTO_RUN" = true ]]; then
    docker-compose up --build -d
fi

if [[ "$RUN_POPPY_DEPS" = true ]]; then
    exec docker-compose up --build zookeeper cassandra
    exec docker-compose -f "$WORKSPACE/docker-compose.yml" exec poppy-server init-poppy-setup
fi
