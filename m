From: Carlo Scarfoglio <mi2332@mclink.it>
Subject: SiI3112 and data corruption
Date: Sat, 21 Aug 2004 13:35:50 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41273396.5050304@mclink.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail7.mclink.it ([195.110.128.94]:31758 "EHLO mail7.mclink.it")
	by vger.kernel.org with ESMTP id S265031AbUHULW4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Aug 2004 07:22:56 -0400
Received: from [213.155.203.170] (hwadsl-pool-213-155-203-170.telvia.it [213.155.203.170] (may be forged))
	by mail7.mclink.it (8.12.6p2/8.12.3) with ESMTP id i7LBMsHE071942
	for <linux-ide@vger.kernel.org>; Sat, 21 Aug 2004 13:22:54 +0200 (CEST)
	(envelope-from mi2332@mclink.it)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I already posted a few days ago on the kernel mailing list, but received
no answer, with the exception of few concerned users.
In short: when copying large files (> 400) MB from the Maxtor SATA disk
on a channel of the SiI3112 controller on my motherboard
(NForce2) to a Seagate ST3200822AS disk on the other channel,
copied files are corrupted.
Strange thing is, smaller files are not affected, copying from the
Seagate to the Maxtor is OK and from other PATA disks on the
NForce2 controller or from a ramdisk to the Seagate is OK as
well.  Seagate to Seagate is fine.

I tested kernel 2.6.7 with IDE driver, kernel 2.6.8.1 libata driver
with SATA patch Aug 18 applied, kernel 2.6.4 IDE driver from
the SuSE 9.1 DVD distro, 2.4.20 on Morphix cd.
I switched channels without effect.
I assume that the disk is healthy (it is brand new, well cooled,
passes the Seagate tests).

Yesterday I tried two more things:
- I added the disk to the blacklist, no change,
- I increased the ata_pause value in libata.h
from 400 to 600 and this improved things a bit.
450 MB files copied with few or no errors. With
a value of 1000 I can sometimes copy 512MB files
without errors.
The Reiserfs fs on the Seagate gets corrupted too
after a dozen runs of copy/compare.

More details about my system can be found in
my previous post.

Carlo Scarfoglio
