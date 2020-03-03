Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530F9C3F2D7
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC4F205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgCCJjx (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:47866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgCCJjt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 37646B250;
        Tue,  3 Mar 2020 09:39:42 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 39/40] libata: kill ATA_MSG_CTL
Date:   Tue,  3 Mar 2020 10:38:12 +0100
Message-Id: <20200303093813.18523-40-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

All instances had been converted to ata_XXX_dbg() anyway, so
the conditional is pointless anyway.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 5 ++---
 include/linux/libata.h    | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 28da32d2dce8..18c40cd19290 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1859,8 +1859,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	int may_fallback = 1, tried_spinup = 0;
 	int rc;
 
-	if (ata_msg_ctl(ap))
-		ata_dev_dbg(dev, "ENTER\n");
+	ata_dev_dbg(dev, "ENTER\n");
 
 retry:
 	ata_tf_init(dev, &tf);
@@ -6036,7 +6035,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	/* turn on all debugging levels */
 	ap->msg_enable = 0x00FF;
 #elif defined(ATA_DEBUG)
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_WARN | ATA_MSG_ERR;
 #else
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
 #endif
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2b89e769e736..41dce03da7ef 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -73,7 +73,6 @@ enum {
 	ATA_MSG_PROBE	= 0x0004,
 	ATA_MSG_WARN	= 0x0008,
 	ATA_MSG_MALLOC	= 0x0010,
-	ATA_MSG_CTL	= 0x0020,
 	ATA_MSG_INTR	= 0x0040,
 	ATA_MSG_ERR	= 0x0080,
 };
@@ -82,7 +81,6 @@ enum {
 #define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
 #define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
 #define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
-#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
 #define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
 #define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
 
-- 
2.16.4

