From: Scott James Remnant <scott@ubuntu.com>
Subject: Problem with IDE driver not claiming the disk
Date: Mon, 05 Dec 2005 23:56:33 +0000
Message-ID: <1133826994.8181.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O/ZieHmR+d4M7pTxWxU9"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from populous.netsplit.com ([62.49.129.34]:24738 "EHLO
	mailgate.netsplit.com") by vger.kernel.org with ESMTP
	id S1751499AbVLEX4w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Dec 2005 18:56:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-hotplug-devel@lists.sourceforge.net


--=-O/ZieHmR+d4M7pTxWxU9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi there,

We've been having some IDE problems at Ubuntu Towers and can't seem to
figure out what's up, and I was hoping you guys might instantly spot
what we're doing wrong ...

In order to get the root filesystem mounted (we're in initramfs at this
point), we do the following steps:

1) Run udevd.

   This has rules configured to load the ide-cd, ide-disk, ide-floppy or
   ide-tape modules when a device matching SUBSYSYTEM=3D=3D"ide" is added.
   We decide which module to load by looking at /proc/ide/ide*/*/media
   (after waiting for that to turn up)

   This also has the standard rules to modprobe $MODALIAS, should that
   be set.

2) Look in /sys/bus/pci/devices for those with a class of 0x01* (storage
   devices), and write to the uevent file of each.


This results in ide-core being loaded, along with the appropriate driver
for the IDE controller and the "generic" module.  On my laptop (an HP
nc4010) I get the alim15x3 driver, on a colleague's (Acer 1520 AMD64) he
gets the via82cxxx driver.

At this point, there is nothing in /proc/ide other than an empty
"drivers" file, and nothing in /sys/bus/ide/devices -- though this
directory does now exist.

In particular there are also no events for any devices on the bus...


In order to get those events, and find out what's on the bus, we
explicitly load the "ide-generic" driver.  This spawns a whole number of
events, creating a whole array of devices -- /dev/hda* and friends.

The ide-disk module is loaded as a result of these events.


On my laptop with the alim15x3 driver, the disks appear to be bound to
this driver; in particular the following is true:

	# readlink /sys/bus/ide/devices/0.0
	../../../devices/pci0000:00/0000:00:10.0/ide0/0.0

	# readlink /sys/devices/pci0000:00/0000:00:10.0/driver
	../../../bus/pci/drivers/ALI15x3_IDE

However on the via82cxx laptop we see:

	# readlink /sys/bus/ide/devices/0.0
	../../../devices/pci0000:00/0000:00:11.1/ide0/0.0

	# readlink /sys/devices/pci0000:00/0000:00:11.1/driver
	../../../bus/pci/drivers/PCI_IDE

It looks like the device is being claimed by the ide-generic driver, and
not the VIA one.

Do you concur?  What are we doing wrong, or what is the driver doing
wrong?

Scott
--=20
Scott James Remnant
scott@ubuntu.com

--=-O/ZieHmR+d4M7pTxWxU9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDlNOxSnQiFMl4yK4RApVhAJ9a64zt1s4cLOJ2HNJuQzWdhfYyegCgj/l2
RDc/u2BYAPZPotpy0pGeIiE=
=JCPf
-----END PGP SIGNATURE-----

--=-O/ZieHmR+d4M7pTxWxU9--

