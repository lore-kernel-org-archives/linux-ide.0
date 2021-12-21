Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E4C433FE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhLUHXD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55892 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbhLUHWu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 726C81F3CB;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jf/2te8/Iq6zVrVN/Zft0Qtd4YMkGfa/QAMO8GKX6xI=;
        b=P5vCAfeBB4aENUxOVvBGeYcg9I3mxquzPkmgvjM+Bo8+l9cIakGmp6AC1JB2Ee2NcpI0CR
        FfbuRzx7L0dosnjLOFtc+ig5UPMVqQMaxOLXi4AHZoCsCuFRYafXywO0lVPd60e0WdvAj5
        lcUBOsVOhw/iA1DuWcTgAJlCDk0qT5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jf/2te8/Iq6zVrVN/Zft0Qtd4YMkGfa/QAMO8GKX6xI=;
        b=JkUjfll4MP6uWW4w3k/kkgx7a1OlOBnUjUdRSAS89UkPti2B1zLGi2KrKLMVZaE53s+A2i
        IPQaTxQqUwP2hHBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6E30CA3BAF;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 6C9F151923CC; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 45/68] libata: remove 'new' ata message handling
Date:   Tue, 21 Dec 2021 08:21:08 +0100
Message-Id: <20211221072131.46673-46-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
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

