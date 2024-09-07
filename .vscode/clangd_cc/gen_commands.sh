#!/bin/sh


if [ $# -eq 0 ] || [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; 
then
    printf "No arguments supplied"
	exit 1;
elif [ $# -eq 3 ]; then
	if [ "$1" != 'clean' ] && [ "$1" != 'clean_binary' ] && [ "$1" != 'clean_install' ] && [ "$1" != 'record_build' ] && [ "$1" != 'build_library' ] && [ "$1" != 'install' ]; 
	then
		printf "First argument is invalid (Valid Commands: clean/clean_binary/clean_install/record_build/build_library/install)"
		exit 1
	fi
	if [ "$2" != 'shared' ] && [ "$2" != 'static' ]; 
	then
		printf "Second argument is invalid (Valid Configuration: shared/static)"
		exit 1
	fi
	if [ "$3" != 'debug' ] && [ "$3" != 'release' ]; 
	then
		printf "Third argument is invalid (Valid Configurations: debug/release)"
		exit 1
	fi
else
	printf "Invalid amount of arguments passed (Arg1 = clean/clean_binary/record_build/build_library, Arg2 = shared/static, Arg3 = debug/release)"
	exit 1
fi


get_abs_filename() {
	# $1 : relative filename
	echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}


# Static variables
JSON=".json"
COMPILE_DATABASE_FILENAME="compile_commands"
MAKEFILE_NAME="makefile.mf"
MAKE_CONFIG='build_library'
DEBUG_POSTFIX="_debug"
RELEASE_POSTFIX="_release"
APPEND_POSTFIX=""


if [ "$2" = 'static' ]; then
	export SHARED=0
elif [ "$2" = 'shared' ]; then
	export SHARED=1
fi
if [ "$3" = 'release' ]; then
	export DEBUG=0
	APPEND_POSTFIX="${RELEASE_POSTFIX}${JSON}"

elif [ "$3" = 'debug' ]; then
	export DEBUG=1
	APPEND_POSTFIX="${DEBUG_POSTFIX}${JSON}"
fi


# Variables responsible for making the compile_commands.json and symlinking it later.
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
SCRIPT_ABS_PATH="$( cygpath -w "${SCRIPT_PATH}" )"
THREAD_COUNT_TOTAL="$( nproc )"
COMMANDS_SYMLINK_PATH="${SCRIPT_PATH}/.."
THREAD_COUNT=$(( THREAD_COUNT_TOTAL - 2 ))
COMPILE_DATABASE_ABSOLUTE_FILENAME_SYMLINK="${COMMANDS_SYMLINK_PATH}/${COMPILE_DATABASE_FILENAME}${JSON}"
COMPILE_DATABASE_ABSOLUTE_FILENAME="${SCRIPT_PATH}/${COMPILE_DATABASE_FILENAME}${APPEND_POSTFIX}"


# Make Command & finding the path of the internal makefile
MAKEFILE_RELATIVE_PATH=" $( realpath --relative-to="${SCRIPT_PATH}/../../" "${SCRIPT_PATH}/${MAKEFILE_NAME}") "
MAKEFILE_ABSOLUTE_PATH=" $( get_abs_filename ${SCRIPT_PATH}/${MAKEFILE_NAME} ) "
# MAKE_COMMAND="make -f ${MAKEFILE_RELATIVE_PATH}"
MAKE_COMMAND="make --no-print-directory -f ${MAKEFILE_RELATIVE_PATH}"



clean_build() {
	${MAKE_COMMAND} clean_internal
}

clean_binary() {
	${MAKE_COMMAND} cleanbin_internal
}

clean_install() {
	${MAKE_COMMAND} cleaninstall_internal
}

archive_library() {
	${MAKE_COMMAND} build_library
}

install_library() {
	${MAKE_COMMAND} install_internal
}

record_build() {
	# printf ${MAKE_COMMAND} ${MAKE_CONFIG}
	# printf ${SCRIPT_ABS_PATH}
	python "${SCRIPT_ABS_PATH}"/compile_comms.py --out="${COMPILE_DATABASE_ABSOLUTE_FILENAME}" --exec="${MAKE_COMMAND} -j ${THREAD_COUNT} ${MAKE_CONFIG} && ${MAKE_COMMAND} ${MAKE_CONFIG}"
	# python3 /cygdrive/c/"Program Files/Programming Utillities"/Cygwin${SCRIPT_PATH}/compile_commands.py --out=${COMPILE_DATABASE_ABSOLUTE_FILENAME} --exec=${tmp}
}

create_symlink() {
	export CYGWIN=winsymlinks:nativestrict
	# create symlink to the currently/previously created compile_commands_(debug/release).json ( in ../ [.vscode/] )
	printf "ln -sf %s %s" "${COMPILE_DATABASE_ABSOLUTE_FILENAME}" "${COMPILE_DATABASE_ABSOLUTE_FILENAME_SYMLINK}"
	ln -sf "$COMPILE_DATABASE_ABSOLUTE_FILENAME" "$COMPILE_DATABASE_ABSOLUTE_FILENAME_SYMLINK"
}




if [ "$1" = 'clean' ]; then
	clean_build
elif [ "$1" = 'clean_binary' ]; then
	clean_binary
elif [ "$1" = 'clean_install' ]; then
	clean_install
elif [ "$1" = 'record_build' ]; then
	clean_build    # Clean the build that was chosen
	record_build   # Record build process using bear for the compile_commands.json	create_symlink # Create the symlink from bear output json file
	printf "compile_commands.json (symlink=%s) created from %s" "${COMPILE_DATABASE_ABSOLUTE_FILENAME_SYMLINK}" "${COMPILE_DATABASE_ABSOLUTE_FILENAME}";
elif [ "$1" = 'build_library' ]; then
	archive_library
	create_symlink
	# We need to bind the symlink to the current build config	# to get correct references and debug info.
elif [ "$1" = 'install' ]; then
	install_library
	create_symlink
else
	printf "You shouldn't have reached this place. Something went horribly wrong."
	exit 1
fi

printf "Shell Script Finished [Command Config] = [%s %s %s]" "${1}" "${2}" "${3}" 
printf "\n"