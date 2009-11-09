From: gianluca <gianluca@sottospazio.it>
Subject: pata_ali can't detect partitions
Date: Mon, 9 Nov 2009 23:03:38 +0100
Message-ID: <20091109220338.GA1604@seek.priv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-OUT05A.alice.it ([85.33.3.5]:2275 "EHLO
	smtp-OUT05A.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbZKIWQQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Nov 2009 17:16:16 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: gianluca@sottospazio.it


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

yesterday I tried to install archlinux-i586 on a old computer I have.
It's a K6-3 with a ALI chipset.

I noticed that the system was able to find the disk as sda but could not
recognize the partitions on the drive. This happens with the 2.6.30-ARCH
kernel of the archlinux-i586 installer.

I noticed also that with an older kernel (2.6.28 IIRC) the system could
detect all the partitions.

So yesterday I had some spare time to try to bisect the problem with git
bisect. The result of the bisection was the following commit:

commit 1b2c357c301b76118973763e886d9f70a7f50f7e
pata_ali: force initialise a few bits

I tried to backout the commit but that didn't succeed. So I looked carefully
at the diff and I came out with the attached patch which seems to fix the
problem (at least now the kernel detects the partitions correctly).

Since I saw that the above commit is fixing some real bugs (sunblade related)
I don't know whether the attached patch is right or is backing out the
intended fix. All I know is that it works for me and for this reason I'm
reporting it.

Thanks,
Gianluca

--0OAP2g/MAC+5xKAE
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="pata_ali.patch"

--- linux-2.6.31/drivers/ata/pata_ali.c.orig	2009-11-08 19:01:14.000000000 +0100
+++ linux-2.6.31/drivers/ata/pata_ali.c	2009-11-09 08:30:42.000000000 +0100
@@ -453,7 +453,7 @@
 			/* Clear CD-ROM DMA write bit */
 			tmp &= 0x7F;
 		/* Cable and UDMA */
-		pci_write_config_byte(pdev, 0x4B, tmp | 0x09);
+		pci_write_config_byte(pdev, 0x4B, tmp | 0x08);
 		/*
 		 * CD_ROM DMA on (0x53 bit 0). Enable this even if we want
 		 * to use PIO. 0x53 bit 1 (rev 20 only) - enable FIFO control

--0OAP2g/MAC+5xKAE--
