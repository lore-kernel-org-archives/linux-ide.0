Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC26C43219
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbhLJHd0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34968 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbhLJHdG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:06 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 16DAB212B8;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jf/2te8/Iq6zVrVN/Zft0Qtd4YMkGfa/QAMO8GKX6xI=;
        b=dUPdmo6ABoma9j4m5E1yH1OE+45uQFufBSbt4XyR4R1/V9mqyLN3j/+j4lOhGDu7CXC/62
        lTJOvPAOIy4iOIeQxZBzZcLHAmqbVs+oac5NkDgxanaXvswxsOGkHttS21WV68ZCDKjJlQ
        chpa1v0Sl3SYQb4xVAyV2YJqX3m6mfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jf/2te8/Iq6zVrVN/Zft0Qtd4YMkGfa/QAMO8GKX6xI=;
        b=kQfkke34qkkBHsqENmvgBNMOLSNTF832FJxsx+YinGPxAVE4VIeJ/3QzuBD9hlVmlS8SEb
        70Sa0t9fxU5/dXBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1192AA3BC2;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 0F330519207B; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 45/68] libata: remove 'new' ata message handling
Date:   Fri, 10 Dec 2021 08:28:42 +0100
Message-Id: <20211210072905.15666-46-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove the remaining bits for the 'new' ata message handling.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/libata.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index df10edca3433..6bfbb419e141 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -68,18 +68,6 @@
 	}							\
 })
 
-/* NEW: debug levels */
-#define HAVE_LIBATA_MSG 1
-
-static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
-{
-	if (dval < 0 || dval >= (sizeof(u32) * 8))
-		return default_msg_enable_bits; /* should be 0x1 - only driver info msgs */
-	if (!dval)
-		return 0;
-	return (1 << dval) - 1;
-}
-
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
@@ -864,7 +852,6 @@ struct ata_port {
 
 	unsigned int		hsm_task_state;
 
-	u32			msg_enable;
 	struct list_head	eh_done_q;
 	wait_queue_head_t	eh_wait_q;
 	int			eh_tries;
-- 
2.29.2

