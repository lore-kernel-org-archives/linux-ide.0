From: ashish kalra <ashish.kalra@freescale.com>
Subject: [PATCH][v2] sata_fsl: Add asynchronous notification support
Date: Mon, 29 Jun 2009 20:46:34 +0530 (India Standard Time)
Message-ID: <Pine.WNT.4.64.0906292044150.5480@B00888-02.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:38842 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZF2PQe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jun 2009 11:16:34 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n5TFGbQc013014
	for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2009 08:16:38 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net [10.232.192.5])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n5TFGZBP004908
	for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2009 10:16:36 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org

Enable device hot-plug support on Port multiplier fan-out ports

Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
---
  drivers/ata/sata_fsl.c |   10 ++++++++--
  1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 94eaa43..5751145 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -34,7 +34,7 @@ enum {

  	SATA_FSL_HOST_FLAGS	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
  				ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				ATA_FLAG_PMP | ATA_FLAG_NCQ),
+ 				ATA_FLAG_PMP | ATA_FLAG_NCQ | ATA_FLAG_AN),

  	SATA_FSL_MAX_CMDS	= SATA_FSL_QUEUE_DEPTH,
  	SATA_FSL_CMD_HDR_SIZE	= 16,	/* 4 DWORDS */
@@ -132,7 +132,7 @@ enum {
  	INT_ON_SINGL_DEVICE_ERR = (1 << 1),
  	INT_ON_CMD_COMPLETE = 1,

-	INT_ON_ERROR = INT_ON_FATAL_ERR |
+	INT_ON_ERROR = INT_ON_FATAL_ERR | INT_ON_SNOTIFY_UPDATE |
  	    INT_ON_PHYRDY_CHG | INT_ON_SINGL_DEVICE_ERR,

  	/*
@@ -154,6 +154,7 @@ enum {

  	DEFAULT_PORT_IRQ_ENABLE_MASK = IE_ON_FATAL_ERR | IE_ON_PHYRDY_CHG |
  	    IE_ON_SIGNATURE_UPDATE |
+	    IE_ON_SNOTIFY_UPDATE |
  	    IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,

  	EXT_INDIRECT_SEG_PRD_FLAG = (1 << 31),
@@ -1003,6 +1004,11 @@ static void sata_fsl_error_intr(struct ata_port *ap)
  		freeze = 1;
  	}

+	/* Handle SDB FIS receive & notify update */
+	if (hstatus & INT_ON_SNOTIFY_UPDATE) {
+		sata_async_notification(ap);
+	}
+
  	/* Handle PHYRDY change notification */
  	if (hstatus & INT_ON_PHYRDY_CHG) {
  		DPRINTK("SATA FSL: PHYRDY change indication\n");
-- 
1.6.0


