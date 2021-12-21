Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589EBC433F5
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhLUHXJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55896 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8FB3C1F3CF;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55ob9wRgY316G4QnCUwCpSNoqFxPM1YZRUtMfN+tNFM=;
        b=uSbIuq7CLZzzvcT15zHjyX9W+S5d1MWNBvIqRsl1nSIyJ3X6ELk3cMRElT/jaURj3qzjTs
        137WCPIpVXzaQsSYDUq8fRQGL3jKI+kKf+LYEjdFXuP5Ca/nIRUuJzNpk3Vn5TduNYt8J5
        aQHbb7T2+wPUGd1nVJu+6Zjwyqsi5os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=55ob9wRgY316G4QnCUwCpSNoqFxPM1YZRUtMfN+tNFM=;
        b=PdyyKRNPgdV9y84uSsW3PhrIjwUy5GDi9jLc6PqNZ9X2Ub733baoiTQ5NMsCl2Vb914mL6
        kzY1vZTskAs09/BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 8A746A3BB6;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 87F8051923DA; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 52/68] pata_cypress: convert printk() calls
Date:   Tue, 21 Dec 2021 08:21:15 +0100
Message-Id: <20211221072131.46673-53-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert printk() calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_cypress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index 5b3a7a8ebef6..3be5d52a777b 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -62,7 +62,7 @@ static void cy82c693_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	u32 addr;
 
 	if (ata_timing_compute(adev, adev->pio_mode, &t, T, 1) < 0) {
-		printk(KERN_ERR DRV_NAME ": mome computation failed.\n");
+		ata_dev_err(adev, DRV_NAME ": mome computation failed.\n");
 		return;
 	}
 
-- 
2.29.2

