From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/3] libata-dev: pdc2027x ATAPI DMA lost irq problem workaround
Date: Fri, 12 Aug 2005 15:23:39 +0800
Message-ID: <42FC4E7B.9030503@tw.ibm.com>
References: <42FC4B36.9080805@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090909090000040306000505"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:45565 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S1751150AbVHLHYL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Aug 2005 03:24:11 -0400
In-Reply-To: <42FC4B36.9080805@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------090909090000040306000505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

Patch 3/3: pdc2027x ATAPI DMA lost irq problem workaround

Description:
   Sometimes pdc2027x will lost irq after ATAPI DMA data transfer.
   With the previous workaround (cmd->request_bufflen % 256), the ATAPI DMA irq lost
problem still occurs during the test.

   Root cause for the irq lost is unknown yet. I've tried your ATAPI DMA alignment
patch, but the problem still occurs, even the buffer is aligned. I guess it is pdc2027x hardware problem.

   The following workarounds are adapted from the Promise pdc618 GPL driver.
They seem know about the problem and have the workarounds.

   In the Promise driver, there are 2 workarounds:
1. Only turn on ATAPI DMA for READ, WRITE, READ_CD and READ_DVD_STRUCTURE commands in the white list.
2. For WRITE_10, if LBA -45150 (FFFF4FA2h) to  -1 (FFFFFFFFh) then use PIO mode.
However, I've done some test. The negative LBA check seems not needed for pdc2027x.
So, only the command white list workaround is included in this patch.

Changes:
   - Only turn on ATAPI DMA for READ, WRITE, READ_CD and READ_DVD_STRUCTURE commands.

Tested OK on x86 + pdc20275 + Liteon CD-RW SOHR-5238S and LG DVDRAM GSA-4163B.

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


--------------090909090000040306000505
Content-Type: text/plain;
 name="pdc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc3.diff"

--- 02_pdc_long/drivers/scsi/pata_pdc2027x.c	2005-08-12 11:39:32.000000000 +0800
+++ 03_pdc_lost_irq/drivers/scsi/pata_pdc2027x.c	2005-08-12 15:04:09.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.71"
+#define DRV_VERSION	"0.72"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -467,11 +467,30 @@
 static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
-	int rc = 0;
+	u8 *scsicmd = cmd->cmnd;
+	int rc = 1; /* atapi dma off by default */
 
-	/* pdc2027x can only do ATAPI DMA for specific buffer size */
-	if (cmd->request_bufflen % 256)
-		rc = 1;
+	/*
+	 * This workaround is from Promise's GPL driver.
+	 * If ATAPI DMA is used for commands not in the 
+	 * following white list, say MODE_SENSE and REQUEST_SENSE,
+	 * pdc2027x might hit the irq lost problem.
+	 */
+	switch (scsicmd[0]) {
+	case READ_10:
+	case WRITE_10:
+	case READ_12:
+	case WRITE_12:
+	case READ_6:
+	case WRITE_6:
+	case 0xad: /* READ_DVD_STRUCTURE */
+	case 0xbe: /* READ_CD */
+		/* ATAPI DMA is ok */
+		rc = 0;
+		break;
+	default:
+		;
+	}
 
 	return rc;
 }

--------------090909090000040306000505--


