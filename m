Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DBAC3F2E0
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64897214DB
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgCCJjt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbgCCJjq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D3888B214;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 18/40] libata: drop debugging statements for bus-master DMA
Date:   Tue,  3 Mar 2020 10:37:51 +0100
Message-Id: <20200303093813.18523-19-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
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
index e2d1504f7562..1078b621d47b 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -413,12 +413,6 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
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
@@ -427,18 +421,10 @@ void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
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
@@ -498,8 +484,6 @@ EXPORT_SYMBOL_GPL(ata_sff_tf_read);
  */
 void ata_sff_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
-
 	iowrite8(tf->command, ap->ioaddr.command_addr);
 	ata_sff_pause(ap);
 }
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 7c87168a1932..9b66552efbd2 100644
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
index 378ed9ea97e9..3778270e762f 100644
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
index 7ab9aea3b630..42ea13dd4ace 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -211,7 +211,6 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 static void sil680_sff_exec_command(struct ata_port *ap,
 				    const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 	iowrite8(tf->command, ap->ioaddr.command_addr);
 	ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 9dcef6ac643b..ef07d4a03627 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -970,9 +970,6 @@ static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
 {
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 
-	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=%d\n", __func__, tf->command,
-		ata_get_cmd_descript(tf->command), tag);
-
 	hsdevp->cmd_issued[tag] = cmd_issued;
 
 	/*
@@ -995,12 +992,9 @@ static void sata_dwc_bmdma_setup(struct ata_queued_cmd *qc)
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
 
@@ -1057,13 +1051,9 @@ static void sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
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
index 1b42be234761..0925a0564cc5 100644
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
2.16.4

