From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Opening CD bay during resume disabled drive
Date: Sun, 30 Sep 2012 15:09:49 +0200
Message-ID: <1349010589.4768.15.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-W1cDqbUbGnzO1difqvIc"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:58219 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab2I3NJ7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 Sep 2012 09:09:59 -0400
Received: from g225082232.adsl.alicedsl.de ([92.225.82.232] helo=[192.168.178.20])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1TIJHR-0005aG-Cz
	for linux-ide@vger.kernel.org; Sun, 30 Sep 2012 13:09:57 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--=-W1cDqbUbGnzO1difqvIc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Package: src:linux from Debian Wheezy/testing
Version: 3.2.23-1


Dear Linux folks,


please keep my address in CC list since I am not subscribed.

With the CD burner/drive

        CD-RW   CDR-5S40

and the board ASUS M2A-VM I experience the following problem.

After suspend to RAM, opening the burner (ejecting the bay) during
resume the bay was closed automatically, but the burner was disabled
then.

        $ dmesg
        [=E2=80=A6]
        [ 9025.492101] ata1.01: NODEV after polling detection
        [ 9025.492114] ata1.01: revalidation failed (errno=3D-2)
        [ 9030.664092] ata1.01: NODEV after polling detection
        [ 9030.664104] ata1.01: revalidation failed (errno=3D-2)
        [ 9030.664116] ata1.01: disabled
        [ 9030.664178] ata1: soft resetting link
        [ 9030.831927] ata1: EH complete

Is that expected? Now I am not able to use the burner and have to do a
restart. Putting a medium in the burner, the LED lights up, but it does
not start spinning.

        $ eject /dev/sr0
        eject: Kann nicht auswerfen! Letzter Fehler: Unpassender IOCTL (I/O=
-Control) f=C3=BCr das Ger=C3=A4t

But looking at the Linux messages, I think that is normal for a disabled
device.

Another strange thing is, that udisks still seems to know about the
burner.

        $ udisks --show-info /dev/sr0 # after being disabled
        Showing information for /org/freedesktop/UDisks/devices/sr0
          native-path:                 /sys/devices/pci0000:00/0000:00:14.1=
/host0/target0:0:1/0:0:1:0/block/sr0
          device:                      11:0
          device-file:                 /dev/sr0
            presentation:              /dev/sr0
            by-path:                   /dev/disk/by-path/pci-0000:00:14.1-s=
csi-0:0:1:0
          detected at:                 So 30 Sep 2012 10:10:20 CEST
          system internal:             0
          removable:                   1
          has media:                   0
            detects change:            1
            detection by polling:      1
            detection inhibitable:     1
            detection inhibited:       0
          is read only:                0
          is mounted:                  0
          mount paths:            =20
          mounted by uid:              0
          presentation hide:           0
          presentation nopolicy:       0
          presentation name:          =20
          presentation icon:          =20
          automount hint:             =20
          size:                        0
          block size:                  0
          job underway:                no
          usage:                      =20
          type:                       =20
          version:                    =20
          uuid:                       =20
          label:                      =20
          drive:
            vendor:                    CD-RW
            model:                     CD-RW   CDR-5S40
            revision:                  ZSG6
            serial:                   =20
            WWN:                      =20
            detachable:                0
            can spindown:              0
            rotational media:          Yes, unknown rate
            write-cache:               unknown
            ejectable:                 1
            adapter:                   /org/freedesktop/UDisks/adapters/000=
0_3a00_3a14_2e1
            ports:
              /org/freedesktop/UDisks/adapters/0000_3a00_3a14_2e1/host0
            similar devices:
            media:                    =20
              compat:                  optical_cd optical_cd_r optical_cd_r=
w optical_mrw optical_mrw_w
            interface:                 scsi
            if speed:                  (unknown)
            ATA SMART:                 not available


Thanks,

Paul

