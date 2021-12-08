Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A2BC43219
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhLHQjD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:39:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37758 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbhLHQgp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1ACFA1FE27;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jf/2te8/Iq6zVrVN/Zft0Qtd4YMkGfa/QAMO8GKX6xI=;
        b=d0ArB6bZFJWRw7ZgvWw6kiZkxjeawTS/giAjawyU+/Bp6n9WKsTXm+4+/KP6Wjwupbop09
        zlFnegPt8wAESDliVm+1qC1hm5YL5cHp9tCwKWEnFcgk4BroHs1v5s3fAKpnyJGIc+eXhQ
        4gcQIfRHFss4yxGNl+Ae9+jIr71/+nY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jf/2te8/Iq6zVrVN/Zft0Qtd4YMkGfa/QAMO8GKX6xI=;
        b=ECVZScvnv81AFPYN3WuN8T5RkIETN7jG0glvgtAirfhEMoxUhosIzxz4pl5naVw/QaeN+q
        V15q5bq6RaA76yAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 17564A3BC8;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 137185191FC5; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 52/73] libata: remove 'new' ata message handling
Date:   Wed,  8 Dec 2021 17:32:34 +0100
Message-Id: <20211208163255.114660-53-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
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

