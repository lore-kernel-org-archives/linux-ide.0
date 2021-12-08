Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41406C4321E
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbhLHQjD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37900 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbhLHQgo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EDAD01FE24;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oH+ZuOHHHuAfeZRe/18k/M+rF+SyQDUabTY42XBAPuM=;
        b=NsXiH6f8XweUZXlIwhVBAmMbqeewkZ/uYYn15oYJgKCPFkcdSx1It1dw7eymBwsOKWNPP2
        q+fdbYPlxdSRXoZJ49mrKMzyn/XFMM5hIzkley9MJfXCz93Ef3BhtI3YIpGiK1F/t0kkWC
        oVZW+jQEmWpwuA+okqzyBacR7iCLSIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oH+ZuOHHHuAfeZRe/18k/M+rF+SyQDUabTY42XBAPuM=;
        b=nVocmnAnIfvScehhqBiQ45h+u6hKbKLv87NzJ7siT5ux5tjaMf0UzpATCB3tAk4lnx0d6p
        W9EgBTZmDaiA4eCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id EB849A3BC3;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id E84AF5191FBB; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 47/73] libata: drop ata_msg_malloc()
Date:   Wed,  8 Dec 2021 17:32:29 +0100
Message-Id: <20211208163255.114660-48-hare@suse.de>
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
 drivers/ata/libata-core.c | 2 +-
 include/linux/libata.h    | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 691dfa1f01c5..00d3bb8c87af 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5381,7 +5381,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
-	ap->msg_enable = 0x001F;
+	ap->msg_enable = 0x000F;
 #elif defined(ATA_DEBUG)
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_WARN;
 #else
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fc7f64646e5b..8bde38e3debd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -76,14 +76,12 @@ enum {
 	ATA_MSG_INFO	= 0x0002,
 	ATA_MSG_PROBE	= 0x0004,
 	ATA_MSG_WARN	= 0x0008,
-	ATA_MSG_MALLOC	= 0x0010,
 };
 
 #define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
 #define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
 #define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
 #define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
-#define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
 
 static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
 {
-- 
2.29.2

