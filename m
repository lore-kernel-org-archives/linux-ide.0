From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/3] libata-dev: Fix pdc2027x ATAPI DMA lost irq problem
Date: Fri, 05 Aug 2005 01:39:57 +0800
Message-ID: <42F252ED.8020206@tw.ibm.com>
References: <42F24DBE.0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080409070505080803050603"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:23534 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261821AbVHDRk6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Aug 2005 13:40:58 -0400
In-Reply-To: <42F24DBE.0@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This is a multi-part message in MIME format.
--------------080409070505080803050603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

Patch 3/3: Fix pdc2027x ATAPI DMA lost irq problem

Description:
   Sometimes pdc2027x will lost irq after ATAPI DMA data transfer.
   With the previous rule (cmd->request_bufflen % 256), the ATAPI DMA irq lost
problem still occurs during the test.

   Root cause for the irq lost is unknown. I've tried your ATAPI DMA alignment
patch, but the problem still occurs, even the buffer is aligned. I guess it is pdc2027x hardware problem.

   The following workarounds are adapted from the Promise pdc618 GPL driver.
They seems know about the problem and has the workaround.

Changes:
   - Only turn on ATAPI DMA for READ, WRITE, READ_CD and READ_DVD_STRUCTURE commands.
   - For WRITE_10, if LBA -45150 (FFFF4FA2h) to  -1 (FFFFFFFFh) then use PIO mode.

For your review, thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>




--------------080409070505080803050603
Content-Type: text/plain;
 name="pdc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc3.diff"

--- 02_pdc_micro/drivers/scsi/pata_pdc2027x.c	2005-08-03 15:44:16.000000000 +0800
+++ 03_pdc_atapi_dma/drivers/scsi/pata_pdc2027x.c	2005-08-05 00:41:53.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.71"
+#define DRV_VERSION	"0.72"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -467,11 +467,40 @@
 static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
-	int rc = 0;
+	u8 *scsicmd = cmd->cmnd;
+	int rc = 1; /* atapi dma off by default */
+	u32 lba;
 
-	/* pdc2027x can only do ATAPI DMA for specific buffer size */
-	if (cmd->request_bufflen % 256)
-		rc = 1;
+	/*
+	 * pdc2027x might lost irq if ATAPI DMA is used
+	 * for commands not in the white list.
+	 */
+	switch (scsicmd[0]) {
+	case READ_10:
+	case READ_12:
+	case READ_6:
+	case WRITE_12:
+	case WRITE_6:
+	case 0xad: /* READ_DVD_STRUCTURE */
+	case 0xbe: /* READ_CD */
+		/* ATAPI DMA is ok */
+		rc = 0;
+		break;
+	case WRITE_10:
+		/* LBA -45150 (FFFF4FA2h) to 
+		 * -1 (FFFFFFFFh) shall use PIO mode
+		 */
+		lba = (scsicmd[2] << 24) | (scsicmd[3] << 16) |
+			(scsicmd[4] << 8) | scsicmd[5]; 
+
+		if (lba < 0xffff4fa2)
+			/* ATAPI DMA is ok */
+			rc = 0;
+
+		break;
+	default:
+		;
+	}
 
 	return rc;
 }

--------------080409070505080803050603--


