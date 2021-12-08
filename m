Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D41C43217
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhLHQgl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 498C62190C;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KZk7qzx9eleAtVaRzEsFrp0WPFJleq0TnDrYPd8ayMQ=;
        b=mnpauY29Ckh07/gEePXJG4wUZlEtqD0mjCzY0gpmun5UEqvBCWhVsQUIXHxiTp6vkNz7ab
        a4mo51FgJoxAEVkMF7bIw2STIiAnczKdmvJ0FRjEYhNVrUNxNK2HxDlstgjDHyR9S2M2Hi
        EYUK5c7NFQlgsXVL/biCgpKDmLxZ/BQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KZk7qzx9eleAtVaRzEsFrp0WPFJleq0TnDrYPd8ayMQ=;
        b=FuziKdU1ydw9Le+TMz/qmtwNcEMxOx8fxOHIJp8ruSYjxZLiFs+CuvWd+NXqMUTes2tr02
        4DGJkxhtSN+kHcBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 328D8A3BA0;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 2CA245191F79; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 14/73] sata_nv: use generic tracepoints
Date:   Wed,  8 Dec 2021 17:31:56 +0100
Message-Id: <20211208163255.114660-15-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove logging messages covered by generic tracepoints and add
generic tracepoints for internal calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_nv.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 3c70405a0b80..995c6f19e78f 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -31,6 +31,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
 #include <linux/libata.h>
+#include <trace/events/libata.h>
 
 #define DRV_NAME			"sata_nv"
 #define DRV_VERSION			"3.5"
@@ -1434,8 +1435,6 @@ static unsigned int nv_adma_qc_issue(struct ata_queued_cmd *qc)
 
 	writew(qc->hw_tag, mmio + NV_ADMA_APPEND);
 
-	DPRINTK("Issued tag %u\n", qc->hw_tag);
-
 	return 0;
 }
 
@@ -2013,19 +2012,17 @@ static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
 	if (qc == NULL)
 		return 0;
 
-	DPRINTK("Enter\n");
-
 	writel((1 << qc->hw_tag), pp->sactive_block);
 	pp->last_issue_tag = qc->hw_tag;
 	pp->dhfis_bits &= ~(1 << qc->hw_tag);
 	pp->dmafis_bits &= ~(1 << qc->hw_tag);
 	pp->qc_active |= (0x1 << qc->hw_tag);
 
+	trace_ata_tf_load(ap, &qc->tf);
 	ap->ops->sff_tf_load(ap, &qc->tf);	 /* load tf registers */
+	trace_ata_exec_command(ap, &qc->tf, qc->hw_tag);
 	ap->ops->sff_exec_command(ap, &qc->tf);
 
-	DPRINTK("Issued tag %u\n", qc->hw_tag);
-
 	return 0;
 }
 
@@ -2037,8 +2034,6 @@ static unsigned int nv_swncq_qc_issue(struct ata_queued_cmd *qc)
 	if (qc->tf.protocol != ATA_PROT_NCQ)
 		return ata_bmdma_qc_issue(qc);
 
-	DPRINTK("Enter\n");
-
 	if (!pp->qc_active)
 		nv_swncq_issue_atacmd(ap, qc);
 	else
-- 
2.29.2

