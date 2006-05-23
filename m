From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: minor fix for irq-pio merge
Date: Tue, 23 May 2006 18:12:30 +0800
Message-ID: <4472E00E.30000@tw.ibm.com>
References: <11473544042174-git-send-email-htejun@gmail.com> <4472DE75.6010507@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:38851 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932166AbWEWKM3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 May 2006 06:12:29 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4NACTcu002899
	for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 06:12:29 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4NACSXb264254
	for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 04:12:28 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4NACS3x020384
	for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 04:12:28 -0600
In-Reply-To: <4472DE75.6010507@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Minor fix to put the ATA_FLAG_NO_ATAPI flag back.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
The ATA_FLAG_NO_ATAPI flag seems lost by auto merge.

In addtional to the lost ATA_FLAG_NO_ATAPI flag, there is a
extra if() block in sata_vsc.c which is not related to libata.
Maybe it is from somewhere else?

Patch against the libata-dev upstream branch
(b74ba22f030eb7ab88f7d8954ad18ecc0ac5ce3c).

diff -Nrup upstream0/drivers/scsi/sata_mv.c minor_fix/drivers/scsi/sata_mv.c
--- upstream0/drivers/scsi/sata_mv.c	2006-05-23 17:46:51.000000000 +0800
+++ minor_fix/drivers/scsi/sata_mv.c	2006-05-23 17:51:32.000000000 +0800
@@ -93,7 +93,7 @@ enum {
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
 	MV_COMMON_FLAGS		= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
-				   ATA_FLAG_PIO_POLLING),
+				   ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING),
 	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
 
 	CRQB_FLAG_READ		= (1 << 0),
diff -Nrup upstream0/drivers/scsi/sata_sx4.c minor_fix/drivers/scsi/sata_sx4.c
--- upstream0/drivers/scsi/sata_sx4.c	2006-05-23 17:46:51.000000000 +0800
+++ minor_fix/drivers/scsi/sata_sx4.c	2006-05-23 17:52:10.000000000 +0800
@@ -218,7 +218,7 @@ static const struct ata_port_info pdc_po
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  ATA_FLAG_PIO_POLLING,
+				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */


