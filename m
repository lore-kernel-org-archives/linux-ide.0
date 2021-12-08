Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EFFC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbhLHQgi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:38 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40658 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3E9BF218D6;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATbG7amhGUN1vqMdJDUUeSewmGdChzshLmPzblm532w=;
        b=t10vHo6ckLCnl4R8LtUxJgHUKRf0za3ARx1fhriLUs9BWJTLI7OeqZ0VnUxTAJwuMOVKgQ
        cShxecSpo8HbQRsLEE+XFYIf2ceDtt6NmAXSDuAfr43XswQojdsKUv/5nDDZTFK1RrC96X
        nIKQsswneV0u/teMN+h7obuZi1ikPAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATbG7amhGUN1vqMdJDUUeSewmGdChzshLmPzblm532w=;
        b=y4TcXe9Ym9C8scO4jHZ9ehSJpClapa4Fi1zmbJy/ptKpYDvb/3g32L2KvXM76LWLvfuI12
        xLOf2FpnPvniRQDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2E951A3B9D;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 16EF45191F71; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 10/73] libata: drop debugging statements for bus-master DMA
Date:   Wed,  8 Dec 2021 17:31:52 +0100
Message-Id: <20211208163255.114660-11-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Bus-master DMA is now logged with generic tracepoints, so we can
drop the DPRINTK()/VPRINTK and dev_dbg() calls here.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-sff.c        | 18 +-----------------
 drivers/ata/pata_octeon_cf.c    | 10 ++--------
 drivers/ata/pata_pdc202xx_old.c |  2 --
 drivers/ata/pata_sil680.c       |  1 -
 drivers/ata/sata_dwc_460ex.c    | 18 ++++--------------
 drivers/ata/sata_rcar.c         |  2 --
 6 files changed, 7 insertions(+), 44 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 60ac93a0bafb..4c923820d4f9 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -409,12 +409,6 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		iowrite8(tf->hob_lbal, ioaddr->lbal_addr);
 		iowrite8(tf->hob_lbam, ioaddr->lbam_addr);
 		iowrite8(tf->hob_lbah, ioaddr->lbah_addr);
-		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->hob_feature,
-			tf->hob_nsect,
-			tf->hob_lbal,
-			tf->hob_lbam,
-			tf->hob_lbah);
 	}
 
 	if (is_addr) {
@@ -423,18 +417,10 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 		iowrite8(tf->lbal, ioaddr->lbal_addr);
 		iowrite8(tf->lbam, ioaddr->lbam_addr);
 		iowrite8(tf->lbah, ioaddr->lbah_addr);
-		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
-			tf->feature,
-			tf->nsect,
-			tf->lbal,
-			tf->lbam,
-			tf->lbah);
 	}
 
-	if (tf->flags & ATA_TFLAG_DEVICE) {
+	if (tf->flags & ATA_TFLAG_DEVICE)
 		iowrite8(tf->device, ioaddr->device_addr);
-		VPRINTK("device 0x%X\n", tf->device);
-	}
 
 	ata_wait_idle(ap);
 }
@@ -494,8 +480,6 @@ EXPORT_SYMBOL_GPL(ata_sff_tf_read);
  */
 void ata_sff_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
-
 	iowrite8(tf->command, ap->ioaddr.command_addr);
 	ata_sff_pause(ap);
 }
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index cdc95eb2b2cb..06468a1f4807 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -514,20 +514,14 @@ static void octeon_cf_exec_command16(struct ata_port *ap,
 {
 	/* The base of the registers is at ioaddr.data_addr. */
 	void __iomem *base = ap->ioaddr.data_addr;
-	u16 blob;
+	u16 blob = 0;
 
-	if (tf->flags & ATA_TFLAG_DEVICE) {
-		VPRINTK("device 0x%X\n", tf->device);
+	if (tf->flags & ATA_TFLAG_DEVICE)
 		blob = tf->device;
-	} else {
-		blob = 0;
-	}
 
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 	blob |= (tf->command << 8);
 	__raw_writew(blob, base + 6);
 
-
 	ata_wait_idle(ap);
 }
 
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 0c5cbcd28d0d..b99849095853 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -38,8 +38,6 @@ static int pdc2026x_cable_detect(struct ata_port *ap)
 static void pdc202xx_exec_command(struct ata_port *ap,
 				  const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
-
 	iowrite8(tf->command, ap->ioaddr.command_addr);
 	ndelay(400);
 }
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 43215a664b96..81238e097fe2 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -212,7 +212,6 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 static void sil680_sff_exec_command(struct ata_port *ap,
 				    const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 	iowrite8(tf->command, ap->ioaddr.command_addr);
 	ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 338c2e50f759..f5ef5ce5f758 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -980,9 +980,6 @@ static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
 {
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 
-	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=%d\n", __func__, tf->command,
-		ata_get_cmd_descript(tf->command), tag);
-
 	hsdevp->cmd_issued[tag] = cmd_issued;
 
 	/*
@@ -1005,12 +1002,9 @@ static void sata_dwc_bmdma_setup(struct ata_queued_cmd *qc)
 {
 	u8 tag = qc->hw_tag;
 
-	if (ata_is_ncq(qc->tf.protocol)) {
-		dev_dbg(qc->ap->dev, "%s: ap->link.sactive=0x%08x tag=%d\n",
-			__func__, qc->ap->link.sactive, tag);
-	} else {
+	if (!ata_is_ncq(qc->tf.protocol))
 		tag = 0;
-	}
+
 	sata_dwc_bmdma_setup_by_tag(qc, tag);
 }
 
@@ -1067,13 +1061,9 @@ static void sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
 {
 	u8 tag = qc->hw_tag;
 
-	if (ata_is_ncq(qc->tf.protocol)) {
-		dev_dbg(qc->ap->dev, "%s: ap->link.sactive=0x%08x tag=%d\n",
-			__func__, qc->ap->link.sactive, tag);
-	} else {
+	if (!ata_is_ncq(qc->tf.protocol))
 		tag = 0;
-	}
-	dev_dbg(qc->ap->dev, "%s\n", __func__);
+
 	sata_dwc_bmdma_start_by_tag(qc, tag);
 }
 
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 9005833ab02f..b4994d182eda 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -436,8 +436,6 @@ static void sata_rcar_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 static void sata_rcar_exec_command(struct ata_port *ap,
 				   const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
-
 	iowrite32(tf->command, ap->ioaddr.command_addr);
 	ata_sff_pause(ap);
 }
-- 
2.29.2

