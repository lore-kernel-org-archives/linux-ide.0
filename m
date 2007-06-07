From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/6] libata: support PIO multi commands
Date: Thu, 07 Jun 2007 15:49:22 +0800
Message-ID: <4667B882.6080606@tw.ibm.com>
References: <4667B767.5060601@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:44226 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbXFGHt1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jun 2007 03:49:27 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l577nRkO014489
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 03:49:27 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l577nRin269134
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:49:27 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l577nQ0a009870
	for <linux-ide@vger.kernel.org>; Thu, 7 Jun 2007 01:49:27 -0600
In-Reply-To: <4667B767.5060601@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 2/6:
  support the pass through of PIO multi commands.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

diff -Nrup 01_protocol_update/drivers/ata/libata-scsi.c 02_pio_multi/drivers/ata/libata-scsi.c
--- 01_protocol_update/drivers/ata/libata-scsi.c	2007-06-07 11:38:50.000000000 +0800
+++ 02_pio_multi/drivers/ata/libata-scsi.c	2007-06-07 11:38:53.000000000 +0800
@@ -2551,10 +2551,6 @@ static unsigned int ata_scsi_pass_thru(s
 	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0)
 		goto invalid_fld;
 
-	if (cdb[1] & 0xe0)
-		/* PIO multi not supported yet */
-		goto invalid_fld;
-
 	/*
 	 * 12 and 16 byte CDBs use different offsets to
 	 * provide the various register values.
@@ -2606,6 +2602,22 @@ static unsigned int ata_scsi_pass_thru(s
 		tf->device = qc->dev->devno ?
 			tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;
 
+	/* sanity check for pio multi commands */
+	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf))
+		goto invalid_fld;
+
+	if (is_multi_taskfile(tf)) {
+		unsigned int multi_count = 1 << (cdb[1] >> 5);
+
+		/* compare the passed through multi_count
+		 * with the cached multi_count of libata
+		 */
+		if (multi_count != dev->multi_count)
+			ata_dev_printk(dev, KERN_WARNING,
+				       "invalid multi_count %u ignored\n",
+				       multi_count);
+	}	
+
 	/* READ/WRITE LONG use a non-standard sect_size */
 	qc->sect_size = ATA_SECT_SIZE;
 	switch (tf->command) {
diff -Nrup 01_protocol_update/include/linux/ata.h 02_pio_multi/include/linux/ata.h
--- 01_protocol_update/include/linux/ata.h	2007-06-01 12:08:32.000000000 +0800
+++ 02_pio_multi/include/linux/ata.h	2007-06-06 13:34:05.000000000 +0800
@@ -249,7 +249,7 @@ enum ata_tf_protocols {
 	/* ATA taskfile protocols */
 	ATA_PROT_UNKNOWN,	/* unknown/invalid */
 	ATA_PROT_NODATA,	/* no data */
-	ATA_PROT_PIO,		/* PIO single sector */
+	ATA_PROT_PIO,		/* PIO data xfer */
 	ATA_PROT_DMA,		/* DMA */
 	ATA_PROT_NCQ,		/* NCQ */
 	ATA_PROT_ATAPI,		/* packet command, PIO data xfer*/


