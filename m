Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B958FC7EE22
	for <linux-ide@archiver.kernel.org>; Wed, 10 May 2023 22:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbjEJWwn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 May 2023 18:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbjEJWwi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 May 2023 18:52:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67893A8E
        for <linux-ide@vger.kernel.org>; Wed, 10 May 2023 15:52:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EAEC921995;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683759141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QXyeiiGP4qKEt0yml/u/WwYaJt0LoaHb6CkZJujK14=;
        b=ORkhCfOYMo8fQ6BkxcfSC0xp/N7Wmq1zicP95mzSh8imMd4IrZOTyIZZIFZCWrHdypTsN4
        pL3Tel2HrT4Kz6gCU+/0dPo4iPaxzzXjclUOjjIbLa7U9cYiJMoDH8OXg/bIXbX14btyqM
        KX4M2w+R5L0vwYa9nKO/ooXAsQRK9Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683759141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QXyeiiGP4qKEt0yml/u/WwYaJt0LoaHb6CkZJujK14=;
        b=FgBrbFcO9piNrbC8SW4e3pup+tPMRWKkq7CrSS+znaNDhgN9nPFpT63MuF1rrXV5118djE
        3n2ZRXmZzscgnmDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id E0BF22C14E;
        Wed, 10 May 2023 22:52:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id DD61351C34E9; Thu, 11 May 2023 00:52:21 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/6] ata: inline ata_port_probe()
Date:   Thu, 11 May 2023 00:52:10 +0200
Message-Id: <20230510225211.111113-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230510225211.111113-1-hare@suse.de>
References: <20230510225211.111113-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Just used in one place.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 920ebea69cd8..fda2db541bf9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5693,14 +5693,6 @@ void __ata_port_probe(struct ata_port *ap)
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 
-int ata_port_probe(struct ata_port *ap)
-{
-	__ata_port_probe(ap);
-	ata_port_wait_eh(ap);
-	return 0;
-}
-
-
 static void async_port_probe(void *data, async_cookie_t cookie)
 {
 	struct ata_port *ap = data;
@@ -5715,7 +5707,8 @@ static void async_port_probe(void *data, async_cookie_t cookie)
 	if (!(ap->host->flags & ATA_HOST_PARALLEL_SCAN) && ap->port_no != 0)
 		async_synchronize_cookie(cookie);
 
-	(void)ata_port_probe(ap);
+	__ata_port_probe(ap);
+	ata_port_wait_eh(ap);
 
 	/* in order to keep device order, we need to synchronize at this point */
 	async_synchronize_cookie(cookie);
-- 
2.35.3

