From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sil24: add constants
Date: Wed, 16 Nov 2005 16:56:49 +0900
Message-ID: <20051116075649.GA22807@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:22214 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030213AbVKPH44 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 02:56:56 -0500
Received: by zproxy.gmail.com with SMTP id 13so1709577nzn
        for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2005 23:56:56 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Adds constants for ATAPI support to sata_sil24.  This patch is
originally from Jeff Garzik <jgarzik@pobox.com>.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-11-16 16:40:50.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-11-16 16:54:10.000000000 +0900
@@ -139,6 +139,7 @@ enum {
 	PORT_CS_DEV_RST		= (1 << 1), /* device reset */
 	PORT_CS_INIT		= (1 << 2), /* port initialize */
 	PORT_CS_IRQ_WOC		= (1 << 3), /* interrupt write one to clear */
+	PORT_CS_CDB16		= (1 << 5), /* 0=12b cdb, 1=16b cdb */
 	PORT_CS_RESUME		= (1 << 6), /* port resume */
 	PORT_CS_32BIT_ACTV	= (1 << 10), /* 32-bit activation */
 	PORT_CS_PM_EN		= (1 << 13), /* port multiplier enable */
@@ -188,11 +189,29 @@ enum {
 	PORT_CERR_XFR_PCIPERR	= 35, /* PSD ecode 11 - PCI prity err during transfer */
 	PORT_CERR_SENDSERVICE	= 36, /* FIS received while sending service */
 
+	/* bits of PRB control field */
+	PRB_CTRL_PROTOCOL	= (1 << 0), /* override def. ATA protocol */
+	PRB_CTRL_PACKET_READ	= (1 << 4), /* PACKET cmd read */
+	PRB_CTRL_PACKET_WRITE	= (1 << 5), /* PACKET cmd write */
+	PRB_CTRL_NIEN		= (1 << 6), /* Mask completion irq */
+	PRB_CTRL_SRST		= (1 << 7), /* Soft reset request (ign BSY?) */
+
+	/* PRB protocol field */
+	PRB_PROT_PACKET		= (1 << 0),
+	PRB_PROT_TCQ		= (1 << 1),
+	PRB_PROT_NCQ		= (1 << 2),
+	PRB_PROT_READ		= (1 << 3),
+	PRB_PROT_WRITE		= (1 << 4),
+	PRB_PROT_TRANSPARENT	= (1 << 5),
+
 	/*
 	 * Other constants
 	 */
 	SGE_TRM			= (1 << 31), /* Last SGE in chain */
-	PRB_SOFT_RST		= (1 << 7),  /* Soft reset request (ign BSY?) */
+	SGE_LNK			= (1 << 30), /* linked list
+						Points to SGT, not SGE */
+	SGE_DRD			= (1 << 29), /* discard data read (/dev/null)
+						data address ignored */
 
 	/* board id */
 	BID_SIL3124		= 0,
