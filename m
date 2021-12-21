Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79A6C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhLUHWy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52644 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbhLUHWo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 194EB218FF;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUr89Y5HpgkkF/uM/q+wvN3DYOiVSARmeDaOdBXDZKg=;
        b=w/klb6IrcL7kLj6SWsSfgY9OE5GfDzc8jlgcIkFinWtKkNM9iJ7izWjDFYFEFklLxDaZmY
        8hL78QS1+vdNiALG0SBGvWyxDl/69IHwMBXe3+9y/8MqvOD/Iv/tA9jFadK7s3dXP+Ixj9
        56kG2kMRO+DekLb0nNSmpNDBRBDqFzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUr89Y5HpgkkF/uM/q+wvN3DYOiVSARmeDaOdBXDZKg=;
        b=ujB8TC9+7H45q8qmz/Uts3LkG4RfIGa5Z6xsME46A1mwxncPKJqyzEe7gu76VcPYnK2ERG
        eHTfrd25/Oia8TCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1420AA3B9E;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 1202051923A6; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 26/68] pata_octeon_cf: Drop pointless VPRINTK() calls and convert the remaining one
Date:   Tue, 21 Dec 2021 08:20:49 +0100
Message-Id: <20211221072131.46673-27-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drop pointless VPRINTK() calls and convert the remaining calls to
the existing bmdma tracepoint.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_octeon_cf.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 07eda263b4c1..a2e7dcaa87ac 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -477,23 +477,11 @@ static void octeon_cf_tf_load16(struct ata_port *ap,
 		__raw_writew(tf->hob_feature << 8, base + 0xc);
 		__raw_writew(tf->hob_nsect | tf->hob_lbal << 8, base + 2);
 		__raw_writew(tf->hob_lbam | tf->hob_lbah << 8, base + 4);
-		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->hob_feature,
-			tf->hob_nsect,
-			tf->hob_lbal,
-			tf->hob_lbam,
-			tf->hob_lbah);
 	}
 	if (is_addr) {
 		__raw_writew(tf->feature << 8, base + 0xc);
 		__raw_writew(tf->nsect | tf->lbal << 8, base + 2);
 		__raw_writew(tf->lbam | tf->lbah << 8, base + 4);
-		VPRINTK("feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->feature,
-			tf->nsect,
-			tf->lbal,
-			tf->lbam,
-			tf->lbah);
 	}
 	ata_wait_idle(ap);
 }
@@ -553,8 +541,6 @@ static void octeon_cf_dma_start(struct ata_queued_cmd *qc)
 	union cvmx_mio_boot_dma_intx mio_boot_dma_int;
 	struct scatterlist *sg;
 
-	VPRINTK("%d scatterlists\n", qc->n_elem);
-
 	/* Get the scatter list entry we need to DMA into */
 	sg = qc->cursg;
 	BUG_ON(!sg);
@@ -595,10 +581,6 @@ static void octeon_cf_dma_start(struct ata_queued_cmd *qc)
 
 	mio_boot_dma_cfg.s.adr = sg_dma_address(sg);
 
-	VPRINTK("%s %d bytes address=%p\n",
-		(mio_boot_dma_cfg.s.rw) ? "write" : "read", sg->length,
-		(void *)(unsigned long)mio_boot_dma_cfg.s.adr);
-
 	cvmx_write_csr(cf_port->dma_base + DMA_CFG, mio_boot_dma_cfg.u64);
 }
 
@@ -617,9 +599,7 @@ static unsigned int octeon_cf_dma_finished(struct ata_port *ap,
 	union cvmx_mio_boot_dma_intx dma_int;
 	u8 status;
 
-	VPRINTK("ata%u: protocol %d task_state %d\n",
-		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
-
+	trace_ata_bmdma_stop(qc, &qc->tf, qc->tag);
 
 	if (ap->hsm_task_state != HSM_ST_LAST)
 		return 0;
-- 
2.29.2

