From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 07/08] sil24: fix PORT_CTRL_STAT constants
Date: Wed, 17 Aug 2005 13:09:13 +0900 (KST)
Message-ID: <20050817040611.82EFEB59@htj.dyndns.org>
References: <20050817040611.C0A53974@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:19222 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750836AbVHQEJ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 00:09:26 -0400
Received: by wproxy.gmail.com with SMTP id i2so85511wra
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 21:09:20 -0700 (PDT)
In-Reply-To: <20050817040611.C0A53974@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com, Carlos.Pardo@siliconimage.com
Cc: linux-ide@vger.kernel.org

07_sil24_fix-PORT_CTRL_STAT-constants.patch

	PORT_CTRL_STAT constants were copied incorrectly from the
	preview driver.

Signed-off-by: Edward Falk

 sata_sil24.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-08-17 13:06:08.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-08-17 13:06:08.000000000 +0900
@@ -140,10 +140,10 @@ enum {
 	PORT_CS_DEV_RST		= (1 << 1), /* device reset */
 	PORT_CS_INIT		= (1 << 2), /* port initialize */
 	PORT_CS_IRQ_WOC		= (1 << 3), /* interrupt write one to clear */
-	PORT_CS_RESUME		= (1 << 4), /* port resume */
-	PORT_CS_32BIT_ACTV	= (1 << 5), /* 32-bit activation */
-	PORT_CS_PM_EN		= (1 << 6), /* port multiplier enable */
-	PORT_CS_RDY		= (1 << 7), /* port ready to accept commands */
+	PORT_CS_RESUME		= (1 << 6), /* port resume */
+	PORT_CS_32BIT_ACTV	= (1 << 10), /* 32-bit activation */
+	PORT_CS_PM_EN		= (1 << 13), /* port multiplier enable */
+	PORT_CS_RDY		= (1 << 31), /* port ready to accept commands */
 
 	/* PORT_IRQ_STAT/ENABLE_SET/CLR */
 	/* bits[11:0] are masked */

