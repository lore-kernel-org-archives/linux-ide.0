From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] ata_check_bmdma
Date: 03 Jun 2004 07:41:14 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086270073.6502.27.camel@patibmrh9>
References: <1086224765.4401.3.camel@patibmrh9> <40BE7A53.8020908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:25558 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263641AbUFCNlW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Jun 2004 09:41:22 -0400
In-Reply-To: <40BE7A53.8020908@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

> applied to 2.4 and 2.6

Thank you.

> ...

What comes next?

Shall we add support for SATAPI Data Not, for example op x00 "TEST UNIT
READY", to the support we have already for SATAPI Data In and SATAPI
Data Out?

As you may recall, when I try Data Not here, I get "kernel: Disabling
IRQ" with the source as is.  After applying the ata_check_bmdma patch,
then a patch like the following three lines seem to help.  Without
understanding, I think I'm seeing:

1) We have to ack an ATA_DMA_INTR even when we have copied no data.

2) We VPRINTK the host_stat although we DPRINTK the drv_stat.

Pat LaVarre

P.S. Would you prefer a patch that acked ATA_DMA_INTR without clearing
ATA_DMA_ERR and ATA_DMA_START?

diff -urp o/include/linux/ata.h linux-2.6.7-rc2-pel/include/linux/ata.h
diff -urp o/include/linux/libata.h linux-2.6.7-rc2-pel/include/linux/libata.h
diff -urp o/drivers/scsi/libata-core.c linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c
--- o/drivers/scsi/libata-core.c	2004-06-03 07:18:39.000000000 -0600
+++ linux-2.6.7-rc2-pel/drivers/scsi/libata-core.c	2004-06-03 07:20:22.694466800 -0600
@@ -2656,9 +2656,11 @@ inline unsigned int ata_host_intr (struc
 	 */
 	case ATA_PROT_ATAPI:
 	case ATA_PROT_NODATA:
+		host_stat = ata_check_bmdma(ap);
+		VPRINTK("BUS_NODATA (host_stat 0x%X)\n", host_stat);
 		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
-		ata_qc_complete(qc, status);
+		ata_dma_complete(qc, host_stat);
 		handled = 1;
 		break;
 
diff -urp o/drivers/scsi/libata-scsi.c linux-2.6.7-rc2-pel/drivers/scsi/libata-scsi.c


