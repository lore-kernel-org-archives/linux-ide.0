From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: add constants for SRST
Date: Mon, 23 Jan 2006 21:38:44 +0900
Message-ID: <20060123123844.GA21601@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.207]:42787 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964875AbWAWSpY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2006 13:45:24 -0500
Received: by wproxy.gmail.com with SMTP id i3so862109wra
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2006 10:45:24 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Add constants needed to perform SRST.  This is preparation for adding
softreset method.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work1/drivers/scsi/ahci.c
===================================================================
--- work1.orig/drivers/scsi/ahci.c	2006-01-23 21:37:39.000000000 +0900
+++ work1/drivers/scsi/ahci.c	2006-01-23 21:37:55.000000000 +0900
@@ -66,6 +66,8 @@ enum {
 	AHCI_IRQ_ON_SG		= (1 << 31),
 	AHCI_CMD_ATAPI		= (1 << 5),
 	AHCI_CMD_WRITE		= (1 << 6),
+	AHCI_CMD_RESET		= (1 << 8),
+	AHCI_CMD_CLR_BUSY	= (1 << 10),
 
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
 
@@ -85,6 +87,7 @@ enum {
 
 	/* HOST_CAP bits */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -138,6 +141,7 @@ enum {
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
 	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
+	PORT_CMD_CLO		= (1 << 3), /* Command list override */
 	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
 	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
 	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
