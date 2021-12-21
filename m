Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC22C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhLUHXH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52644 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AE07021941;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8X9aev/GOiPUr7ybBAWu9JyIAfHs4sNkdcynG64Hmn4=;
        b=sB7cjpvStKFXc/L+6/NKsCj9pVJ64CiHnwvkc2pOrThTnvLsPMBtfZ8x73MN/c1Iy7ujCa
        LmuZwvP3M5ocvrDL6YllIN57oUfLJELJYM3dFHbibH7KfAvk3XMBLjMyKb5LUTu/P3wmnc
        I0RAuzm2G6W2bTWsP5HZXcYiPzw9YuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8X9aev/GOiPUr7ybBAWu9JyIAfHs4sNkdcynG64Hmn4=;
        b=IaKTwY6490eympGk8LS85+gAoKjpCNAG7SrQDYHVD+imcnkCgkDx5u1F1hrsv1EZOy0i5c
        OYJguj5k2FeAWOAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A95E3A3BBD;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id A7B3B51923E8; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 59/68] sata_mv: convert remaining printk() to structured logging
Date:   Tue, 21 Dec 2021 08:21:22 +0100
Message-Id: <20211221072131.46673-60-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Refactor the .reset_hc() callback and convert the remaining printk()
calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_mv.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 7ce1fb635874..460cec571125 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -579,7 +579,7 @@ struct mv_hw_ops {
 	void (*enable_leds)(struct mv_host_priv *hpriv, void __iomem *mmio);
 	void (*read_preamp)(struct mv_host_priv *hpriv, int idx,
 			   void __iomem *mmio);
-	int (*reset_hc)(struct mv_host_priv *hpriv, void __iomem *mmio,
+	int (*reset_hc)(struct ata_host *host, void __iomem *mmio,
 			unsigned int n_hc);
 	void (*reset_flash)(struct mv_host_priv *hpriv, void __iomem *mmio);
 	void (*reset_bus)(struct ata_host *host, void __iomem *mmio);
@@ -606,7 +606,7 @@ static void mv5_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem *mmio);
 static void mv5_read_preamp(struct mv_host_priv *hpriv, int idx,
 			   void __iomem *mmio);
-static int mv5_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
+static int mv5_reset_hc(struct ata_host *host, void __iomem *mmio,
 			unsigned int n_hc);
 static void mv5_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio);
 static void mv5_reset_bus(struct ata_host *host, void __iomem *mmio);
@@ -616,14 +616,14 @@ static void mv6_phy_errata(struct mv_host_priv *hpriv, void __iomem *mmio,
 static void mv6_enable_leds(struct mv_host_priv *hpriv, void __iomem *mmio);
 static void mv6_read_preamp(struct mv_host_priv *hpriv, int idx,
 			   void __iomem *mmio);
-static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
+static int mv6_reset_hc(struct ata_host *host, void __iomem *mmio,
 			unsigned int n_hc);
 static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio);
 static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
 				      void __iomem *mmio);
 static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,
 				      void __iomem *mmio);
-static int mv_soc_reset_hc(struct mv_host_priv *hpriv,
+static int mv_soc_reset_hc(struct ata_host *host,
 				  void __iomem *mmio, unsigned int n_hc);
 static void mv_soc_reset_flash(struct mv_host_priv *hpriv,
 				      void __iomem *mmio);
@@ -3194,9 +3194,10 @@ static void mv5_reset_one_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 }
 #undef ZERO
 
-static int mv5_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
+static int mv5_reset_hc(struct ata_host *host, void __iomem *mmio,
 			unsigned int n_hc)
 {
+	struct mv_host_priv *hpriv = host->private_data;
 	unsigned int hc, port;
 
 	for (hc = 0; hc < n_hc; hc++) {
@@ -3255,7 +3256,7 @@ static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem *mmio)
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
+static int mv6_reset_hc(struct ata_host *host, void __iomem *mmio,
 			unsigned int n_hc)
 {
 	void __iomem *reg = mmio + PCI_MAIN_CMD_STS;
@@ -3275,7 +3276,7 @@ static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 			break;
 	}
 	if (!(PCI_MASTER_EMPTY & t)) {
-		printk(KERN_ERR DRV_NAME ": PCI master won't flush\n");
+		dev_err(host->dev, "PCI master won't flush\n");
 		rc = 1;
 		goto done;
 	}
@@ -3289,7 +3290,7 @@ static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 	} while (!(GLOB_SFT_RST & t) && (i-- > 0));
 
 	if (!(GLOB_SFT_RST & t)) {
-		printk(KERN_ERR DRV_NAME ": can't set global reset\n");
+		dev_err(host->dev, "can't set global reset\n");
 		rc = 1;
 		goto done;
 	}
@@ -3303,7 +3304,7 @@ static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio,
 	} while ((GLOB_SFT_RST & t) && (i-- > 0));
 
 	if (GLOB_SFT_RST & t) {
-		printk(KERN_ERR DRV_NAME ": can't clear global reset\n");
+		dev_err(host->dev, "can't clear global reset\n");
 		rc = 1;
 	}
 done:
@@ -3472,9 +3473,10 @@ static void mv_soc_reset_one_hc(struct mv_host_priv *hpriv,
 
 #undef ZERO
 
-static int mv_soc_reset_hc(struct mv_host_priv *hpriv,
+static int mv_soc_reset_hc(struct ata_host *host,
 				  void __iomem *mmio, unsigned int n_hc)
 {
+	struct mv_host_priv *hpriv = host->private_data;
 	unsigned int port;
 
 	for (port = 0; port < hpriv->n_ports; port++)
@@ -3847,11 +3849,11 @@ static int mv_chip_id(struct ata_host *host, unsigned int board_idx)
 			 *
 			 * Warn the user, lest they think we're just buggy.
 			 */
-			printk(KERN_WARNING DRV_NAME ": Highpoint RocketRAID"
+			dev_warn(&pdev->dev, "Highpoint RocketRAID"
 				" BIOS CORRUPTS DATA on all attached drives,"
 				" regardless of if/how they are configured."
 				" BEWARE!\n");
-			printk(KERN_WARNING DRV_NAME ": For data safety, do not"
+			dev_warn(&pdev->dev, "For data safety, do not"
 				" use sectors 8-9 on \"Legacy\" drives,"
 				" and avoid the final two gigabytes on"
 				" all RocketRAID BIOS initialized drives.\n");
@@ -3942,7 +3944,7 @@ static int mv_init_host(struct ata_host *host)
 		if (hpriv->ops->read_preamp)
 			hpriv->ops->read_preamp(hpriv, port, mmio);
 
-	rc = hpriv->ops->reset_hc(hpriv, mmio, n_hc);
+	rc = hpriv->ops->reset_hc(host, mmio, n_hc);
 	if (rc)
 		goto done;
 
@@ -4258,7 +4260,7 @@ static int mv_platform_resume(struct platform_device *pdev)
 		/* initialize adapter */
 		ret = mv_init_host(host);
 		if (ret) {
-			printk(KERN_ERR DRV_NAME ": Error during HW init\n");
+			dev_err(&pdev->dev, "Error during HW init\n");
 			return ret;
 		}
 		ata_host_resume(host);
-- 
2.29.2

