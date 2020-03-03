Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11918C3F2D9
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E9E21739
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgCCJjz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:47726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbgCCJjt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 36EDEB24F;
        Tue,  3 Mar 2020 09:39:42 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 38/40] libata: kill ATA_MSG_INFO
Date:   Tue,  3 Mar 2020 10:38:11 +0100
Message-Id: <20200303093813.18523-39-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Just a single user, which should be converted to ata_dev_dbg() anyway.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 6 +++---
 include/linux/libata.h    | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 394545d3d8d9..28da32d2dce8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2455,8 +2455,8 @@ int ata_dev_configure(struct ata_device *dev)
 	char modelbuf[ATA_ID_PROD_LEN+1];
 	int rc;
 
-	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
-		ata_dev_info(dev, "%s: ENTER/EXIT -- nodev\n", __func__);
+	if (!ata_dev_enabled(dev)) {
+		ata_dev_dbg(dev, "ENTER/EXIT -- nodev\n");
 		return 0;
 	}
 
@@ -6036,7 +6036,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	/* turn on all debugging levels */
 	ap->msg_enable = 0x00FF;
 #elif defined(ATA_DEBUG)
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
 #else
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
 #endif
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 45b9113af639..2b89e769e736 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -70,7 +70,6 @@
 
 enum {
 	ATA_MSG_DRV	= 0x0001,
-	ATA_MSG_INFO	= 0x0002,
 	ATA_MSG_PROBE	= 0x0004,
 	ATA_MSG_WARN	= 0x0008,
 	ATA_MSG_MALLOC	= 0x0010,
@@ -80,7 +79,6 @@ enum {
 };
 
 #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
-#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
 #define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
 #define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
 #define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
-- 
2.16.4

