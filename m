From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Subject: Sil3114 and Hitachi disks
Date: Thu, 23 Dec 2004 16:35:47 +0100 (CET)
Message-ID: <Pine.LNX.4.44.0412231608150.10539-100000@kenzo.iwr.uni-heidelberg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:41431 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S261258AbULWPfv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Dec 2004 10:35:51 -0500
Received: from mail.iwr.uni-heidelberg.de (mail.iwr.uni-heidelberg.de [129.206.104.30])
	by relay2.uni-heidelberg.de (8.12.10/8.12.10) with ESMTP id iBNFaAbY007897
	for <linux-ide@vger.kernel.org>; Thu, 23 Dec 2004 16:36:10 +0100 (MET)
Received: from kenzo.iwr.uni-heidelberg.de (IDENT:24LefWHMWvS64FRSXwuSqvL6pxK0JR6s@kenzo.iwr.uni-heidelberg.de [129.206.120.29])
	by mail.iwr.uni-heidelberg.de (8.12.11/8.12.11) with ESMTP id iBNFZma8011665
	for <linux-ide@vger.kernel.org>; Thu, 23 Dec 2004 16:35:48 +0100 (MET)
Received: from kenzo.iwr.uni-heidelberg.de (localhost.localdomain [127.0.0.1])
	by kenzo.iwr.uni-heidelberg.de (8.12.11/8.12.11) with ESMTP id iBNFZm3G011933
	for <linux-ide@vger.kernel.org>; Thu, 23 Dec 2004 16:35:48 +0100
Received: from localhost (bogdan@localhost)
	by kenzo.iwr.uni-heidelberg.de (8.12.11/8.12.11/Submit) with ESMTP id iBNFZmh3011929
	for <linux-ide@vger.kernel.org>; Thu, 23 Dec 2004 16:35:48 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi!

I see some data corruption with a Sil3114 controller and some Hitachi
disks and I wanted to ask if I'm the only one ( =if I have some broken
disks...)

Hardware details:
Sil3114 on board of Tyan S2882 (dual Opteron 246, 8Gb RAM)
Hitachi HDS722516VLSA80 Rev: V34O (as reported by sata_sil) 160Gb

Software details:
TaoLinux 1.0 (RHEL3 clone), used both kernel 2.4.21-20 and the newly 
released 2.4.21-27, the x86_64 version, containing:
libata version 1.02
sata_sil version 0.54
Latest BIOS (including some update for the Sil firmware) installed

The disk is addressed with lba48:
ata4: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e8 86:3c02 87:4023 88:203f
ata4: dev 0 ATA, max UDMA/100, 321672960 sectors: lba48
ata4: dev 0 configured for UDMA/100

and therefore I wonder if the problem is the same as with the other 
blacklisted drives. However, no other Hitachi drive appears in the 
list and I've even found some e-mails saying that the Hitachi drives 
should not be affected.

The corruption was initially seen after running an ext3 FS for some
time and later on also when e2fsck is run. How to reproduce: on a
clean disk, I create a partition (tested even with a small partition
at the beginning of the disk), format it with 'mke2fs -j -m 0', mount
it without any options, copy some files there with tar from the
network, unmount, then run e2fsck which finds lots of errors. I have 2
identical disks and tried both of them, also with different SATA
cables and connected to different controller ports and the results
were the same.

In the exactly same conditions, a Maxtor 6Y120M0 Rev: YAR5 (120Gb, no 
lba48) works fine, as well as a PATA drive connected to the onboard 
controller (to take out any suspicion of corruption coming from bad 
memory or bad kernel), so this leads me to believe that the Hitachi 
drives are the problem.

I did not get any error messages in the logs nor crashes, except for 
ext3 starting to complain at some point which led me to these tests.

Have other people used this combination of controller and disks ?Is
this enough data to blacklist this kind of disks ? Is there any other
data that I can provide ?

Thanks in advance!

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De