-- Package-specific info:
** Version:
Linux version 3.2.0-3-amd64 (Debian 3.2.23-1) (debian-kernel@lists.debian.o=
rg) (gcc version 4.6.3 (Debian 4.6.3-8) ) #1 SMP Mon Jul 23 02:45:17 UTC 20=
12

** Command line:
BOOT_IMAGE=3D/boot/vmlinuz-3.2.0-3-amd64 root=3DUUID=3D4313c2c9-7301-41e8-a=
a9b-9e6788a219d3 ro noisapnp quiet rdinitrd=3D/sbin/bootchartd initcall_deb=
ug printk.time=3Dy init=3D/sbin/bootchartd

** Not tainted

** Kernel log:
[ 9020.033109] call host4+ returned 0 after 1 usecs
[ 9020.033113] calling  host5+ @ 6121
[ 9020.033118] call host5+ returned 0 after 1 usecs
[ 9020.033122] calling  target0:0:1+ @ 6121
[ 9020.033127] call target0:0:1+ returned 0 after 1 usecs
[ 9020.033130] calling  0:0:1:0+ @ 6121
[ 9020.033141] call 0:0:1:0+ returned 0 after 7 usecs
[ 9020.033301] calling  target2:0:0+ @ 6125
[ 9020.033306] call target2:0:0+ returned 0 after 1 usecs
[ 9020.033326] calling  2:0:0:0+ @ 6125
[ 9020.033332] sd 2:0:0:0: [sda] Starting disk
[ 9020.048151] r8169 0000:02:00.0: eth0: link down
[ 9020.052030] call 0000:00:13.0+ returned 0 after 21088 usecs
[ 9020.052040] call 0000:00:13.3+ returned 0 after 20955 usecs
[ 9020.052045] call 0000:00:13.1+ returned 0 after 21075 usecs
[ 9020.052051] call 0000:00:13.4+ returned 0 after 20936 usecs
[ 9020.052056] call 0000:00:13.2+ returned 0 after 21000 usecs
[ 9020.052062] calling  usb2+ @ 6092
[ 9020.052067] calling  usb3+ @ 4858
[ 9020.052075] calling  usb5+ @ 6113
[ 9020.052079] calling  usb4+ @ 6090
[ 9020.052085] calling  usb6+ @ 6117
[ 9020.052109] call 0000:00:13.5+ returned 0 after 20972 usecs
[ 9020.052119] calling  usb1+ @ 6089
[ 9020.104047] call usb1+ returned 0 after 50708 usecs
[ 9020.132032] call usb4+ returned 0 after 78073 usecs
[ 9020.132039] call usb6+ returned 0 after 78075 usecs
[ 9020.132065] call usb3+ returned 0 after 78117 usecs
[ 9020.132086] call usb2+ returned 0 after 78145 usecs
[ 9020.132108] call usb5+ returned 0 after 78153 usecs
[ 9020.132125] calling  3-1+ @ 6121
[ 9020.133065] [drm] radeon: 1 quad pipes, 1 z pipes initialized.
[ 9020.141378] [drm] PCIE GART of 512M enabled (table at 0x0000000074580000=
).
[ 9020.141390] radeon 0000:01:05.0: WB enabled
[ 9020.141406] [drm] radeon: ring at 0x0000000080001000
[ 9020.141424] [drm] ring test succeeded in 1 usecs
[ 9020.141437] [drm] ib test succeeded in 0 usecs
[ 9020.164145] call 0000:01:05.0+ returned 0 after 130191 usecs
[ 9020.304065] ata1.01: NODEV after polling detection
[ 9020.304069] ata1.01: revalidation failed (errno=3D-2)
[ 9020.348041] ata5: SATA link down (SStatus 0 SControl 300)
[ 9020.348080] ata6: SATA link down (SStatus 0 SControl 300)
[ 9020.348113] ata4: SATA link down (SStatus 0 SControl 300)
[ 9020.460036] usb 3-1: reset low-speed USB device number 2 using ohci_hcd
[ 9020.576018] ata3: softreset failed (device not ready)
[ 9020.576022] ata3: applying PMP SRST workaround and retrying
[ 9020.748033] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 9020.774102] call 3-1+ returned 0 after 626927 usecs
[ 9020.970314] ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
[ 9021.042954] ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
[ 9021.042958] ata3.00: configured for UDMA/133
[ 9021.090848] call 2:0:0:0+ returned 0 after 1032732 usecs
[ 9021.090869] calling  input0+ @ 5838
[ 9021.090901] call input0+ returned 0 after 27 usecs
[ 9021.090913] calling  i2c-0+ @ 5838
[ 9021.090918] call i2c-0+ returned 0 after 0 usecs
[ 9021.090924] calling  input1+ @ 5838
[ 9021.090933] call input1+ returned 0 after 5 usecs
[ 9021.090936] calling  input2+ @ 5838
[ 9021.090944] call input2+ returned 0 after 5 usecs
[ 9021.090948] calling  SP5100 TCO timer+ @ 5838
[ 9021.090952] call SP5100 TCO timer+ returned 0 after 1 usecs
[ 9021.090957] calling  ttm+ @ 5838
[ 9021.090962] call ttm+ returned 0 after 1 usecs
[ 9021.090967] calling  input3+ @ 5838
[ 9021.090980] call input3+ returned 0 after 9 usecs
[ 9021.090992] calling  controlD64+ @ 5838
[ 9021.090996] call controlD64+ returned 0 after 0 usecs
[ 9021.090999] calling  card0+ @ 5838
[ 9021.091004] call card0+ returned 0 after 1 usecs
[ 9021.091007] calling  i2c-1+ @ 5838
[ 9021.091011] call i2c-1+ returned 0 after 0 usecs
[ 9021.091013] calling  i2c-2+ @ 5838
[ 9021.091018] call i2c-2+ returned 0 after 1 usecs
[ 9021.091021] calling  i2c-3+ @ 5838
[ 9021.091025] call i2c-3+ returned 0 after 0 usecs
[ 9021.091028] calling  i2c-4+ @ 5838
[ 9021.091032] call i2c-4+ returned 0 after 1 usecs
[ 9021.091035] calling  card0-VGA-1+ @ 5838
[ 9021.091039] call card0-VGA-1+ returned 0 after 1 usecs
[ 9021.091042] calling  card0-SVIDEO-1+ @ 5838
[ 9021.091046] call card0-SVIDEO-1+ returned 0 after 0 usecs
[ 9021.091049] calling  card0-HDMI-A-1+ @ 5838
[ 9021.091053] call card0-HDMI-A-1+ returned 0 after 0 usecs
[ 9021.091056] calling  card0-DVI-D-1+ @ 5838
[ 9021.091060] call card0-DVI-D-1+ returned 0 after 0 usecs
[ 9021.091065] calling  input4+ @ 5838
[ 9021.091070] call input4+ returned 0 after 1 usecs
[ 9021.091100] PM: resume of devices complete after 1060.825 msecs
[ 9023.590417] PM: Finishing wakeup.
[ 9023.590420] Restarting tasks ... done.
[ 9025.492101] ata1.01: NODEV after polling detection
[ 9025.492114] ata1.01: revalidation failed (errno=3D-2)
[ 9030.664092] ata1.01: NODEV after polling detection
[ 9030.664104] ata1.01: revalidation failed (errno=3D-2)
[ 9030.664116] ata1.01: disabled
[ 9030.664178] ata1: soft resetting link
[ 9030.831927] ata1: EH complete
[ 9034.973553] r8169 0000:02:00.0: eth0: link up
[ 9045.648032] eth0: no IPv6 routers present

