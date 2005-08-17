From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 08/08] sil24: add more comments for constants
Date: Wed, 17 Aug 2005 13:09:18 +0900 (KST)
Message-ID: <20050817040611.5942DE2E@htj.dyndns.org>
References: <20050817040611.C0A53974@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.194]:24084 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750835AbVHQEJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 00:09:23 -0400
Received: by wproxy.gmail.com with SMTP id i2so85514wra
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 21:09:22 -0700 (PDT)
In-Reply-To: <20050817040611.C0A53974@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com, Carlos.Pardo@siliconimage.com
Cc: linux-ide@vger.kernel.org

08_sil24_add-comments-for-constants.patch

	Add more comments to constants.

Signed-off-by: Edward Falk

 sata_sil24.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-08-17 13:06:08.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-08-17 13:06:09.000000000 +0900
@@ -107,14 +107,14 @@ enum {
 
 	PORT_PM			= 0x0f80, /* 8 bytes PM * 16 (128 bytes) */
 		/* 32 bit regs */
-	PORT_CTRL_STAT		= 0x1000, /* write:ctrl, read:stat */
-	PORT_CTRL_CLR		= 0x1004,
-	PORT_IRQ_STAT		= 0x1008,
-	PORT_IRQ_ENABLE_SET	= 0x1010,
-	PORT_IRQ_ENABLE_CLR	= 0x1014,
+	PORT_CTRL_STAT		= 0x1000, /* write: ctrl-set, read: stat */
+	PORT_CTRL_CLR		= 0x1004, /* write: ctrl-clear */
+	PORT_IRQ_STAT		= 0x1008, /* high: status, low: interrupt */
+	PORT_IRQ_ENABLE_SET	= 0x1010, /* write: enable-set */
+	PORT_IRQ_ENABLE_CLR	= 0x1014, /* write: enable-clear */
 	PORT_ACTIVATE_UPPER_ADDR= 0x101c,
-	PORT_EXEC_FIFO		= 0x1020,
-	PORT_CMD_ERR		= 0x1024,
+	PORT_EXEC_FIFO		= 0x1020, /* command execution fifo */
+	PORT_CMD_ERR		= 0x1024, /* command error number */
 	PORT_FIS_CFG		= 0x1028,
 	PORT_FIFO_THRES		= 0x102c,
 		/* 16 bit regs */
@@ -187,7 +187,7 @@ enum {
 	PORT_CERR_XFR_TGTABRT	= 33, /* PSD ecode 01 - target abort */
 	PORT_CERR_XFR_MSGABRT	= 34, /* PSD ecode 10 - master abort */
 	PORT_CERR_XFR_PCIPERR	= 35, /* PSD ecode 11 - PCI prity err during transfer */
-	PORT_CERR_SENDSERVICE	= 36, /* FIS received whiel sending service */
+	PORT_CERR_SENDSERVICE	= 36, /* FIS received while sending service */
 
 	/*
 	 * Other constants

