Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEB8C4321E
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhLUHXA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52674 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbhLUHWp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6AC7A21907;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrEudEIXK+K3PRbKsSlQghrQBZx95ZqW9Whs3g+DuR8=;
        b=fQU/9YSSXOww9LQB1Yspc7U0ojfEooU64VTwM1VlU94pormFCDo/oBSEuXfxSfbOVqAdyb
        XgbP32sjmQMd25iRJebMrnmnO++Dhr/7qbRT0d6jYOtD7IxaL2VtPp43964gB5G0U7KKxb
        UbIPNaMKI2Qij4C64h3HlA/pa1F2SHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrEudEIXK+K3PRbKsSlQghrQBZx95ZqW9Whs3g+DuR8=;
        b=Xf6383lmbA6ZAMGuTExzxqfa908qXffodhCCaZxsQizpQ6l0CQBDwIFG7jXA4V3kiNOhdU
        vHxJZJAHpm6kgoAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 660DFA3BAD;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 640F551923C8; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 43/68] libata: drop ata_msg_info()
Date:   Tue, 21 Dec 2021 08:21:06 +0100
Message-Id: <20211221072131.46673-44-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert the sole caller to ata_dev_deb() and remove the definition.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 10 +++-------
 include/linux/libata.h    |  2 --
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dcb3278471fb..81ea8241fdba 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2530,8 +2530,8 @@ int ata_dev_configure(struct ata_device *dev)
 	char modelbuf[ATA_ID_PROD_LEN+1];
 	int rc;
 
-	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
-		ata_dev_info(dev, "%s: ENTER/EXIT -- nodev\n", __func__);
+	if (!ata_dev_enabled(dev)) {
+		ata_dev_dbg(dev, "no device\n");
 		return 0;
 	}
 
@@ -5333,11 +5333,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
-	ap->msg_enable = 0x0003;
-#elif defined(ATA_DEBUG)
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO;
-#else
-	ap->msg_enable = ATA_MSG_DRV;
+	ap->msg_enable = 0x0001;
 #endif
 
 	mutex_init(&ap->scsi_scan_mutex);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bce3b50112c0..9895414492cb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -73,11 +73,9 @@
 
 enum {
 	ATA_MSG_DRV	= 0x0001,
-	ATA_MSG_INFO	= 0x0002,
 };
 
 #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
-#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
 
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
-- 
2.29.2