** Model information
sys_vendor: System manufacturer
product_name: System Product Name
product_version: System Version
chassis_vendor: Chassis Manufacture
chassis_version: Chassis Version
bios_vendor: Phoenix Technologies, LTD
bios_version: ASUS M2A-VM ACPI BIOS Revision 2302
board_vendor: ASUSTeK Computer INC.
board_name: M2A-VM
board_version: 1.XX   =20

** Loaded modules:
ip6table_filter
ip6_tables
iptable_filter
ip_tables
x_tables
radeon
edac_mce_amd
psmouse
pcspkr
powernow_k8
mperf
evdev
snd_hda_codec_realtek
serio_raw
ttm
edac_core
k8temp
drm_kms_helper
drm
power_supply
i2c_algo_bit
snd_hda_intel
snd_hda_codec
snd_hwdep
parport_pc
parport
asus_atk0110
sp5100_tco
button
snd_pcm
processor
snd_page_alloc
snd_timer
i2c_piix4
snd
soundcore
shpchp
i2c_core
cn
ext2
mbcache
sg
sr_mod
sd_mod
crc_t10dif
cdrom
usbhid
ata_generic
hid
ahci
libahci
ohci_hcd
pata_atiixp
libata
ehci_hcd
fan
thermal
thermal_sys
usbcore
r8169
mii
scsi_mod
usb_common

