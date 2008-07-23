From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/7] ata: add missing ATA_CMD_* defines
Date: Wed, 23 Jul 2008 20:40:18 +0200
Message-ID: <200807232040.18264.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:1624 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbYGWSuP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 14:50:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1201286fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 23 Jul 2008 11:50:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>, Jeff Garzik <jeff@garzik.org>

Add missing ATA_CMD_* defines to <linux/ata.h>.  Also add
ATA_EXABYTE_ENABLE_NEST, SETFEATURES_AAM_* and ATA_SMART_*
defines while at it.

Partially based on earlier work by Chris Wedgwood.

Cc: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ata.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: b/include/linux/ata.h
===================================================================
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -222,6 +222,13 @@ enum {
 	ATA_CMD_PMP_WRITE	= 0xE8,
 	ATA_CMD_CONF_OVERLAY	= 0xB1,
 	ATA_CMD_SEC_FREEZE_LOCK	= 0xF5,
+	ATA_CMD_SMART		= 0xB0,
+	ATA_CMD_MEDIA_LOCK	= 0xDE,
+	ATA_CMD_MEDIA_UNLOCK	= 0xDF,
+	/* marked obsolete in the ATA/ATAPI-7 spec */
+	ATA_CMD_RESTORE		= 0x10,
+	/* EXABYTE specific */
+	ATA_EXABYTE_ENABLE_NEST	= 0xF0,
 
 	/* READ_LOG_EXT pages */
 	ATA_LOG_SATA_NCQ	= 0x10,
@@ -262,6 +269,10 @@ enum {
 	SETFEATURES_WC_ON	= 0x02, /* Enable write cache */
 	SETFEATURES_WC_OFF	= 0x82, /* Disable write cache */
 
+	/* Enable/Disable Automatic Acoustic Management */
+	SETFEATURES_AAM_ON	= 0x42,
+	SETFEATURES_AAM_OFF	= 0xC2,
+
 	SETFEATURES_SPINUP	= 0x07, /* Spin-up drive */
 
 	SETFEATURES_SATA_ENABLE = 0x10, /* Enable use of SATA feature */
@@ -284,6 +295,15 @@ enum {
 	ATA_DCO_IDENTIFY	= 0xC2,
 	ATA_DCO_SET		= 0xC3,
 
+	/* feature values for SMART */
+	ATA_SMART_ENABLE	= 0xD8,
+	ATA_SMART_READ_VALUES	= 0xD0,
+	ATA_SMART_READ_THRESHOLDS = 0xD1,
+
+	/* password used in LBA Mid / LBA High for executing SMART commands */
+	ATA_SMART_LBAM_PASS	= 0x4F,
+	ATA_SMART_LBAH_PASS	= 0xC2,
+
 	/* ATAPI stuff */
 	ATAPI_PKT_DMA		= (1 << 0),
 	ATAPI_DMADIR		= (1 << 2),	/* ATAPI data dir:
