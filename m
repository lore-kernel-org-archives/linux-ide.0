Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48096C43217
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhLHQgn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40674 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7F8E521958;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fx0lNbafJTgIYjoVBCw18SjATvqY4RnscSQ2Z/azW/M=;
        b=BxhXkUlnQTi2vAK3ks/bH1vksQ2r7iQsibezZKxWMHtzj0czizkRJb+SwMgkDOC2yptCTH
        3A2cGafFJEK1TXqKs8fj7XPXQNVeUqWJOWJKorjmxp4WkUAnH3USgMMt7Tn3kWteQdMXCn
        E6HfIxDi7Io1t9VGGrNOXA77wNThKO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fx0lNbafJTgIYjoVBCw18SjATvqY4RnscSQ2Z/azW/M=;
        b=W9P/nhTUx3MRiLIjvOyneGwjpn+YZwFijR6BiWiGQgl2/5pMEmuYPIOI989kzDyQMdoLC0
        poOqxU26lEorasCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7B6A6A3BAF;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 7832A5191F95; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 28/73] sata_qstor: replace DPRINTK() with ata_port_dbg()
Date:   Wed,  8 Dec 2021 17:32:10 +0100
Message-Id: <20211208163255.114660-29-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
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

