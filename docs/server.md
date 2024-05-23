Server
------

## Minecraft server software

### server.properties

| Property | Value | Notes |
|----------|-------|-------|
| difficulty | peaceful/easy/normal/hard | Set to peaceful when building. Set to easy/normal/hard when adventuring. |
| motd | Welcome to Waterland | Message of the day. |

## Minecraft server host

### OS details

    cliffano@himawari:~ $ cat /etc/os-release
    PRETTY_NAME="Raspbian GNU/Linux 11 (bullseye)"
    NAME="Raspbian GNU/Linux"
    VERSION_ID="11"
    VERSION="11 (bullseye)"
    VERSION_CODENAME=bullseye
    ID=raspbian
    ID_LIKE=debian
    HOME_URL="http://www.raspbian.org/"
    SUPPORT_URL="http://www.raspbian.org/RaspbianForums"
    BUG_REPORT_URL="http://www.raspbian.org/RaspbianBugs"

    cliffano@himawari:~ $ uname -a
    Linux himawari 5.15.76-v7l+ #1597 SMP Fri Nov 4 12:14:58 GMT 2022 armv7l GNU/Linux

### Utility commands

    sudo update-alternatives --install /etc/alternatives/java snap-openjdk /snap/openjdk/current/jdk/bin/java
    sudo update-alternatives --remove snap-openjdk /snap/openjdk/current/jdk/bin/java

### Links

* [https://www.minecraft.net/en-us/download/server] - Download latest Minecraft server jar
* [https://gist.github.com/cliffano/77a982a7503669c3e1acb0a0cf6127e9] - Download links for Minecraft server jars across versions
* [https://docs.oracle.com/javase/specs/jvms/se21/html/jvms-4.html] - Mapping of Java SE version to Class File Format Major version
* [https://snapcraft.io/install/openjdk/raspbian] - Install OpenJDK on Raspbian
