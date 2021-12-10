Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955B8C4332F
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbhLJHdE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34986 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbhLJHcz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:32:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B765621119;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fx0lNbafJTgIYjoVBCw18SjATvqY4RnscSQ2Z/azW/M=;
        b=KRsH/PlG2H/iFPtFoxYE8yHhS8CJlALkfRKvVZLo6sSFjwBVxVyLbpRBy8xQJrCEGyNzDY
        0sYvHAcLovOEjuZFsfiF75ff18Cmoh8p8GLLbYxkluBD1BhtkjG+pwtzA2il6Mw7QiJwxI
        g7F+RefgtFSvED8THkZoR7Inhl92Ow4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121358;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fx0lNbafJTgIYjoVBCw18SjATvqY4RnscSQ2Z/azW/M=;
        b=IXUkKVjCW6LsTONqUwqi5jnVzi2vsEvQlT2H2e0gtbKYB54eGppDDQ3/dUK4xFKm+Jg2Rz
        HAE250NHeYRpM+BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id B3383A3BAB;
        Fri, 10 Dec 2021 07:29:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id B0823519204B; Fri, 10 Dec 2021 08:29:18 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 21/68] sata_qstor: replace DPRINTK() with ata_port_dbg()
Date:   Fri, 10 Dec 2021 08:28:18 +0100
Message-Id: <20211210072905.15666-22-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_qstor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index ef00ab644afb..2b4ccdca71c6 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -374,8 +374,8 @@ static inline unsigned int qs_intr_pkt(struct ata_host *host)
 			struct qs_port_priv *pp = ap->private_data;
 			struct ata_queued_cmd *qc;
 
-			DPRINTK("SFF=%08x%08x: sCHAN=%u sHST=%d sDST=%02x\n",
-					sff1, sff0, port_no, sHST, sDST);
+			ata_dev_dbg(ap, "SFF=%08x%08x: sHST=%d sDST=%02x\n",
+				    sff1, sff0, sHST, sDST);
 			handled = 1;
 			if (!pp || pp->state != qs_state_pkt)
 				continue;
-- 
2.29.2

