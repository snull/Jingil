#!/bin/bash
echo -e "\e[92mhi , www.nullex.ir | by S.NULL \n tnx for using jingil :) ."
sleep 2
setupf (){
  while true;do
    read -p "pls enter the site's rss , for example nullex.ir/feed/ (with last slash/) :  " rssa
    read -p "pls enter the site's name , for example 'nullex' :  " sname
    mkdir "`echo $HOME`"/jingil/"$sname"
    cp ./conf.txt "`echo $HOME`"/jingil/"$sname"/conf.txt
    echo "$rssa" > "`echo $HOME`"/jingil/"$sname"/conf.txt
    cp ./jingil.sh "`echo $HOME`"/jingil/"$sname"/jingil.sh
    cp ./last_date.txt "`echo $HOME`"/jingil/"$sname"/last_date.txt
    read -p "Do you want to adds another site ? (y/n)" answer
    if [ "$answer" != "y" ];then
      echo "goodbye :) !"
      break
    fi
  done
}
deletef (){
  while true;do
    echo -e "\e[91mpls enter the site's name : "
    read site_name_delete
    if [ -d "`echo $HOME`"/jingil/"$site_name_delete" ];then
      rm -R "`echo $HOME`"/jingil/"$site_name_delete"
      echo -e "\e[91m$site_name_delete deleted !"
      read -p "Do you want to delete another one ? (y/n) : " site_name_delete2
      if [ "$site_name_delete2" != "y" ];then
        echo "goodbye :) !"
        break
      fi
    else
      echo -e "\e[91m*****Error ! $site_name_delete does not existed , pls check the spell and be sure that the name is correct .*****"
    fi
  done
}
fset (){
  echo "*/10 * * * * $USER "`echo $HOME`"/jingil/bjingil.sh" > ./jincron
  mkdir "`echo $HOME`"/jingil
  cp ./bjingil.sh "`echo $HOME`"/jingil/
  cp ./jingil.png "`echo $HOME`"/jingil/
  sudo -s cp ./jincron /etc/cron.d/
}
counter=(`cat setup-counter.txt`)
if [ "$counter" != "1" ];then
  fset
  setupf
  echo "1" > ./setup-counter.txt
elif [ "$counter" == "1" ];then
  while true;do
    echo -e "\e[92mDo you want to add another site , \e[93mdelete a site , \e[91mstart setup from first again or \\e[91mremove jingil ? (\e[92madd/\e[93mdelete/\e[91msetup/\e[91muninstall) :  "
    echo -e "\e[39m "
    read answer
    case "$answer" in
      "add")
        setupf
        break ;;
      "delete")
        deletef
        break ;;
      "uninstall")
        rm -R "`echo $HOME`"/jingil
        echo 0 > ./setup-counter.txt
        echo -e "\e[91mjingil uninstalled :( !"
        break ;;
      "setup")
        rm -R "`echo $HOME`"/jingil
        setupf
        break ;;
      *)
        echo -e " \e[91mError ! pls enter one of these : (add/delete/setup) : "
    esac
  done
fi
#echo -e "\e[91mmaking cron file ..."
#sudo -s <<EOF
#echo " */10 * * * * $USER /user/bin/bjingil.sh " > /etc/cron.d/jingil
#cp ./bjingil.sh "`echo $HOME`"/
#echo "done !"
