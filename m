From: Philipp Wagner <mail@philipp-wagner.com>
Subject: Hotplug with sata_nv
Date: Wed, 19 Jul 2006 22:51:51 +0200
Message-ID: <44BE9B67.7020901@philipp-wagner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout.planet-school.de ([194.116.187.6]:32952 "EHLO
	turbohermes.planet-school.de") by vger.kernel.org with ESMTP
	id S1030306AbWGSUvy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Jul 2006 16:51:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey,
I've just tested the new hotplug features of libata and unfortunately,
it didn't work out as expected.

My environment here is a Tyan Tomcat K8E (S2865) mainboard with nVIDIA
nForce4 Ultra chipset, which includes my SATA II controller. It is built
into a server chassis featuring two SATA II (Seagate ST3500630AS, 500GB)
hard drives with hotplug backplanes.  Operating system is Fedora Core 5.
I set up a RAID 1 environment, both drives contain several partitions
which are mirrored.
I tried two kernel versions, both with the same result:
2.6.18-rc2 and 2.6.17.5 with the libata-tj-2.6.17.4-20060710 patch

When I remove one drive, I get the following messages into
/var/log/messages:

Jul 19 21:59:08 srv1 kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x1810000 action 0x2 frozen
Jul 19 21:59:08 srv1 kernel: ata2: soft resetting port
Jul 19 21:59:08 srv1 kernel: ata2: SATA link down (SStatus 0 SControl 300)
Jul 19 21:59:08 srv1 kernel: ata2: failed to recover some devices,
retrying in 5 secs
Jul 19 21:59:13 srv1 kernel: ata2: hard resetting port
Jul 19 21:59:14 srv1 kernel: ata2: SATA link down (SStatus 0 SControl 300)
Jul 19 21:59:14 srv1 kernel: ata2: failed to recover some devices,
retrying in 5 secs
Jul 19 21:59:19 srv1 kernel: ata2: hard resetting port
Jul 19 21:59:20 srv1 kernel: ata2: SATA link down (SStatus 0 SControl 300)
Jul 19 21:59:20 srv1 kernel: ata2.00: disabled
Jul 19 21:59:20 srv1 kernel: ata2: EH pending after completion,
repeating EH (cnt=4)
Jul 19 21:59:20 srv1 kernel: ata2: EH complete

The files /dev/sdb* are removed and the RAID says it has been degraded,
which is perfectly ok.

Now I re-insert the drive and get the following messages into
/var/log/messages:

Jul 19 22:00:11 srv1 kernel: ata2: exception Emask 0x10 SAct 0x0 SErr
0x50000 action 0x2 frozen
Jul 19 22:00:19 srv1 kernel: ata2: port is slow to respond, please be
patient
Jul 19 22:00:42 srv1 kernel: ata2: port failed to respond (30 secs)
Jul 19 22:00:42 srv1 kernel: ata2: soft resetting port
Jul 19 22:00:49 srv1 kernel: ata2: port is slow to respond, please be
patient
Jul 19 22:01:12 srv1 kernel: ata2: port failed to respond (30 secs)
Jul 19 22:01:12 srv1 kernel: ata2: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Jul 19 22:01:12 srv1 kernel: ata2: EH pending after completion,
repeating EH (cnt=4)
Jul 19 22:01:12 srv1 kernel: ata2: EH complete

To me this looks like everything went ok and the drive should be
available again. But unfortunately, this is not the case.
The /dev/sdb* files are not created again, nor did I find a way to
create them (udevstart e.g. didn't do nothing). Only a reboot gave me
the device files back. I also disabled SELinux, but the problems still
perexisted.

Now I do not know where the problem comes from, udev, libata or
something totally else? Also for the RAID, shouldn't be the md module
notice automatically that the drive is added again and begin to
reconstruct the data?

I don't know which information may be most important to you, so I put a
copy of three files online:

The kernel configuration I used:
http://philipp-wagner.com/temp/sata/kernel-config

The relevant part of /var/log/messages:
http://philipp-wagner.com/temp/sata/messages

The output of the `dmesg` command:
http://philipp-wagner.com/temp/sata/dmesg

Thanks already for your help,

Philipp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEvptmn9gADIbesF4RAiZjAJ47qIp/y8R9qQXuorGiEU7Dm2+GngCgsDdw
6sT0FaN4DhoCKW35PhO2PvI=
=mRx2
-----END PGP SIGNATURE-----
