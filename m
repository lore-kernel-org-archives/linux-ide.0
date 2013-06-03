From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] sata_rcar: fix compilation warning in sata_rcar_thaw()
Date: Mon, 3 Jun 2013 22:19:58 +0400
Message-ID: <201306032219.59210.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:52104 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759657Ab3FCSUC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jun 2013 14:20:02 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so1438264lbd.15
        for <linux-ide@vger.kernel.org>; Mon, 03 Jun 2013 11:20:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org

When compiling the driver with gcc 4.8, it gives the following warning:

drivers/ata/sata_rcar.c: In function `sata_rcar_thaw':
drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly truncated to
unsigned type [-Woverflow]

Fix the warning by explicit cast of the 'unsigned long' value to 'u32'.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'for-3.10-fixes' branch of Tejun Heo's 'libata.git' repo.
Tejun, does it fix the warning for you?

 drivers/ata/sata_rcar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: libata/drivers/ata/sata_rcar.c
===================================================================
--- libata.orig/drivers/ata/sata_rcar.c
+++ libata/drivers/ata/sata_rcar.c
@@ -180,7 +180,7 @@ static void sata_rcar_thaw(struct ata_po
 	struct sata_rcar_priv *priv = ap->host->private_data;
 
 	/* ack */
-	iowrite32(~SATA_RCAR_INT_MASK, priv->base + SATAINTSTAT_REG);
+	iowrite32(~(u32)SATA_RCAR_INT_MASK, priv->base + SATAINTSTAT_REG);
 
 	ata_sff_thaw(ap);
 
