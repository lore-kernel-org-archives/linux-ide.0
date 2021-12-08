Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6E7C4167B
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbhLHQgg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37600 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbhLHQgd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3DF171FD5D;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3DM/hKB0hRPPlhnRvPJ6JiZgJFQp98kiic9tOANGXY=;
        b=IJQYLB1j2mKgndsmHtUWDy+Hv7CsZW5es1sOKccCGpZfx32BtECigBRoyuP9Fhr59466h3
        3ilXdUqtRtQYGtdavNvShLLY6JeKN5Mm4Rveujuw0EEgbwKWlSfmm59lFbQZGRffY4evCM
        GI875fAtGFw7sxmXMvJKuIJu9p2P0UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3DM/hKB0hRPPlhnRvPJ6JiZgJFQp98kiic9tOANGXY=;
        b=2XkQZ6g/fRYlgknJVyN3E9vKJKdMRvsFCRgkz8VKardd707iiFAp08VKBsC2qg375yk41T
        jnX5cShhpoez0dDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 313BAA3B9E;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 2170B5191F75; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 12/73] pata_arasan_cf: use generic tracepoints
Date:   Wed,  8 Dec 2021 17:31:54 +0100
Message-Id: <20211208163255.114660-13-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

For completeness add generic tracepoints for bus-master DMA.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_arasan_cf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 63f39440a9b4..24c3d5e1fca3 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -39,6 +39,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <trace/events/libata.h>
 
 #define DRIVER_NAME	"arasan_cf"
 #define TIMEOUT		msecs_to_jiffies(3000)
@@ -703,9 +704,11 @@ static unsigned int arasan_cf_qc_issue(struct ata_queued_cmd *qc)
 	case ATA_PROT_DMA:
 		WARN_ON_ONCE(qc->tf.flags & ATA_TFLAG_POLLING);
 
+		trace_ata_tf_load(ap, &qc->tf);
 		ap->ops->sff_tf_load(ap, &qc->tf);
 		acdev->dma_status = 0;
 		acdev->qc = qc;
+		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
 		arasan_cf_dma_start(acdev);
 		ap->hsm_task_state = HSM_ST_LAST;
 		break;
-- 
2.29.2

