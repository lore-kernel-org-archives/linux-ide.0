Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7363C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhLHQgm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:42 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40668 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7896421954;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sf3w0y2mc1edHvbzk0IXn1FT2GK88csOMpOmsnmHypk=;
        b=cz38KBmOmDy8sXlyONU9UH46WeEnK9phjaxndOqzuTZ9aKiK4fm6eXBrb/yOrx6AKkxBb3
        1ZgDD3NKnixUGigWZ59MgSwtvInE7pAy9NjLlGeCtFWgQV1qgD0yB7w4fEQyP1QgSG1Eaj
        +3dzqqU+TPg9/YkcMvtjlTk/tv7yHks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sf3w0y2mc1edHvbzk0IXn1FT2GK88csOMpOmsnmHypk=;
        b=0W8AdAIWwwEPSvwLFUu180K99pnUPRCFxf9It6lfl9D1fLdrDJgqGZCEZpTgR6JWn7DSYo
        CgMJYYv0S4KRyjCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7212BA3BAD;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 6DF355191F91; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 26/73] sata_fsl: move DPRINTK to ata debugging
Date:   Wed,  8 Dec 2021 17:32:08 +0100
Message-Id: <20211208163255.114660-27-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Replace all DPRINTK calls with the ata_XXX_dbg functions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_fsl.c | 79 ++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 5421625dcf6e..9a371dd593a7 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -311,9 +311,9 @@ static void fsl_sata_set_irq_coalescing(struct ata_host *host,
 	intr_coalescing_ticks = ticks;
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	DPRINTK("interrupt coalescing, count = 0x%x, ticks = %x\n",
+	dev_dbg(&host->dev, "interrupt coalescing, count = 0x%x, ticks = %x\n",
 			intr_coalescing_count, intr_coalescing_ticks);
-	DPRINTK("ICC register status: (hcr base: %p) = 0x%x\n",
+	dev_dbg(&host->dev, "ICC register status: (hcr base: 0x%x) = 0x%x\n",
 			hcr_base, ioread32(hcr_base + ICC));
 }
 
@@ -385,18 +385,19 @@ static ssize_t fsl_sata_rx_watermark_store(struct device *dev,
 	return strlen(buf);
 }
 
-static inline unsigned int sata_fsl_tag(unsigned int tag,
+static inline unsigned int sata_fsl_tag(struct ata_port *ap,
+					unsigned int tag,
 					void __iomem *hcr_base)
 {
 	/* We let libATA core do actual (queue) tag allocation */
 
 	if (unlikely(tag >= SATA_FSL_QUEUE_DEPTH)) {
-		DPRINTK("tag %d invalid : out of range\n", tag);
+		ata_port_dbg(ap, "tag %d invalid : out of range\n", tag);
 		return 0;
 	}
 
 	if (unlikely((ioread32(hcr_base + CQ)) & (1 << tag))) {
-		DPRINTK("tag %d invalid : in use!!\n", tag);
+		ata_port_dbg(ap, "tag %d invalid : in use!!\n", tag);
 		return 0;
 	}
 
@@ -508,7 +509,7 @@ static enum ata_completion_errors sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 	struct sata_fsl_port_priv *pp = ap->private_data;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
-	unsigned int tag = sata_fsl_tag(qc->hw_tag, hcr_base);
+	unsigned int tag = sata_fsl_tag(ap, qc->hw_tag, hcr_base);
 	struct command_desc *cd;
 	u32 desc_info = CMD_DESC_RES | CMD_DESC_SNOOP_ENABLE;
 	u32 num_prde = 0;
@@ -557,7 +558,7 @@ static unsigned int sata_fsl_qc_issue(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
-	unsigned int tag = sata_fsl_tag(qc->hw_tag, hcr_base);
+	unsigned int tag = sata_fsl_tag(ap, qc->hw_tag, hcr_base);
 
 	VPRINTK("xx_qc_issue called,CQ=0x%x,CA=0x%x,CE=0x%x,CC=0x%x\n",
 		ioread32(CQ + hcr_base),
@@ -586,7 +587,7 @@ static bool sata_fsl_qc_fill_rtf(struct ata_queued_cmd *qc)
 	struct sata_fsl_port_priv *pp = qc->ap->private_data;
 	struct sata_fsl_host_priv *host_priv = qc->ap->host->private_data;
 	void __iomem *hcr_base = host_priv->hcr_base;
-	unsigned int tag = sata_fsl_tag(qc->hw_tag, hcr_base);
+	unsigned int tag = sata_fsl_tag(qc->ap, qc->hw_tag, hcr_base);
 	struct command_desc *cd;
 
 	cd = pp->cmdentry + tag;
@@ -850,9 +851,10 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
 			goto try_offline_again;
 	}
 
-	DPRINTK("hardreset, controller off-lined\n");
-	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
-	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
+	ata_port_dbg(ap, "hardreset, controller off-lined\n"
+		     "HStatus = 0x%x HControl = 0x%x\n",
+		     ioread32(hcr_base + HSTATUS),
+		     ioread32(hcr_base + HCONTROL));
 
 	/*
 	 * PHY reset should remain asserted for atleast 1ms
@@ -880,9 +882,10 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
 		goto err;
 	}
 
-	DPRINTK("hardreset, controller off-lined & on-lined\n");
-	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
-	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
+	ata_port_dbg(ap, "controller off-lined & on-lined\n"
+		     "HStatus = 0x%x HControl = 0x%x\n",
+		     ioread32(hcr_base + HSTATUS),
+		     ioread32(hcr_base + HCONTROL));
 
 	/*
 	 * First, wait for the PHYRDY change to occur before waiting for
@@ -962,7 +965,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	tf.ctl |= ATA_SRST;	/* setup SRST bit in taskfile control reg */
 	ata_tf_to_fis(&tf, pmp, 0, cfis);
 
-	DPRINTK("Dumping cfis : 0x%x, 0x%x, 0x%x, 0x%x\n",
+	ata_port_dbg(ap, "Dumping cfis : 0x%x, 0x%x, 0x%x, 0x%x\n",
 		cfis[0], cfis[1], cfis[2], cfis[3]);
 
 	/*
@@ -970,7 +973,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	 * other commands are active on the controller/device
 	 */
 
-	DPRINTK("@Softreset, CQ = 0x%x, CA = 0x%x, CC = 0x%x\n",
+	ata_port_dbg(ap, "CQ = 0x%x, CA = 0x%x, CC = 0x%x\n",
 		ioread32(CQ + hcr_base),
 		ioread32(CA + hcr_base), ioread32(CC + hcr_base));
 
@@ -983,15 +986,16 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	if (temp & 0x1) {
 		ata_port_warn(ap, "ATA_SRST issue failed\n");
 
-		DPRINTK("Softreset@5000,CQ=0x%x,CA=0x%x,CC=0x%x\n",
+		ata_port_dbg(ap, "Softreset@5000,CQ=0x%x,CA=0x%x,CC=0x%x\n",
 			ioread32(CQ + hcr_base),
 			ioread32(CA + hcr_base), ioread32(CC + hcr_base));
 
 		sata_fsl_scr_read(&ap->link, SCR_ERROR, &Serror);
 
-		DPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
-		DPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
-		DPRINTK("Serror = 0x%x\n", Serror);
+		ata_port_dbg(ap, "HStatus = 0x%x HControl = 0x%x Serror = 0x%x\n",
+			     ioread32(hcr_base + HSTATUS),
+			     ioread32(hcr_base + HCONTROL),
+			     Serror);
 		goto err;
 	}
 
@@ -1048,10 +1052,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 
 static void sata_fsl_error_handler(struct ata_port *ap)
 {
-
-	DPRINTK("in xx_error_handler\n");
 	sata_pmp_error_handler(ap);
-
 }
 
 static void sata_fsl_post_internal_cmd(struct ata_queued_cmd *qc)
@@ -1092,7 +1093,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 	if (unlikely(SError & 0xFFFF0000))
 		sata_fsl_scr_write(&ap->link, SCR_ERROR, SError);
 
-	DPRINTK("error_intr,hStat=0x%x,CE=0x%x,DE =0x%x,SErr=0x%x\n",
+	ata_port_dbg(ap, "hStat=0x%x,CE=0x%x,DE =0x%x,SErr=0x%x\n",
 		hstatus, cereg, ioread32(hcr_base + DE), SError);
 
 	/* handle fatal errors */
@@ -1109,7 +1110,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 
 	/* Handle PHYRDY change notification */
 	if (hstatus & INT_ON_PHYRDY_CHG) {
-		DPRINTK("SATA FSL: PHYRDY change indication\n");
+		ata_port_dbg(ap, "PHYRDY change indication\n");
 
 		/* Setup a soft-reset EH action */
 		ata_ehi_hotplugged(ehi);
@@ -1130,7 +1131,7 @@ static void sata_fsl_error_intr(struct ata_port *ap)
 		 */
 		abort = 1;
 
-		DPRINTK("single device error, CE=0x%x, DE=0x%x\n",
+		ata_port_dbg(ap, "single device error, CE=0x%x, DE=0x%x\n",
 			ioread32(hcr_base + CE), ioread32(hcr_base + DE));
 
 		/* find out the offending link and qc */
@@ -1235,12 +1236,12 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 	}
 
 	if (unlikely(SError & 0xFFFF0000)) {
-		DPRINTK("serror @host_intr : 0x%x\n", SError);
+		ata_port_dbg(ap, "serror @host_intr : 0x%x\n", SError);
 		sata_fsl_error_intr(ap);
 	}
 
 	if (unlikely(hstatus & status_mask)) {
-		DPRINTK("error interrupt!!\n");
+		ata_port_dbg(ap, "error interrupt!!\n");
 		sata_fsl_error_intr(ap);
 		return;
 	}
@@ -1258,15 +1259,13 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		/* clear CC bit, this will also complete the interrupt */
 		iowrite32(done_mask, hcr_base + CC);
 
-		DPRINTK("Status of all queues :\n");
-		DPRINTK("done_mask/CC = 0x%x, CA = 0x%x, CE=0x%x\n",
+		ata_port_dbg(ap, "Status of all queues: done_mask/CC = 0x%x, CA = 0x%x, CE=0x%x\n",
 			done_mask, ioread32(hcr_base + CA),
 			ioread32(hcr_base + CE));
 
 		for (i = 0; i < SATA_FSL_QUEUE_DEPTH; i++) {
 			if (done_mask & (1 << i))
-				DPRINTK
-				    ("completing ncq cmd,tag=%d,CC=0x%x,CA=0x%x\n",
+				ata_port_dbg(ap, "completing ncq cmd,tag=%d,CC=0x%x,CA=0x%x\n",
 				     i, ioread32(hcr_base + CC),
 				     ioread32(hcr_base + CA));
 		}
@@ -1277,7 +1276,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		iowrite32(1, hcr_base + CC);
 		qc = ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
 
-		DPRINTK("completing non-ncq cmd, CC=0x%x\n",
+		ata_port_dbg(ap, "completing non-ncq cmd, CC=0x%x\n",
 			 ioread32(hcr_base + CC));
 
 		if (qc) {
@@ -1285,7 +1284,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		}
 	} else {
 		/* Spurious Interrupt!! */
-		DPRINTK("spurious interrupt!!, CC = 0x%x\n",
+		ata_port_dbg(ap, "spurious interrupt!!, CC = 0x%x\n",
 			ioread32(hcr_base + CC));
 		iowrite32(done_mask, hcr_base + CC);
 		return;
@@ -1305,8 +1304,6 @@ static irqreturn_t sata_fsl_interrupt(int irq, void *dev_instance)
 	interrupt_enables = ioread32(hcr_base + HSTATUS);
 	interrupt_enables &= 0x3F;
 
-	DPRINTK("interrupt status 0x%x\n", interrupt_enables);
-
 	if (!interrupt_enables)
 		return IRQ_NONE;
 
@@ -1359,7 +1356,7 @@ static int sata_fsl_init_controller(struct ata_host *host)
 	iowrite32((temp & ~0x3F), hcr_base + HCONTROL);
 
 	/* Disable interrupt coalescing control(icc), for the moment */
-	DPRINTK("icc = 0x%x\n", ioread32(hcr_base + ICC));
+	ata_port_dbg(ap, "icc = 0x%x\n", ioread32(hcr_base + ICC));
 	iowrite32(0x01000000, hcr_base + ICC);
 
 	/* clear error registers, SError is cleared by libATA  */
@@ -1378,8 +1375,8 @@ static int sata_fsl_init_controller(struct ata_host *host)
 	 * callback, that should also initiate the OOB, COMINIT sequence
 	 */
 
-	DPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
-	DPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
+	ata_port_dbg(ap, "HStatus = 0x%x HControl = 0x%x\n",
+		     ioread32(hcr_base + HSTATUS), ioread32(hcr_base + HCONTROL));
 
 	return 0;
 }
@@ -1458,9 +1455,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 		iowrite32(temp | TRANSCFG_RX_WATER_MARK, csr_base + TRANSCFG);
 	}
 
-	DPRINTK("@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
-	DPRINTK("sizeof(cmd_desc) = %d\n", sizeof(struct command_desc));
-	DPRINTK("sizeof(#define cmd_desc) = %d\n", SATA_FSL_CMD_DESC_SIZE);
+	ata_port_dbg(ap, "@reset i/o = 0x%x\n", ioread32(csr_base + TRANSCFG));
 
 	host_priv = kzalloc(sizeof(struct sata_fsl_host_priv), GFP_KERNEL);
 	if (!host_priv)
-- 
2.29.2

