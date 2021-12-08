Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC565C43217
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbhLHQgh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37604 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhLHQgd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3CDEB1FD5B;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhkTFQTCRJ412Th5CbwFMgLgkHUTgRXyavybPzQlykM=;
        b=HoAroIN274ylQxTJNrv6jAM9pBwOQyPbnkUbCEBNJRPoeZKe4Y5/sK2bBvfCLKan7lWgP9
        n+gd8LEOMwFmbos/PU9HDhlXCPoucmTgzLKmeRzgMCmMjDuiqVD41/XxkrRTEa5FXyfTmB
        yFX3rWmqItJBf6yr/Xg/JjRinWqIFco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhkTFQTCRJ412Th5CbwFMgLgkHUTgRXyavybPzQlykM=;
        b=lVQPinZtDj3Xc+/gKFQ9jSvTY2Q0F2RjpZi2glgfs93QbuCnRbaZNR+P3NNBN3k5mPk/Vp
        UMCy3Nh7F9gYpzCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 3198DA3B9F;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 1C6745191F73; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 11/73] pata_octeon_cf: add bmdma tracepoints and drop DPRINTK() calls
Date:   Wed,  8 Dec 2021 17:31:53 +0100
Message-Id: <20211208163255.114660-12-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add missing bmdma tracepoints and drop the now pointless
DPRINTK() calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_octeon_cf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 06468a1f4807..f86dabcecf9d 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -19,7 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <scsi/scsi_host.h>
-
+#include <trace/events/libata.h>
 #include <asm/byteorder.h>
 #include <asm/octeon/octeon.h>
 
@@ -535,12 +535,10 @@ static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
 	struct octeon_cf_port *cf_port;
 
 	cf_port = ap->private_data;
-	DPRINTK("ENTER\n");
 	/* issue r/w command */
 	qc->cursg = qc->sg;
 	cf_port->dma_finished = 0;
 	ap->ops->sff_exec_command(ap, &qc->tf);
-	DPRINTK("EXIT\n");
 }
 
 /**
@@ -792,8 +790,11 @@ static unsigned int octeon_cf_qc_issue(struct ata_queued_cmd *qc)
 	case ATA_PROT_DMA:
 		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
 
+		trace_ata_tf_load(ap, &qc->tf);
 		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
+		trace_ata_bmdma_setup(ap, &qc->tf, qc->tag);
 		octeon_cf_dma_setup(qc);	    /* set up dma */
+		trace_ata_bmdma_start(ap, &qc->tf, qc->tag);
 		octeon_cf_dma_start(qc);	    /* initiate dma */
 		ap->hsm_task_state = HSM_ST_LAST;
 		break;
-- 
2.29.2

