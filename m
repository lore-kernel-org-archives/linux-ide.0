From: Giulio Orsero <giulioo@gmail.com>
Subject: writing to ide dvd-ram: terrible slow-downs
Date: Fri, 02 Dec 2005 19:09:23 +0100
Message-ID: <20051202180923.B6A74F817@i3.golden.dom>
Reply-To: giulioo@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wnx-5a.seeweb.it ([212.25.170.113]:24452 "EHLO wnx-5a.seeweb.it")
	by vger.kernel.org with ESMTP id S1750781AbVLBSMF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2005 13:12:05 -0500
Received: from i3.golden.dom (xs-213-255-43-90.to1.albacom.net [213.255.43.90] (may be forged))
	(authenticated bits=0)
	by wnx-5a.seeweb.it (8.12.3/8.12.3/Debian-7.1) with ESMTP id jB2IBvDr024049
	for <linux-ide@vger.kernel.org>; Fri, 2 Dec 2005 19:11:58 +0100
Received: from pc93 (pc93 [192.168.1.193])
	by i3.golden.dom (Postfix) with SMTP id B6A74F817
	for <linux-ide@vger.kernel.org>; Fri,  2 Dec 2005 19:09:23 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

1st system:
kernel 2.4.32
2 SATA HDs on intel sata using ata_piix (bios is enhanced mode)
1 IDE DVD-RAM/-RW/+RW (LG 4163B) on hda.
DVD-RAM media

When writing to the DVD-RAM (I have ext2 fs on it), accessed via ide-scsi,
there are terrible slow-downs on the 2 sata disks like writing to and ide
device would affect the 2 sata channels, is this normal behavior?

===========
2ns system:
kernel 2.6.15-<latest rc>
1 HD on hda
1 IDE DVD-RAM (LG 4163B) on hdc.

When writing to the DVD-RAM (I have ext2 fs on it) accessed via ide-cd,
there are terrible slow-downs on the ide disk like writing to an ide device
on 2nd ide channel would affect the 1st ide channel (different ide cable) is
this normal behavior?

In bot cases I write to the dvd-ram this way:
mount -t ext2 /dev/scd0 /mnt/dvd (kernel 24)
or
mount -t ext2 /dev/hdc /mnt/dvd  (kernel 26)

and then
cp data /mnt/dvd/


I remember having similar problems when using cdrecord to write cd-rw in the
past  which I could solve using the cdrecord "-immed" flag.

Before flogging the list with long dmesg I wanted to be certain this is not
the way it's supposed to work.

Suggestions?

Thanks
