From: Tejun Heo <tj@kernel.org>
Subject: Re: Fwd: [PATCH #upstream-fixes 1/4] libata: fix device iteration
 bugs
Date: Mon, 10 Nov 2008 15:52:02 +0900
Message-ID: <4917DA12.8070307@kernel.org>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000501020803090008030505"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56173 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbYKJGwL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Nov 2008 01:52:11 -0500
In-Reply-To: <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guntsche Michael <mike@it-loops.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000501020803090008030505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Guntsche Michael wrote:
>> I just browsed through the linux-ide archives and found this patch. I am
>> wondering if this also helps with a problem I am facing on one of my
>> router
>> boxes since a few kernel versions.
>>
>> I have an ancient router box with a  "Intel Corporation 82371SB PIIX3 IDE
>> [Natoma/Triton II]" controller. I switched to the new libata code a long
>> time ago using the ata_piix driver. I have one harddisk and a CD-burner i
>> not use very often. The Harddisk is on Primary master the burner on
>> secondary master. with at least the last two kernel versions, I see this
>> during bootup
>>
>> ata_piix 0000:00:07.1: version 2.12
>> scsi0 : ata_piix
>> scsi1 : ata_piix
>> ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xe800 irq 14
>> ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xe808 irq 15
>> ata1.00: ATA-5: IC35L040AVER07-0, ER4OA45A, max UDMA/100
>> ata1.00: 66055248 sectors, multi 16: LBA
>> ata1.00: configured for MWDMA2
>> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
>> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
>> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x1)
>> ata2.00: ATAPI: SAMSUNG CD-R/RW SW-408B, M300, max MWDMA2
>>
>> As you can see for some reason ata2.01 (secondary slave??) gets
>> probed during startup although there is nothing attached to it. It
>> is tried three times with a 5 seconds pause in between. I did not
>> notice this in the past since a do not reboot that machine very
>> often.  For testing purposes I just recently did this a few times
>> in a row and noticed this. It is not a biggie since harddisk and
>> burner are working but nevertheless it wasn't happening with older
>> kernel versions so I though you should know.

Looks like our phantom device detection logic is somehow broken.  Can
you please apply the attached patch and report boot log?

Thanks.

-- 
tejun

--------------000501020803090008030505
Content-Type: text/x-patch;
 name="phantom-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="phantom-debug.patch"

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 4b47394..709bbb4 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1226,6 +1226,8 @@ fsm_start:
 		} else {
 			/* ATA PIO protocol */
 			if (unlikely((status & ATA_DRQ) == 0)) {
+				ata_dev_printk(qc->dev, KERN_INFO,
+					       "XXX status=0x%x\n", status);
 				/* handle BSY=0, DRQ=0 as error */
 				if (likely(status & (ATA_ERR | ATA_DF)))
 					/* device stops HSM for abort/error */

--------------000501020803090008030505--
