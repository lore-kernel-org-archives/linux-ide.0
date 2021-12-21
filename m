Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9A2C4321E
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhLUHWr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:47 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhLUHWo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E577F218F3;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2ckzW0QtfcyTr1wDqE+tW3iKzkid4NvdkoMMCyo+CY=;
        b=0hmc4iiFwcreqSa+XPn/UWuyaILSjhyzvo/G7u8HXiwGWbofbdev+68htiVDWxmzPqf9Rv
        TKYmz54+XcI7OI+0sQGWpwCh3GdACa1/EbqycJB2319QFnC4oyxPv5TY7GB0+umsSf9Ywi
        5/7JlQogWusB/KF9lS7fIY6umN5IRmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2ckzW0QtfcyTr1wDqE+tW3iKzkid4NvdkoMMCyo+CY=;
        b=FGu4eVVYY6KYIbp6Dt/8+W7ixnnk5pRRodarwS4I/b3V0ZAAh0uLIWh1cDjASdLcHJHg8h
        PmsUavMf8muvGgAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id E1093A3B95;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id DFF855192394; Tue, 21 Dec 2021 08:22:41 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/68] pata_octeon_cf: remove DPRINTK() macro in interrupt context
Date:   Tue, 21 Dec 2021 08:20:40 +0100
Message-Id: <20211221072131.46673-18-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is only so much information to be glanced when the interrupt
routine is called and exited, so remove these DPRINTK() calls.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_octeon_cf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 1fe756af3268..07eda263b4c1 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -668,7 +668,6 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	DPRINTK("ENTER\n");
 	for (i = 0; i < host->n_ports; i++) {
 		u8 status;
 		struct ata_port *ap;
@@ -723,7 +722,6 @@ static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
 		}
 	}
 	spin_unlock_irqrestore(&host->lock, flags);
-	DPRINTK("EXIT\n");
 	return IRQ_RETVAL(handled);
 }
 
-- 
2.29.2

