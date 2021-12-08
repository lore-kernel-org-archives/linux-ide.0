Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F8DC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbhLHQg4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:56 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40654 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbhLHQgh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2E24221B3F;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahu3y33lLuAZvY+BNhUuCSu8/afzKK+S7NkLAoqSCTw=;
        b=acc/tqZlu38ZEM1kH8rOxza4D3noiR6fB3980R79+F1VL+0SDv3YW/D1WmsbH3FnIM0/jP
        SNGFtGhUUvJuY3rRKHSa5E33vCIATIt6yy5EXvUteSzCnqdY0zGnG63wkoPHYmGApxMZ2T
        QBAK/wXyxJuMcNngsm/kghNXCJntfXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahu3y33lLuAZvY+BNhUuCSu8/afzKK+S7NkLAoqSCTw=;
        b=4XSJfbTD6lJjPE6S0sfZnZua3uBvsDakNHL7bRXDxFwdtu63m+o+UyF3gHXuPlKud2CPzv
        Ol5ImX7mAaWNP3Bg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 2B534A3BCC;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 2834B5191FCD; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 56/73] pata_cmd64x: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:38 +0100
Message-Id: <20211208163255.114660-57-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert blank printk() calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_cmd64x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 1d74d89b5bed..5baa4a7819c1 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -116,7 +116,7 @@ static void cmd64x_set_timing(struct ata_port *ap, struct ata_device *adev, u8 m
 	/* ata_timing_compute is smart and will produce timings for MWDMA
 	   that don't violate the drives PIO capabilities. */
 	if (ata_timing_compute(adev, mode, &t, T, 0) < 0) {
-		printk(KERN_ERR DRV_NAME ": mode computation failed.\n");
+		ata_dev_err(adev, DRV_NAME ": mode computation failed.\n");
 		return;
 	}
 	if (ap->port_no) {
@@ -130,7 +130,7 @@ static void cmd64x_set_timing(struct ata_port *ap, struct ata_device *adev, u8 m
 		}
 	}
 
-	printk(KERN_DEBUG DRV_NAME ": active %d recovery %d setup %d.\n",
+	ata_dev_dbg(adev, DRV_NAME ": active %d recovery %d setup %d.\n",
 		t.active, t.recover, t.setup);
 	if (t.recover > 16) {
 		t.active += t.recover - 16;
-- 
2.29.2

