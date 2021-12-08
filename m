Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19087C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhLHQgn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37752 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5338C1FE10;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CGo7pgsMUQbfa1uBles/Bjuzu4UF68QoqmMPUWBfn4=;
        b=CSvIxgrBBKdccqQKPrFSR0NizmxqznN0JOsLodI/6bXlr7a+BD6zSvw+BBvvQEsDKFkIJb
        yRsa+l/QEw45DS016YmBkaAFnZ5Jo8u5n3H5vuaimM5445OWAyXFzZNZV9NzlDg6t8IjnC
        zJ04ul+VDFnNNJAHmnMoOF+mV7/uUWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CGo7pgsMUQbfa1uBles/Bjuzu4UF68QoqmMPUWBfn4=;
        b=3xFnKrmjM8AmVEJayAPZUcrKq/f742/R2NNlEzVV6KC/btt2s2DPatFu2mY7hvqToLtQ5T
        y4DCNiXeYMTyiQDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 50F28A3BA7;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 4D1675191F85; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 20/73] libata-eh: remove DPRINTK() calls for request sense
Date:   Wed,  8 Dec 2021 17:32:02 +0100
Message-Id: <20211208163255.114660-21-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The information will printed during ata_qc_issue() anyway, so
this messages can be dropped.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a0fd38260f48..69f51616d8bd 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1422,8 +1422,6 @@ static void ata_eh_request_sense(struct ata_queued_cmd *qc,
 		return;
 	}
 
-	DPRINTK("ATA request sense\n");
-
 	ata_tf_init(dev, &tf);
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.flags |= ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
@@ -1464,8 +1462,6 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
 	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf;
 
-	DPRINTK("ATAPI request sense\n");
-
 	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
 
 	/* initialize sense_buf with the error register,
-- 
2.29.2

