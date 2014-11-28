From: Yakushkin Mike <mrkrio@yandex.ru>
Subject: copy speed slows down
Date: Fri, 28 Nov 2014 13:19:05 +0300
Message-ID: <100961417169945@web3j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from forward11.mail.yandex.net ([95.108.130.93]:47631 "EHLO
	forward11.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbaK1K2u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Nov 2014 05:28:50 -0500
Received: from web3j.yandex.ru (web3j.yandex.ru [5.45.198.44])
	by forward11.mail.yandex.net (Yandex) with ESMTP id 69698E81C79
	for <linux-ide@vger.kernel.org>; Fri, 28 Nov 2014 13:19:08 +0300 (MSK)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, dear AHCI SATA developers.
I would like to seek your advice and help.
Background.
I am developing a bootable Linux distribution for our company which tak=
es into account the requirements of corporate security based on Debian =
using utility debirf. Our company is growing and more and more often in=
 life begin to use computers enabled with thunderbolt support, such as =
the MacBook, MacBook Air, and even HP ZBook. Until the middle of this y=
ear, the company had only external drives firm Lacie: Little Big Disk 1=
TB included 2=C8Samsung 1 HN-M101MBB 1 TB 5400rpm. For some employees w=
ho really need the speed I changed the Samsung to OCZ Vertex 3. However=
, in mid-2014 were purchased external drives Lacie Rugged USB3.0 Thunde=
rbolt and thunderbolt adapters firm Seageate (eg SRD0002 and others) to=
 transfer files between computers departments (departments can not be c=
onnected to the network), in which there is no thunderbolt interface.
All devices are colldplugged and formated to ext2.
And in November, it is time to update the entire distribution taking in=
to account the growth of the organization and the change in security po=
licy. Using well-established pattern, I downloaded the latest distribut=
ion Debian jessie from November 17, 2014 with the kernel 3.16.4. and he=
re began the adventure since dropped copy speed on ext2, in some cases =
up to 50 Mb/s. (see technical description below). I thought about it an=
d decided to try kernel with thunderbolt support. I downloaded kernel 3=
=2E16.7, rebuilt it with enabled in the kernel thunderbolt driver, but =
the copy is still the same low. I downloaded the kernel 3.17.3 collecte=
d it so that the thunderbolt driver was module, but the copy remained l=
ow as to command insmod .../thunderbolt.ko, and after it.
Here I am sad and decided to turn to you for advice and help, I can pro=
vide screenshots, outs of dmesg, lsmod for your request.
Please, help to speed up copying in new kernels.

Technical description:
MacBook Air Model A1370 (googling as: Apple MacBook Air "Core i7" 1.8 1=
1" (Mid-2011))
Disk A: Lacie Little Big Disk with Samsung HN-M101MBB 1 TB
Disk B: Lacie Little Big Disk with OCZ Vertex 3
Disk C: Seagate thunderbolt Adapter from STCB3000400 with OCZ Vertex 3
Disk D: Seagate thunderbolt Adapter from STCB3000400 with Samsung HN-M1=
01MBB 1 TB

using copy cammand: dd if=3D/dev/sda(internal Mac Book disk) of=3D/mnt/=
sdb1/test.dd bs=3D4M

Test bench 1. Bootable distro based on Debian whezzy 7.2 stable from Oc=
tober 12, 2013, kernel 3.2.0.4
1.1 Disk A (ext2). Stable copying speed =3D 81,4 MB/s.
1.2 Disk B (ext2). Stable copying speed =3D 196 MB/s. !!!!!
1.3 Disk C (ext2). Stable copying speed =3D 199 MB/s.
1.4 Disk D (ext2). Stable copying speed =3D 87 MB/s.

Test bench 2. Bootable distro based on Debian jessie from November 17, =
2014, kernel 3.16.7 + thunderbolt driver compiled in.
2.1 Disk A (ext2). Stable copying speed =3D 94 MB/s.
2.2 Disk B (ext2). Stable copying speed =3D 150 MB/s. !!!!!!

Test bench 3. Bootable distro based on Debian jessie from November 17, =
2014, kernel 3.17.3 + thunderbolt driver compiled as module.
3.1 Disk A (ext2). Stable copying speed =3D 97 MB/s.
3.2 Disk B (ext2). Stable copying speed =3D 151 MB/s.
3.3 Disk C (ext2). Stable copying speed =3D 156 MB/s. !!!!!
3.4 Disk D (ext2). Stable copying speed =3D 108 MB/s.

after and before insmod .../thunderbolt.ko the same results.
