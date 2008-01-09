From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] libata and starting/stopping ATAPI floppy devices
Date: Wed, 9 Jan 2008 18:53:13 +0100
Message-ID: <200801091853.15601.linux@rainbow-software.org>
References: <200801051647.58866.linux@rainbow-software.org> <4784344C.5060208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.gsystems.sk ([62.176.172.50]:56106 "EHLO www.gsystems.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbYAIRxh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jan 2008 12:53:37 -0500
In-Reply-To: <4784344C.5060208@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Wednesday 09 January 2008 03:41:16 Tejun Heo wrote:
> Ondrej Zary wrote:
> > Hello,
> > I switched to libata drivers for my onboard PATA controller (PIIX4)
> > recently. Everything works fine except that kernel tries to start not
> > only my hard drive (sda) but also LS-120 floppy drive (sdb) which does
> > not like it:
> >
> > sd 0:0:0:0: [sda] Starting disk
> > ata1.00: configured for UDMA/33
> > sd 0:0:0:0: [sda] 58633344 512-byte hardware sectors (30020 MB)
> > sd 0:0:0:0: [sda] Write Protect is off
> > sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> > support DPO or FUA
> > sd 1:0:1:0: [sdb] Starting disk
> > ata2.00: configured for UDMA/33
> > ata2.01: configured for PIO2
> > sd 1:0:1:0: [sdb] Result: hostbyte=0x00 driverbyte=0x08
> > sd 1:0:1:0: [sdb] Sense Key : 0x2 [current]
> > sd 1:0:1:0: [sdb] ASC=0x3a ASCQ=0x0
> >
> >
> > The question is: is it correct? Or a patch like this should be applied?
>
> Yeah, looks good to me.  Please reformat the message w/ S-O-B.
>
> Acked-by: Tejun Heo <htejun@gmail.com>

Prevent libata from starting/stopping non-ATA devices (like ATAPI floppy 
drives) as they don't seem to like it:

sd 1:0:1:0: [sdb] Starting disk
ata2.01: configured for PIO2
sd 1:0:1:0: [sdb] Result: hostbyte=0x00 driverbyte=0x08
sd 1:0:1:0: [sdb] Sense Key : 0x2 [current]
sd 1:0:1:0: [sdb] ASC=0x3a ASCQ=0x0

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.23-orig/drivers/ata/libata-scsi.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6.23-pentium/drivers/ata/libata-scsi.c	2008-01-05 15:50:16.000000000 +0100
@@ -802,7 +802,8 @@
 
 	blk_queue_max_phys_segments(sdev->request_queue, LIBATA_MAX_PRD);
 
-	sdev->manage_start_stop = 1;
+	if (dev->class == ATA_DEV_ATA)
+		sdev->manage_start_stop = 1;
 
 	if (dev)
 		ata_scsi_dev_config(sdev, dev);


-- 
Ondrej Zary
