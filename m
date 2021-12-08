Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699E2C43219
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhLHQhD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37756 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbhLHQgo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D7ED11FE20;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeu6UXUaCQaZ/vLqP1qK44lPQeebebPfpkezaTWCtQY=;
        b=WoWX6vmqgQxRb2wkPAp807QF+BGKDy517fwX5SRy/vFwXGTb9nGe6LUacdxRCji5kDaDvy
        IP9WyY2f7i+SLedfaqDTRHe+eJJt6x0f+McG5X72mXx20sNNySej8WZiwXb5i06aec9KFO
        C6a8ELfVXYPpOqRfa/qYCrWz1p0jPYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeu6UXUaCQaZ/vLqP1qK44lPQeebebPfpkezaTWCtQY=;
        b=dTwm/8m7o7yS8eEB2nKbFJnjq8eKwPyd285Vb8d6ZcKvqPxwKGQ/wWvpB8F1nINeFO1s1e
        V3ScbFlj7xRN7oBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D559BA3BBD;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id D0EB45191FB3; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 43/73] sata_sx4: Drop pointless VPRINTK() calls and convert the remaining ones
Date:   Wed,  8 Dec 2021 17:32:25 +0100
Message-Id: <20211208163255.114660-44-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drop pointless VPRINTK() calls for setting up SG tables
and convert the remaining calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_sx4.c | 105 +++++++++++++----------------------------
 1 file changed, 34 insertions(+), 71 deletions(-)

diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 4c01190a5e37..85e72c81a1de 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -308,15 +308,9 @@ static inline void pdc20621_ata_sg(u8 *buf, unsigned int portno,
 	/* output ATA packet S/G table */
 	addr = PDC_20621_DIMM_BASE + PDC_20621_DIMM_DATA +
 	       (PDC_DIMM_DATA_STEP * portno);
-	VPRINTK("ATA sg addr 0x%x, %d\n", addr, addr);
+
 	buf32[dw] = cpu_to_le32(addr);
 	buf32[dw + 1] = cpu_to_le32(total_len | ATA_PRD_EOT);
-
-	VPRINTK("ATA PSG @ %x == (0x%x, 0x%x)\n",
-		PDC_20621_DIMM_BASE +
-		       (PDC_DIMM_WINDOW_STEP * portno) +
-		       PDC_DIMM_APKT_PRD,
-		buf32[dw], buf32[dw + 1]);
 }
 
 static inline void pdc20621_host_sg(u8 *buf, unsigned int portno,
@@ -332,12 +326,6 @@ static inline void pdc20621_host_sg(u8 *buf, unsigned int portno,
 
 	buf32[dw] = cpu_to_le32(addr);
 	buf32[dw + 1] = cpu_to_le32(total_len | ATA_PRD_EOT);
-
-	VPRINTK("HOST PSG @ %x == (0x%x, 0x%x)\n",
-		PDC_20621_DIMM_BASE +
-		       (PDC_DIMM_WINDOW_STEP * portno) +
-		       PDC_DIMM_HPKT_PRD,
-		buf32[dw], buf32[dw + 1]);
 }
 
 static inline unsigned int pdc20621_ata_pkt(struct ata_taskfile *tf,
@@ -351,7 +339,6 @@ static inline unsigned int pdc20621_ata_pkt(struct ata_taskfile *tf,
 	unsigned int dimm_sg = PDC_20621_DIMM_BASE +
 			       (PDC_DIMM_WINDOW_STEP * portno) +
 			       PDC_DIMM_APKT_PRD;
-	VPRINTK("ENTER, dimm_sg == 0x%x, %d\n", dimm_sg, dimm_sg);
 
 	i = PDC_DIMM_ATA_PKT;
 
@@ -406,8 +393,6 @@ static inline void pdc20621_host_pkt(struct ata_taskfile *tf, u8 *buf,
 	unsigned int dimm_sg = PDC_20621_DIMM_BASE +
 			       (PDC_DIMM_WINDOW_STEP * portno) +
 			       PDC_DIMM_HPKT_PRD;
-	VPRINTK("ENTER, dimm_sg == 0x%x, %d\n", dimm_sg, dimm_sg);
-	VPRINTK("host_sg == 0x%x, %d\n", host_sg, host_sg);
 
 	dw = PDC_DIMM_HOST_PKT >> 2;
 
@@ -424,14 +409,6 @@ static inline void pdc20621_host_pkt(struct ata_taskfile *tf, u8 *buf,
 	buf32[dw + 1] = cpu_to_le32(host_sg);
 	buf32[dw + 2] = cpu_to_le32(dimm_sg);
 	buf32[dw + 3] = 0;
-
-	VPRINTK("HOST PKT @ %x == (0x%x 0x%x 0x%x 0x%x)\n",
-		PDC_20621_DIMM_BASE + (PDC_DIMM_WINDOW_STEP * portno) +
-			PDC_DIMM_HOST_PKT,
-		buf32[dw + 0],
-		buf32[dw + 1],
-		buf32[dw + 2],
-		buf32[dw + 3]);
 }
 
 static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
@@ -447,8 +424,6 @@ static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 
 	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
 
-	VPRINTK("ata%u: ENTER\n", ap->print_id);
-
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
@@ -492,7 +467,8 @@ static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 
 	readl(dimm_mmio);	/* MMIO PCI posting flush */
 
-	VPRINTK("ata pkt buf ofs %u, prd size %u, mmio copied\n", i, sgt_len);
+	ata_port_dbg(ap, "ata pkt buf ofs %u, prd size %u, mmio copied\n",
+		     i, sgt_len);
 }
 
 static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
@@ -504,8 +480,6 @@ static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
 	unsigned int portno = ap->port_no;
 	unsigned int i;
 
-	VPRINTK("ata%u: ENTER\n", ap->print_id);
-
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
@@ -527,7 +501,7 @@ static void pdc20621_nodata_prep(struct ata_queued_cmd *qc)
 
 	readl(dimm_mmio);	/* MMIO PCI posting flush */
 
-	VPRINTK("ata pkt buf ofs %u, mmio copied\n", i);
+	ata_port_dbg(ap, "ata pkt buf ofs %u, mmio copied\n", i);
 }
 
 static enum ata_completion_errors pdc20621_qc_prep(struct ata_queued_cmd *qc)
@@ -633,8 +607,6 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
-	VPRINTK("ata%u: ENTER\n", ap->print_id);
-
 	wmb();			/* flush PRD, pkt writes */
 
 	port_ofs = PDC_20621_DIMM_BASE + (PDC_DIMM_WINDOW_STEP * port_no);
@@ -645,7 +617,7 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 
 		pdc20621_dump_hdma(qc);
 		pdc20621_push_hdma(qc, seq, port_ofs + PDC_DIMM_HOST_PKT);
-		VPRINTK("queued ofs 0x%x (%u), seq %u\n",
+		ata_port_dbg(ap, "queued ofs 0x%x (%u), seq %u\n",
 			port_ofs + PDC_DIMM_HOST_PKT,
 			port_ofs + PDC_DIMM_HOST_PKT,
 			seq);
@@ -656,7 +628,7 @@ static void pdc20621_packet_start(struct ata_queued_cmd *qc)
 		writel(port_ofs + PDC_DIMM_ATA_PKT,
 		       ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
 		readl(ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT);
-		VPRINTK("submitted ofs 0x%x (%u), seq %u\n",
+		ata_port_dbg(ap, "submitted ofs 0x%x (%u), seq %u\n",
 			port_ofs + PDC_DIMM_ATA_PKT,
 			port_ofs + PDC_DIMM_ATA_PKT,
 			seq);
@@ -696,14 +668,12 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 	u8 status;
 	unsigned int handled = 0;
 
-	VPRINTK("ENTER\n");
-
 	if ((qc->tf.protocol == ATA_PROT_DMA) &&	/* read */
 	    (!(qc->tf.flags & ATA_TFLAG_WRITE))) {
 
 		/* step two - DMA from DIMM to host */
 		if (doing_hdma) {
-			VPRINTK("ata%u: read hdma, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "read hdma, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
@@ -714,7 +684,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 		/* step one - exec ATA command */
 		else {
 			u8 seq = (u8) (port_no + 1 + 4);
-			VPRINTK("ata%u: read ata, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "read ata, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 
 			/* submit hdma pkt */
@@ -729,7 +699,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 		/* step one - DMA from host to DIMM */
 		if (doing_hdma) {
 			u8 seq = (u8) (port_no + 1);
-			VPRINTK("ata%u: write hdma, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "write hdma, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 
 			/* submit ata pkt */
@@ -742,7 +712,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 
 		/* step two - execute ATA command */
 		else {
-			VPRINTK("ata%u: write ata, 0x%x 0x%x\n", ap->print_id,
+			ata_port_dbg(ap, "write ata, 0x%x 0x%x\n",
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |= ac_err_mask(ata_wait_idle(ap));
@@ -755,7 +725,7 @@ static inline unsigned int pdc20621_host_intr(struct ata_port *ap,
 	} else if (qc->tf.protocol == ATA_PROT_NODATA) {
 
 		status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
+		ata_port_dbg(ap, "BUS_NODATA (drv_stat 0x%X)\n", status);
 		qc->err_mask |= ac_err_mask(status);
 		ata_qc_complete(qc);
 		handled = 1;
@@ -781,29 +751,21 @@ static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
 	unsigned int handled = 0;
 	void __iomem *mmio_base;
 
-	VPRINTK("ENTER\n");
-
-	if (!host || !host->iomap[PDC_MMIO_BAR]) {
-		VPRINTK("QUICK EXIT\n");
+	if (!host || !host->iomap[PDC_MMIO_BAR])
 		return IRQ_NONE;
-	}
 
 	mmio_base = host->iomap[PDC_MMIO_BAR];
 
 	/* reading should also clear interrupts */
 	mmio_base += PDC_CHIP0_OFS;
 	mask = readl(mmio_base + PDC_20621_SEQMASK);
-	VPRINTK("mask == 0x%x\n", mask);
 
-	if (mask == 0xffffffff) {
-		VPRINTK("QUICK EXIT 2\n");
+	if (mask == 0xffffffff)
 		return IRQ_NONE;
-	}
+
 	mask &= 0xffff;		/* only 16 tags possible */
-	if (!mask) {
-		VPRINTK("QUICK EXIT 3\n");
+	if (!mask)
 		return IRQ_NONE;
-	}
 
 	spin_lock(&host->lock);
 
@@ -816,7 +778,8 @@ static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
 		else
 			ap = host->ports[port_no];
 		tmp = mask & (1 << i);
-		VPRINTK("seq %u, port_no %u, ap %p, tmp %x\n", i, port_no, ap, tmp);
+		if (ap)
+			ata_port_dbg(ap, "seq %u, tmp %x\n", i, tmp);
 		if (tmp && ap) {
 			struct ata_queued_cmd *qc;
 
@@ -829,10 +792,6 @@ static irqreturn_t pdc20621_interrupt(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("mask == 0x%x\n", mask);
-
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(handled);
 }
 
@@ -1274,7 +1233,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	/* Initialize Time Period Register */
 	writel(0xffffffff, mmio + PDC_TIME_PERIOD);
 	time_period = readl(mmio + PDC_TIME_PERIOD);
-	VPRINTK("Time Period Register (0x40): 0x%x\n", time_period);
+	dev_dbg(host->dev, "Time Period Register (0x40): 0x%x\n", time_period);
 
 	/* Enable timer */
 	writel(PDC_TIMER_DEFAULT, mmio + PDC_TIME_CONTROL);
@@ -1289,7 +1248,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	*/
 
 	tcount = readl(mmio + PDC_TIME_COUNTER);
-	VPRINTK("Time Counter Register (0x44): 0x%x\n", tcount);
+	dev_dbg(host->dev, "Time Counter Register (0x44): 0x%x\n", tcount);
 
 	/*
 	   If SX4 is on PCI-X bus, after 3 seconds, the timer counter
@@ -1297,17 +1256,19 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 	*/
 	if (tcount >= PCI_X_TCOUNT) {
 		ticks = (time_period - tcount);
-		VPRINTK("Num counters 0x%x (%d)\n", ticks, ticks);
+		dev_dbg(host->dev, "Num counters 0x%x (%d)\n", ticks, ticks);
 
 		clock = (ticks / 300000);
-		VPRINTK("10 * Internal clk = 0x%x (%d)\n", clock, clock);
+		dev_dbg(host->dev, "10 * Internal clk = 0x%x (%d)\n",
+			clock, clock);
 
 		clock = (clock * 33);
-		VPRINTK("10 * Internal clk * 33 = 0x%x (%d)\n", clock, clock);
+		dev_dbg(host->dev, "10 * Internal clk * 33 = 0x%x (%d)\n",
+			clock, clock);
 
 		/* PLL F Param (bit 22:16) */
 		fparam = (1400000 / clock) - 2;
-		VPRINTK("PLL F Param: 0x%x (%d)\n", fparam, fparam);
+		dev_dbg(host->dev, "PLL F Param: 0x%x (%d)\n", fparam, fparam);
 
 		/* OD param = 0x2 (bit 31:30), R param = 0x5 (bit 29:25) */
 		pci_status = (0x8a001824 | (fparam << 16));
@@ -1315,7 +1276,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 		pci_status = PCI_PLL_INIT;
 
 	/* Initialize PLL. */
-	VPRINTK("pci_status: 0x%x\n", pci_status);
+	dev_dbg(host->dev, "pci_status: 0x%x\n", pci_status);
 	writel(pci_status, mmio + PDC_CTL_STATUS);
 	readl(mmio + PDC_CTL_STATUS);
 
@@ -1327,15 +1288,16 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 		printk(KERN_ERR "Detect Local DIMM Fail\n");
 		return 1;	/* DIMM error */
 	}
-	VPRINTK("Local DIMM Speed = %d\n", speed);
+	dev_dbg(host->dev, "Local DIMM Speed = %d\n", speed);
 
 	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
 	size = pdc20621_prog_dimm0(host);
-	VPRINTK("Local DIMM Size = %dMB\n", size);
+	dev_dbg(host->dev, "Local DIMM Size = %dMB\n", size);
 
 	/* Programming DIMM Module Global Control Register (index_CID0:88h) */
 	if (pdc20621_prog_dimm_global(host)) {
-		printk(KERN_ERR "Programming DIMM Module Global Control Register Fail\n");
+		dev_err(host->dev,
+			"Programming DIMM Module Global Control Register Fail\n");
 		return 1;
 	}
 
@@ -1372,13 +1334,14 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 
 	if (!pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
 			       PDC_DIMM_SPD_TYPE, &spd0)) {
-		pr_err("Failed in i2c read: device=%#x, subaddr=%#x\n",
+		dev_err(host->dev,
+			"Failed in i2c read: device=%#x, subaddr=%#x\n",
 		       PDC_DIMM0_SPD_DEV_ADDRESS, PDC_DIMM_SPD_TYPE);
 		return 1;
 	}
 	if (spd0 == 0x02) {
 		void *buf;
-		VPRINTK("Start ECC initialization\n");
+		dev_dbg(host->dev, "Start ECC initialization\n");
 		addr = 0;
 		length = size * 1024 * 1024;
 		buf = kzalloc(ECC_ERASE_BUF_SZ, GFP_KERNEL);
@@ -1390,7 +1353,7 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
 			addr += ECC_ERASE_BUF_SZ;
 		}
 		kfree(buf);
-		VPRINTK("Finish ECC initialization\n");
+		dev_dbg(host->dev, "Finish ECC initialization\n");
 	}
 	return 0;
 }
-- 
2.29.2

