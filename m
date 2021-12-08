Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FA6C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhLHQgl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40666 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbhLHQge (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 68D552191E;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWz15oJAnrCCmFS46dTwPoqchTAa1H7GAPaoks9AMYc=;
        b=il/QWQm/DWM3vcg9JsqhckgxagfiZ5JPUXj4kuevxzjMCAOx4pqXJda3iCvelfBYeHTFHw
        wwpk2B7Qnl5/RYhdSPE22+AtSGrI1uRuJVFLKsNcTOg8MDa+Hln/SFX6ywAAqundSrVhaf
        PzPTWBLSBgANpvVMghqGxdpl/MyUVwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWz15oJAnrCCmFS46dTwPoqchTAa1H7GAPaoks9AMYc=;
        b=YA7SYnO0znW1NVAhLMQiBu2d+26wi+9T8mavrjRwxJwebi4Oaxh4Mkei3OLS4uSlpeO+Ky
        uzqqzqgXoq0dCNAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 65ED4A3BAB;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 626B75191F8D; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 24/73] pata_octeon_cf: remove DPRINTK() macro in interrupt context
Date:   Wed,  8 Dec 2021 17:32:06 +0100
Message-Id: <20211208163255.114660-25-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is only so much information to be glanced when the interrupt
routine in called and exited, so remove these DPRINTK() calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_octeon_cf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index f86dabcecf9d..7b80bbd9b1ed 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -668,7 +668,6 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	DPRINTK("ENTER\n");
 	for (i = 0; i < host->n_ports; i++) {
 		u8 status;
 		struct ata_port *ap;
@@ -722,7 +721,6 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
 		}
 	}
 	spin_unlock_irqrestore(&host->lock, flags);
-	DPRINTK("EXIT\n");
 	return IRQ_RETVAL(handled);
 }
 
-- 
2.29.2

