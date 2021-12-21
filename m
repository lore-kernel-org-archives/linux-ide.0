Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C19C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhLUHW6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhLUHWp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5BB7A21906;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GrlQ67R4gBRQ12R47y9lYKyQeEgRVD6nhFsZQdmJ3k=;
        b=jWrV/QqI2yCWSSbsPZczaGKnFhkylztcGjrG9lQeKZ9iZ3CWr3Xy3T6sgiy5Jksk8CSgT9
        bfy8iwRG7tG/PM+ItmEDJ/pJj8b7Kj178fUTcIBFyhdKCaYRJAxM6YXrfG2a1xk6upZK6l
        yJwctIcX9D1mr7hnZC5p2l2OZ8uw0Fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GrlQ67R4gBRQ12R47y9lYKyQeEgRVD6nhFsZQdmJ3k=;
        b=YdCXiRkfUX48FQDTqCbWqgWFuh0LPi0ZGaOtOaIOHpwg4uAvzYmwtsb004Y+B9g5spXQhS
        RPuaXiUG3plfMNDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 56A55A3BAA;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 5493E51923C2; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 40/68] libata: drop ata_msg_malloc()
Date:   Tue, 21 Dec 2021 08:21:03 +0100
Message-Id: <20211221072131.46673-41-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
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
index 1e386b5cb658..207d19822ef9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5342,7 +5342,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
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

