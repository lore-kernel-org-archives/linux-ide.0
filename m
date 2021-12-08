Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6106AC4167B
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhLHQhE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37832 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbhLHQgv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3E3E41FE2C;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iL/zGESU+Racb2Xc96M+d4ZoU+UWYk8ZKy9JJfGVwmc=;
        b=EN0BJerVrgkgFtMkNr7DLVc/I7Mzc3xM8u8huv9Z8XLv0bY6p+R+WIsFCLDiVKc8QtYnlU
        KrUaIEc/7G+iLNwbDQIhYloZ8DEmp1Tr1MEkBnkZakEkEhhgq1+P1dgbESp0SBK7aUGIwO
        dXcM3503LHTA0CQHwfIFumfSJTls39A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iL/zGESU+Racb2Xc96M+d4ZoU+UWYk8ZKy9JJfGVwmc=;
        b=SudrlHLoLfObAHv6Dp3U/kOu0gDp5KDGpbNi/uLBkv+AUiepunGtcTeWGkpQXw2uXRTV4e
        ZlyFS/tpEdZtIoAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 3C354A3BCF;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 391A55191FD3; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 59/73] pata_cypressx: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:41 +0100
Message-Id: <20211208163255.114660-60-hare@suse.de>
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

