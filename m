Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB2C3F2DA
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8AB205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgCCJjo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:47676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbgCCJjo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AC1A5B1E4;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/40] ata_piix: remove debugging messages
Date:   Tue,  3 Mar 2020 10:37:40 +0100
Message-Id: <20200303093813.18523-8-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drop pointless debugging message for PCI setup.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/ata_piix.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 3ca7720e7d8f..10ebe8daf1a5 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1343,7 +1343,6 @@ static void piix_init_pcs(struct ata_host *host,
 	new_pcs = pcs | map_db->port_enable;
 
 	if (new_pcs != pcs) {
-		DPRINTK("updating PCS from 0x%x to 0x%x\n", pcs, new_pcs);
 		pci_write_config_word(pdev, ICH5_PCS, new_pcs);
 		msleep(150);
 	}
@@ -1767,14 +1766,12 @@ static int __init piix_init(void)
 {
 	int rc;
 
-	DPRINTK("pci_register_driver\n");
 	rc = pci_register_driver(&piix_pci_driver);
 	if (rc)
 		return rc;
 
 	in_module_init = 0;
 
-	DPRINTK("done\n");
 	return 0;
 }
 
-- 
2.16.4

