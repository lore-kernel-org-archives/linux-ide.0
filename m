From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata-dev-2.6: pdc2027x ATAPI DMA fix
Date: Tue, 19 Apr 2005 14:08:23 +0800
Message-ID: <4264A057.9020604@tw.ibm.com>
References: <425A49F6.3040904@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070601030204050108090307"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:6629 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261230AbVDSGI4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Apr 2005 02:08:56 -0400
In-Reply-To: <425A49F6.3040904@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070601030204050108090307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff,

   pdc2027x: pdc2027x ATAPI DMA fix.
The previous (request_bufflen % 256) ATAPI DMA rule still fails and causes timeout in some case.

Changes:
- Only turn on pdc2027x ATAPI DMA for READ/WRITE and (request_bufflen % 1024 == 0) for safty.

Attached please find the patch against the libata-dev-2.6 tree for your review. Thanks.

Albert

--------------070601030204050108090307
Content-Type: text/plain;
 name="pdc_061.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc_061.diff"

--- libata-dev-2.6-pll-fix/drivers/scsi/pata_pdc2027x.c	2005-04-11 15:05:42.000000000 +0800
+++ libata-dev-2.6-dma_fix/drivers/scsi/pata_pdc2027x.c	2005-04-16 08:59:34.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.60"
+#define DRV_VERSION	"0.61"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -445,11 +445,26 @@
 static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
-	int rc = 0;
+	u8 *scsicmd = cmd->cmnd;
+	int rc = 1; /* atapi dma off by default */
 
-	/* pdc2027x can only do ATAPI DMA for specific buffer size */
-	if (cmd->request_bufflen % 256)
-		rc = 1;
+	switch (scsicmd[0]) {
+	case READ_6:
+	case READ_10:
+	case READ_12:
+	case READ_16:
+
+	case WRITE_6:
+	case WRITE_10:
+	case WRITE_12:
+	case WRITE_16:
+		/* pdc2027x can only do ATAPI DMA for specific buffer size */
+		if (cmd->request_bufflen % 1024 == 0)
+			rc = 0;
+		break;
+	default:
+		;
+	}
 
 	return rc;
 }

--------------070601030204050108090307--


