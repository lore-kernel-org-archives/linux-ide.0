From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Fri, 17 Mar 2006 17:26:34 +0800
Message-ID: <441A80CA.6080407@tw.ibm.com>
References: <1142344212.4416ca14a26b4@webmail.aon.at> <44182CD7.9070401@rtr.ca> <20060316100838.GF3595@suse.de> <441A4873.3030102@rtr.ca>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:14821 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752580AbWCQJ05
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Mar 2006 04:26:57 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2H9QpFp027561
	for <linux-ide@vger.kernel.org>; Fri, 17 Mar 2006 04:26:51 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2H9NvIX195168
	for <linux-ide@vger.kernel.org>; Fri, 17 Mar 2006 02:23:57 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2H9QoQE003098
	for <linux-ide@vger.kernel.org>; Fri, 17 Mar 2006 02:26:51 -0700
In-Reply-To: <441A4873.3030102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, me_trash1@aon.at, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jens Axboe wrote:
> 
>> On Wed, Mar 15 2006, Mark Lord wrote:
> 
> ..
> 
>>> ATA cmd=0x35 is ATA_CMD_WRITE_EXT, and 0x25 (lower down in the logs)
>>> is ATA_CMD_READ_EXT.
>>>
>>> Those are the bog-standard (and slow!) PIO R/W commands,
>>> which generate one interrupt per 512-bytes transferred.
>>
>>
>> Eh no they are not, 0x35 is WRITEDMA_EXT and 0x25 is READMA_EXT.
> 
> 
> We're both correct, in that 0x35 is ATA_CMD_WRITE_EXT as I said.
> But the naming had me fooled -- they really are DMA commands,
> even if the linux/ata.h names are incomplete.
> 
 
How about the attached renaming patch?
It could make the command names more consistent to what's in the ATA/ATAPI spec.

---
Albert


Changes:

ATA_CMD_READ        => ATA_CMD_READ_DMA
ATA_CMD_WRITE       => ATA_CMD_WRITE_DMA
...
ATA_CMD_PIO_READ    => ATA_CMD_READ_PIO
ATA_CMD_PIO_WRITE   => ATA_CMD_WRITE_PIO
...
ATA_CMD_FPDMA_READ  => ATA_CMD_READ_FPDMA_QUEUED
ATA_CMD_FPDMA_WRITE => ATA_CMD_WRITE_FPDMA_QUEUED

--- upstream/include/linux/ata.h	2006-03-16 17:23:56.000000000 +0800
+++ rename/include/linux/ata.h	2006-03-17 17:08:53.000000000 +0800
@@ -125,15 +125,17 @@ enum {
 	ATA_CMD_FLUSH_EXT	= 0xEA,
 	ATA_CMD_ID_ATA		= 0xEC,
 	ATA_CMD_ID_ATAPI	= 0xA1,
-	ATA_CMD_READ		= 0xC8,
-	ATA_CMD_READ_EXT	= 0x25,
-	ATA_CMD_WRITE		= 0xCA,
-	ATA_CMD_WRITE_EXT	= 0x35,
-	ATA_CMD_WRITE_FUA_EXT	= 0x3D,
-	ATA_CMD_PIO_READ	= 0x20,
-	ATA_CMD_PIO_READ_EXT	= 0x24,
-	ATA_CMD_PIO_WRITE	= 0x30,
-	ATA_CMD_PIO_WRITE_EXT	= 0x34,
+	ATA_CMD_READ_DMA	= 0xC8,
+	ATA_CMD_READ_DMA_EXT	= 0x25,
+	ATA_CMD_WRITE_DMA	= 0xCA,
+	ATA_CMD_WRITE_DMA_EXT	= 0x35,
+	ATA_CMD_WRITE_DMA_FUA_EXT   = 0x3D,
+	ATA_CMD_READ_FPDMA_QUEUED   = 0x60,
+	ATA_CMD_WRITE_FPDMA_QUEUED  = 0x61,
+	ATA_CMD_READ_PIO	= 0x20,
+	ATA_CMD_READ_PIO_EXT	= 0x24,
+	ATA_CMD_WRITE_PIO	= 0x30,
+	ATA_CMD_WRITE_PIO_EXT	= 0x34,
 	ATA_CMD_READ_MULTI	= 0xC4,
 	ATA_CMD_READ_MULTI_EXT	= 0x29,
 	ATA_CMD_WRITE_MULTI	= 0xC5,
--- upstream/drivers/scsi/libata-core.c	2006-03-16 17:23:51.000000000 +0800
+++ rename/drivers/scsi/libata-core.c	2006-03-17 13:54:58.000000000 +0800
@@ -167,23 +167,23 @@ static const u8 ata_rw_cmds[] = {
 	0,
 	ATA_CMD_WRITE_MULTI_FUA_EXT,
 	/* pio */
-	ATA_CMD_PIO_READ,
-	ATA_CMD_PIO_WRITE,
-	ATA_CMD_PIO_READ_EXT,
-	ATA_CMD_PIO_WRITE_EXT,
+	ATA_CMD_READ_PIO,
+	ATA_CMD_WRITE_PIO,
+	ATA_CMD_READ_PIO_EXT,
+	ATA_CMD_WRITE_PIO_EXT,
 	0,
 	0,
 	0,
 	0,
 	/* dma */
-	ATA_CMD_READ,
-	ATA_CMD_WRITE,
-	ATA_CMD_READ_EXT,
-	ATA_CMD_WRITE_EXT,
+	ATA_CMD_READ_DMA,
+	ATA_CMD_WRITE_DMA,
+	ATA_CMD_READ_DMA_EXT,
+	ATA_CMD_WRITE_DMA_EXT,
 	0,
 	0,
 	0,
-	ATA_CMD_WRITE_FUA_EXT
+	ATA_CMD_WRITE_DMA_FUA_EXT
 };
 
 /**
--- upstream/drivers/scsi/sata_mv.c	2006-03-16 17:23:51.000000000 +0800
+++ rename/drivers/scsi/sata_mv.c	2006-03-17 17:09:31.000000000 +0800
@@ -1087,16 +1087,16 @@ static void mv_qc_prep(struct ata_queued
 	 * NCQ.  NCQ will drop hob_nsect.
 	 */
 	switch (tf->command) {
-	case ATA_CMD_READ:
-	case ATA_CMD_READ_EXT:
-	case ATA_CMD_WRITE:
-	case ATA_CMD_WRITE_EXT:
-	case ATA_CMD_WRITE_FUA_EXT:
+	case ATA_CMD_READ_DMA:
+	case ATA_CMD_READ_DMA_EXT:
+	case ATA_CMD_WRITE_DMA:
+	case ATA_CMD_WRITE_DMA_EXT:
+	case ATA_CMD_WRITE_DMA_FUA_EXT:
 		mv_crqb_pack_cmd(cw++, tf->hob_nsect, ATA_REG_NSECT, 0);
 		break;
 #ifdef LIBATA_NCQ		/* FIXME: remove this line when NCQ added */
-	case ATA_CMD_FPDMA_READ:
-	case ATA_CMD_FPDMA_WRITE:
+	case ATA_CMD_READ_FPDMA_QUEUED:
+	case ATA_CMD_WRITE_FPDMA_QUEUED:
 		mv_crqb_pack_cmd(cw++, tf->hob_feature, ATA_REG_FEATURE, 0);
 		mv_crqb_pack_cmd(cw++, tf->feature, ATA_REG_FEATURE, 0);
 		break;



