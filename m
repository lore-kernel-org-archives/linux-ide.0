Return-Path: <SRS0=8i+5=3Y=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4A2C35251
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC4A20674
	for <linux-ide@archiver.kernel.org>; Tue,  4 Feb 2020 16:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgBDQ4O (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:56:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:34866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbgBDQ4L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 4 Feb 2020 11:56:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 352A7B1D7;
        Tue,  4 Feb 2020 16:56:05 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bartolomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 27/46] sata_rcar: drop DPRINTK call in sata_rcar_exec_command()
Date:   Tue,  4 Feb 2020 17:55:28 +0100
Message-Id: <20200204165547.115220-28-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204165547.115220-1-hare@suse.de>
References: <20200204165547.115220-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Is now logged with the generic tracepoint, so the DPRINTK call
can be removed.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_rcar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 1b42be234761..0925a0564cc5 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -436,8 +436,6 @@ static void sata_rcar_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 static void sata_rcar_exec_command(struct ata_port *ap,
 				   const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
-
 	iowrite32(tf->command, ap->ioaddr.command_addr);
 	ata_sff_pause(ap);
 }
-- 
2.16.4

