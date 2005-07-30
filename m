From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 05/07] sil24: use longer delay function and less iteration in reset_controller
Date: Sat, 30 Jul 2005 19:14:18 +0900 (KST)
Message-ID: <20050730101344.241DEAE1@htj.dyndns.org>
References: <20050730101344.1C985988@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.194]:60544 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263042AbVG3KOY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2005 06:14:24 -0400
Received: by rproxy.gmail.com with SMTP id r35so1085940rna
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2005 03:14:22 -0700 (PDT)
In-Reply-To: <20050730101344.1C985988@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

05_sil24_mdelay-instead-of-udelay.patch

	loop 100 times with mdelay(1) instead of 1000 times with
	udelay(100) in sil24_reset_controller.

	Jeff, is this what you wanted?  If not, just ignore this
	patch.  The following patches will apply without this one.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-07-30 19:13:40.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-07-30 19:13:40.000000000 +0900
@@ -445,9 +445,13 @@ static void sil24_reset_controller(struc
 	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
 	readl(port + PORT_CTRL_STAT);	/* sync */
 
-	/* Max ~100ms */
-	for (cnt = 0; cnt < 1000; cnt++) {
-		udelay(100);
+	/*
+	 * Max ~100ms.
+	 * FIXME: 100ms is an arbitrary value, get spec and use
+	 *        accurate value.
+	 */
+	for (cnt = 0; cnt < 100; cnt++) {
+		mdelay(1);
 		tmp = readl(port + PORT_CTRL_STAT);
 		if (!(tmp & PORT_CS_DEV_RST))
 			break;

