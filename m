Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DD7C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbhLHQgz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:55 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37832 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbhLHQgh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A92991FE18;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYlAYuVg6wipCATP1nogKV8B92X0XEL58Fk4XYEvXp0=;
        b=iLx2rEOdHH+hoqQT26fVLrZ9Q3yOIAKjF6emnspGK52rVg1Ft164xqBxog6M/gtFSu/MYx
        lMacxRBZQ6rKHYVSUK8lgc4kK7QdmchBXGJ4/Yled0wIwtO5xiAYdpE0UsE/vnXwlYET5i
        iYdB56600cgMEAE32n/sEKj6jfMrwRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYlAYuVg6wipCATP1nogKV8B92X0XEL58Fk4XYEvXp0=;
        b=UnO6qwxRRIiKfWnIwDFYda7YEZkHvdGyJgmj54wIJnT2NupA3iZnxZ2LZkDfHrvYslPdDS
        8Q2u/4w9YeJKbKCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A6E85A3B93;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id A39085191FA3; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 35/73] sata_promise: Drop pointless VPRINTK() calls and convert the remaining ones
Date:   Wed,  8 Dec 2021 17:32:17 +0100
Message-Id: <20211208163255.114660-36-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drop pointless VPRINTK() calls for entering and existing interrupt
routines and convert the remaining calls to dev_dbg().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_promise.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 7815da8ef9e5..1059beae8720 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -596,7 +596,8 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
 
 			prd[idx].addr = cpu_to_le32(addr);
 			prd[idx].flags_len = cpu_to_le32(len & 0xffff);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+			ata_port_dbg(ap, "PRD[%u] = (9x%X, 0x%X)\n",
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

