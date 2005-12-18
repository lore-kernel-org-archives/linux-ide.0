From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/14] ahci: add constants for SRST
Date: Sun, 18 Dec 2005 22:51:10 +0900
Message-ID: <20051218135110.GN31571@htj.dyndns.org>
References: <20051218133305.GA31571@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:4788 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965135AbVLRNvP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Dec 2005 08:51:15 -0500
Received: by zproxy.gmail.com with SMTP id 14so1716461nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 05:51:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051218133305.GA31571@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, liml@rtr.ca
Cc: linux-ide@vger.kernel.org

Add constants needed to perform SRST.  This is preparation for adding
softreset method.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-12-18 20:11:01.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-12-18 20:12:01.000000000 +0900
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
