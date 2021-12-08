Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B250C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbhLHQjE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37898 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbhLHQgo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E3D031FE22;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77xS2D+P57PGpAzQn45CuvLg0rssEIhEgbKZCY24e9o=;
        b=n3Nst5rZJt0qB2td9cDps6exyKpGO9CYq5YSadxtdpvVBdmw8ii/h7a8Tz6ZOX26zlekox
        v8by/s5cg24nxfpdccYHYqa5t5695qLEVhs8bxu/6A76xezrjy/3Ako9N3g6dT6zRBw3Dx
        JLANgQfLPgiLlZr1RBg9e5uqcsgcgFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77xS2D+P57PGpAzQn45CuvLg0rssEIhEgbKZCY24e9o=;
        b=oQWWwM8lpfWVjr4+wAucmnvPZ/RVE5p5Y1OGMs7MzqeenPW9DlVFIBOJtGnaIE4MTrN8LA
        YUt0paYZPh0AUxBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id E0B86A3BC1;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id DD7955191FB7; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 45/73] libata: drop ata_msg_error() and ata_msg_intr()
Date:   Wed,  8 Dec 2021 17:32:27 +0100
Message-Id: <20211208163255.114660-46-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Unused.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 6 +++---
 include/linux/libata.h    | 4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 982ccd761bc3..ff7e82be0a94 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5384,11 +5384,11 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
-	ap->msg_enable = 0x00FF;
+	ap->msg_enable = 0x003F;
 #elif defined(ATA_DEBUG)
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN;
 #else
-	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
+	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_WARN;
 #endif
 
 	mutex_init(&ap->scsi_scan_mutex);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a807d2d43d70..a3f35735fd27 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -78,8 +78,6 @@ enum {
 	ATA_MSG_WARN	= 0x0008,
 	ATA_MSG_MALLOC	= 0x0010,
 	ATA_MSG_CTL	= 0x0020,
-	ATA_MSG_INTR	= 0x0040,
-	ATA_MSG_ERR	= 0x0080,
 };
 
 #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
@@ -88,8 +86,6 @@ enum {
 #define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
 #define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
 #define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
-#define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
-#define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
 
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
-- 
2.29.2

