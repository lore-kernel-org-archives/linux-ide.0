From: Pat LaVarre <p.lavarre@ieee.org>
Subject: [PATCH] SATAPI despite no data
Date: 23 Jul 2004 12:51:49 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1090608709.3264.12.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:37820 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S267886AbUGWSv7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jul 2004 14:51:59 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

Please may we restore the source line quoted below?

I see we lost this source line in the changes since 2.6.7.  But if I try
SATAPI expecting no data without this source line, then my ata_piix.ko
promptly dies with such complaints as:

kernel: irq 18: nobody cared!

With this source line, I find I can expect no data, though I still have
to add auto sense to overcome:

kernel: ata2: BUG: timeout without command

I've placed this source line so that (a) we equate case ATA_PROT_ATAPI
with case ATA_PROT_ATAPI_DMA.  I could easily instead (b) write case
ATA_PROT_ATAPI as an isolated case or I could (c) try to write case
ATA_PROT_ATAPI as equal with case ATA_PROT_NODATA, if by chance you do
prefer (b) or (c).

Pat LaVarre

diff -urp linux-2.6.8-rc2-bk2/drivers/scsi/libata-core.c linux-2.6.8-rc2-bk2-pel/drivers/scsi/libata-core.c
--- linux-2.6.8-rc2-bk2/drivers/scsi/libata-core.c	2004-07-23 11:53:35.000000000 -0600
+++ linux-2.6.8-rc2-bk2-pel/drivers/scsi/libata-core.c	2004-07-23 12:29:22.000000000 -0600
@@ -2578,6 +2578,7 @@ inline unsigned int ata_host_intr (struc
 
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
+	case ATA_PROT_ATAPI:
 		/* check status of DMA engine */
 		host_stat = ata_bmdma_status(ap);
 		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);