** PCI devices:
not available

** USB devices:
not available


-- System Information:
Debian Release: wheezy/sid
  APT prefers testing
  APT policy: (500, 'testing')
Architecture: amd64 (x86_64)

Kernel: Linux 3.2.0-3-amd64 (SMP w/2 CPU cores)
Locale: LANG=3Dde_DE.UTF-8, LC_CTYPE=3Dde_DE.UTF-8 (charmap=3DUTF-8)
Shell: /bin/sh linked to /bin/dash

Versions of packages linux-image-3.2.0-3-amd64 depends on:
ii  debconf [debconf-2.0]                   1.5.46
ii  initramfs-tools [linux-initramfs-tool]  0.107
ii  kmod                                    9-2
ii  linux-base                              3.5
ii  module-init-tools                       9-2

Versions of packages linux-image-3.2.0-3-amd64 recommends:
ii  firmware-linux-free  3.1

Versions of packages linux-image-3.2.0-3-amd64 suggests:
pn  debian-kernel-handbook  <none>
ii  grub-pc                 1.99-23
pn  linux-doc-3.2           <none>

Versions of packages linux-image-3.2.0-3-amd64 is related to:
pn  firmware-atheros        <none>
pn  firmware-bnx2           <none>
pn  firmware-bnx2x          <none>
pn  firmware-brcm80211      <none>
pn  firmware-intelwimax     <none>
pn  firmware-ipw2x00        <none>
pn  firmware-ivtv           <none>
pn  firmware-iwlwifi        <none>
pn  firmware-libertas       <none>
ii  firmware-linux          0.36
ii  firmware-linux-nonfree  0.36
pn  firmware-myricom        <none>
pn  firmware-netxen         <none>
pn  firmware-qlogic         <none>
pn  firmware-ralink         <none>
pn  firmware-realtek        <none>
pn  xen-hypervisor          <none>

-- debconf information:
  linux-image-3.2.0-3-amd64/postinst/depmod-error-initrd-3.2.0-3-amd64: fal=
se
  linux-image-3.2.0-3-amd64/postinst/ignoring-ramdisk:
  linux-image-3.2.0-3-amd64/postinst/missing-firmware-3.2.0-3-amd64:
  linux-image-3.2.0-3-amd64/prerm/removing-running-kernel-3.2.0-3-amd64: tr=
ue

--=-W1cDqbUbGnzO1difqvIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlBoRJ4ACgkQPX1aK2wOHVglMACcC+rmCZ7b1KtavIOygOh+wMEK
AAwAn1+moiafJlqSJPsEpo//K9FXCriv
=FhUD
-----END PGP SIGNATURE-----

--=-W1cDqbUbGnzO1difqvIc--

