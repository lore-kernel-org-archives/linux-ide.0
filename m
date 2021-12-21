Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA00DC4167D
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhLUHW4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:56 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52658 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLUHWo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1F11121900;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nb2/ZW5mWNW54YuCqzmfouew1g0ngMTkKE0h18UDNvA=;
        b=Hw9odwK/blZUMQ+LzzS9c+74pn9JYPJOi2QSBpWHPdc1/OLGgIaOZWClp7w0NSZL8086Hf
        Vn+vRZuHOLtxGSxDDZ75FMyUL+CUQPwkxskJXsRA1KqIqIoU7ODwbsa16jXJF3kxUKreyJ
        lTYSqe2FE5wRkW7TQwNV13KNly9+Ov0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nb2/ZW5mWNW54YuCqzmfouew1g0ngMTkKE0h18UDNvA=;
        b=oFkv4Vs3tPxaQr8eblsJlQLW4rl5EAvdDcxJvq8QpcT1dNne9udqqsIAYcPcUaAk1PIQrE
        DDua2A+x46hVOjBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1AD0FA3BA0;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 18F8851923AA; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 28/68] sata_promise: Drop pointless VPRINTK() calls and convert the remaining ones
Date:   Tue, 21 Dec 2021 08:20:51 +0100
Message-Id: <20211221072131.46673-29-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drop pointless VPRINTK() calls for entering and existing interrupt
routines and convert the remaining calls to ata_port_dbg().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_promise.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 7815da8ef9e5..b8465fef2ed2 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -596,7 +596,8 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
 
 			prd[idx].addr = cpu_to_le32(addr);
 			prd[idx].flags_len = cpu_to_le32(len & 0xffff);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+			ata_port_dbg(ap, "PRD[%u] = (0x%X, 0x%X)\n",
+				     idx, addr, len);
 
 			idx++;
 			sg_len -= len;
@@ -609,17 +610,16 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
 	if (len > SG_COUNT_ASIC_BUG) {
 		u32 addr;
 
-		VPRINTK("Splitting last PRD.\n");
-
 		addr = le32_to_cpu(prd[idx - 1].addr);
 		prd[idx - 1].flags_len = cpu_to_le32(len - SG_COUNT_ASIC_BUG);
-		VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);
+		ata_port_dbg(ap, "PRD[%u] = (0x%X, 0x%X)\n",
+			     idx - 1, addr, SG_COUNT_ASIC_BUG);
 
 		addr = addr + len - SG_COUNT_ASIC_BUG;
 		len = SG_COUNT_ASIC_BUG;
 		prd[idx].addr = cpu_to_le32(addr);
 		prd[idx].flags_len = cpu_to_le32(len);
-		VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+		ata_port_dbg(ap, "PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
 
 		idx++;
 	}
@@ -632,8 +632,6 @@ static enum ata_completion_errors pdc_qc_prep(struct ata_queued_cmd *qc)
 	struct pdc_port_priv *pp = qc->ap->private_data;
 	unsigned int i;
 
-	VPRINTK("ENTER\n");
-
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 		pdc_fill_sg(qc);
@@ -922,12 +920,8 @@ static irqreturn_t pdc_interrupt(int irq, void *dev_instance)
 	u32 hotplug_status;
 	int is_sataii_tx4;
 
-	VPRINTK("ENTER\n");
-
-	if (!host || !host->iomap[PDC_MMIO_BAR]) {
-		VPRINTK("QUICK EXIT\n");
+	if (!host || !host->iomap[PDC_MMIO_BAR])
 		return IRQ_NONE;
-	}
 
 	host_mmio = host->iomap[PDC_MMIO_BAR];
 
@@ -946,23 +940,18 @@ static irqreturn_t pdc_interrupt(int irq, void *dev_instance)
 	/* reading should also clear interrupts */
 	mask = readl(host_mmio + PDC_INT_SEQMASK);
 
-	if (mask == 0xffffffff && hotplug_status == 0) {
-		VPRINTK("QUICK EXIT 2\n");
+	if (mask == 0xffffffff && hotplug_status == 0)
 		goto done_irq;
-	}
 
 	mask &= 0xffff;		/* only 16 SEQIDs possible */
-	if (mask == 0 && hotplug_status == 0) {
-		VPRINTK("QUICK EXIT 3\n");
+	if (mask == 0 && hotplug_status == 0)
 		goto done_irq;
-	}
 
 	writel(mask, host_mmio + PDC_INT_SEQMASK);
 
 	is_sataii_tx4 = pdc_is_sataii_tx4(host->ports[0]->flags);
 
 	for (i = 0; i < host->n_ports; i++) {
-		VPRINTK("port %u\n", i);
 		ap = host->ports[i];
 
 		/* check for a plug or unplug event */
@@ -989,8 +978,6 @@ static irqreturn_t pdc_interrupt(int irq, void *dev_instance)
 		}
 	}
 
-	VPRINTK("EXIT\n");
-
 done_irq:
 	spin_unlock(&host->lock);
 	return IRQ_RETVAL(handled);
@@ -1005,8 +992,6 @@ static void pdc_packet_start(struct ata_queued_cmd *qc)
 	unsigned int port_no = ap->port_no;
 	u8 seq = (u8) (port_no + 1);
 
-	VPRINTK("ENTER, ap %p\n", ap);
-
 	writel(0x00000001, host_mmio + (seq * 4));
 	readl(host_mmio + (seq * 4));	/* flush */
 
-- 
2.29.2

