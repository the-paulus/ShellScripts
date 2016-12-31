# .bashrc
                                                                                                                    
# Source global definitions                                                                                         
if [ -f /etc/bashrc ]; then                                                                                         
        . /etc/bashrc                                                                                               
fi   

export PS1="(\!) i[\u@\H \W]\$ "

. ~/.bash_includes/functions_docker.sh
. ~/.bash_includes/functions_web.sh
