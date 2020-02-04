Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C539C3524F
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F09B20674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBDQ4V (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:34824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgBDQ4O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4345FB1DE;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 33/46] pata_sil680: Drop DPRINTK in sil_sff_exec_command()
Date:   Tue,  4 Feb 2020 17:55:34 +0100
Message-Id: <20200204165547.115220-34-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Now covered with a generic tracepoint.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_sil680.c | 1 -
 1 file changed, 1 deletion(-)

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
-- 
2.16.4

