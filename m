Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B8AC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 25 May 2022 11:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbiEYLty (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 25 May 2022 07:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiEYLtx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 25 May 2022 07:49:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01192A204F
        for <linux-ide@vger.kernel.org>; Wed, 25 May 2022 04:49:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B4D19219EE;
        Wed, 25 May 2022 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653479390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xdyMBUO04cdbUmhXCYkddqievf/CGeiSvBwOOBMjFaM=;
        b=OEYD9o/OfPNnRIW9YjYqjSzF3izTPkyktPuf6nkjYcrN+oqZomKQcaQ17jXqEGdQ5NaYwO
        4D9OrxDQG578FOw1/ih8cY35x/idyPLMzeJ8zWBvgG8/HxCI60WvtQaz5+ZylEicTAyydJ
        mjXR6tere20b5WO6b1p7Fskp4Mz/9ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653479390;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xdyMBUO04cdbUmhXCYkddqievf/CGeiSvBwOOBMjFaM=;
        b=Y8RyDqaby/E72tldf82N+v5t7mTRfKMMPWpbh1tZJREf5ALiRoY3+MNAyQYB1i/X/ac8k+
        tffdTYc8LD6nP2Cg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 828C52C142;
        Wed, 25 May 2022 11:49:50 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 0283D51946D2; Wed, 25 May 2022 13:49:49 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] libata: drop 'sas_last_tag'
Date:   Wed, 25 May 2022 13:49:42 +0200
Message-Id: <20220525114942.92934-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Unused now.

Fixes: 4f1a22ee7b57 ("libata: Improve ATA queued command allocation")

Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/libata.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 732de9014626..0f2a59c9c735 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -822,7 +822,6 @@ struct ata_port {
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE + 1];
 	u64			qc_active;
 	int			nr_active_links; /* #links with active qcs */
-	unsigned int		sas_last_tag;	/* track next tag hw expects */
 
 	struct ata_link		link;		/* host default link */
 	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
-- 
2.29.2

