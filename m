From: Phil Dibowitz <phil@ipom.com>
Subject: libata, promise card, raid autodetect
Date: Sun, 21 May 2006 23:50:39 -0700
Message-ID: <44715F3F.4070502@ipom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAF11CF4D4962F6986534F626"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.ipom.com ([209.40.128.125]:14305 "EHLO
	uberhacker.sage-inc.com") by vger.kernel.org with ESMTP
	id S932501AbWEVGun (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 May 2006 02:50:43 -0400
Received: from [10.1.1.2] (cpe-24-24-245-191.socal.res.rr.com [24.24.245.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uberhacker.sage-inc.com (Postfix) with ESMTP id 92FFA1BBBA
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 01:50:52 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAF11CF4D4962F6986534F626
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Problem: RAID auto-detect on my promise PC20378 doesn't seem to work -
but works with other controllers.

First of all - thanks to Mark Hahn for emailing me off list and helping
me out a bit.

I think it's time to bring this back to the list. It seems that, at
least in my configuration, kernel raid auto-detection runs before the
kernel has detected partitions on the SATA Promise driver (note: pata
chain on the SATA controller).

Dmesg showing this below.

I have a RAID-1 array between partitions on a disk on a 82801EB/ER
(ICH5/ICH5R) IDE Controller and my SATA Promise PDC20378 controller.

I have all the required parts BUILT IN to the kernel (kernel config below=
).

My 82801EB/ER (ICH5/ICH5R) IDE Controller seems to be run by the general
IDE layer - I have no particular drivers enabled.

My Promise PDC20378 is controlled by CONFIG_SCSI_SATA_PROMISE with the
libata1.patch from Jeff in order to support the PATA part of the
controller. Again, built in, NOT a module.

RAID1 support is also built in.

What happens is:

Recongize ICH5/ICH5R
Initialize partitions on ICH5/ICH5R
Recognize PDC20378
Raid auto-detect
Recognize partitions on PDC20378

Dmesg:
http://www.phildev.net/dmesg.txt

Kernel Config:
http://www.phildev.net/config-2.6.15.6rider-smp

lspci:
[phil@rider ~]$ lspci
0000:00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM
Controller/Host-Hub Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP
Controller (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB UHCI Controller #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R)
USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC
Interface Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R)
IDE Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus
Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV36.2
[GeForce FX 5700] (rev a1)
0000:02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
0000:02:04.0 RAID bus controller: Promise Technology, Inc. PDC20378
(FastTrak 378/SATA 378) (rev 02)
0000:02:05.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001
Gigabit Ethernet Controller (rev 13)

Kernel is a kernel.org 2.6.15 with SMP support and Jeff's libata1.patch.

Any help would be greatly appreciated. I'm happy to try patches, provide
any details I've left out, etc.

--=20
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Be who you are and say what you feel, because those who mind don't
matter and those who matter don't mind."
 - Dr. Seuss



--------------enigAF11CF4D4962F6986534F626
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcV8/N5XoxaHnMrsRAqwVAKCSEQQ+NgUD56Y8lUSZ/Ua4y5XLJwCfQTqx
4BgyMYCzkuswT7f3bM3NoBY=
=Gsfr
-----END PGP SIGNATURE-----

--------------enigAF11CF4D4962F6986534F626--
