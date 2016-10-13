echo -e "$yellow ***************"
echo -e "$yellow * ROM Builder *"
echo -e "$yellow *************** $nocol"
echo ""
echo -n " Which ROM (bliss,cm,aosp,aicp,tesla...) : ? "
read rom
echo ""
echo -n -e "$green Device identifier (hammerhead, bullhead, hllte, lt01wifi... anything) : ? "
read dev
echo ""
echo -n -e "$blue ROM Version (7.0 6.0 5.X ) : ? "
read ver
echo ""
case $ver in
 7.0) echo -e "$yellow You choosed 7.0. Do u want to use Ninja? "
      echo -e "$green 1. Yes"
      echo -n "$red 2. Nope : "
      read ninja
      case $ninja in
       1) USE_NINJA=true ;;
       
       2) USE_NINJA=false ;;
      esac
      echo "Do you want to apply some exports for 100% Build"
      echo -n "1. Yes, 2. No : "
      read exp
      case $exp in
       1) echo "Applying..."
          ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4096m"
          JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4096m"
          JAVA_OPTIONS="-Xmx4096m"
          echo $JAVA_OPTIONS ;;
      esac ;;
esac
echo " Do you want to make repo sync (to apply any updates) ? "
echo " 1. Yes"
echo -n " 2. No : "
read sync
case $sync in
 1) echo " Syncing! "
    repo sync ;;
esac
echo -n " Do you want to set custom out directory? (type path to custom directory, if no, type any symbol and press enter! ) : "
read out
if [ -e $out ]
 then
 echo " Custom out directory applied! "
 OUT_COMMON_BASE_DIR=$out
 else
 echo " Custom directory not specified! Skipping... "
fi 

echo " Do you want to clean out directory for build? "
echo " 1. Yes (recommended) "
echo -n " 2. No : "
read cleanout
case $cleanout in
 1) echo " Cleaning!"
    make clean ;;

 2) echo " Clean skipped!" ;;
esac
echo " Do you want to START build???"
build ()
{
 echo "***********************************"
 echo "* Android ROM Builder by argraur! *"
 echo "*         Starting Build!         *"
 echo "***********************************"
 sleep 5
 echo "*********************************"
 echo "* Setting up build environment! *"
 echo "*********************************"
 sleep 5
 source build/envsetup.sh
 echo "**********"
 echo "* Lunch! *"
 echo "**********"
 lunch $rom_$dev-userdebug
 echo "**********************"
 echo "* Brunch! Good Luck!!*"
 echo "**********************"
 brunch $rom_$dev-userdebug
}
post_build ()
{
 echo "Is it compiled?"
 echo "1. YEEEES!!!"
 echo -n "2. No(((("
 read isit
 case $isit in
  1) echo "Nice! Good job!" ;;
  
  2) echo "Bad news... Try to fix it! (use latest error entries)";;
 esac
}
echo -n "Type yes (or no) if you want to start! : "
read startbuild
case $startbuild in
 yes) build
      post_build ;;

 no) echo -e "$red Okay you can do it next time! Good bye!" ;;
esac
echo "Exiting bash script..."
     


