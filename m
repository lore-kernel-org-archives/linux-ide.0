Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB4C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbhLHQgy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40660 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbhLHQgh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2A10621B3E;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbjQ/2S2WCywK6Y2/VUW0ypr2ZcUMfXDy/CiwnlROzk=;
        b=eGVxk60kiWjuTUBVgbV5OeX7g5/RU3+n/LAdYbpWTMnMx7QGt1ogafRBES3UG1/dGG01JT
        WbVFMXR5dtoKFud9Xc2Pa+7aAzIad5frpxoTKJHk69dED0UwLVXnCMlW9HC6ZDZZLrsvk5
        KL7x6mJXeSHT5LlAb4w91p9Tb1sz/Xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbjQ/2S2WCywK6Y2/VUW0ypr2ZcUMfXDy/CiwnlROzk=;
        b=lbgQ4aSnBAeCEp1MoFqhmfpmwz2XVVQvWAVmPYVBGkc8+ndY8/RJCM4BjKRSG6O3xtgeqo
        axnHOc6JQQbUBtAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 262ACA3BCB;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 22FB55191FCB; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 55/73] pata_cmd640: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:37 +0100
Message-Id: <20211208163255.114660-56-hare@suse.de>
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
 drivers/ata/pata_cmd640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index d0bcabb58b44..1a3372a72213 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -61,7 +61,7 @@ static void cmd640_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	struct ata_device *pair = ata_dev_pair(adev);
 
 	if (ata_timing_compute(adev, adev->pio_mode, &t, T, 0) < 0) {
-		printk(KERN_ERR DRV_NAME ": mode computation failed.\n");
+		ata_dev_err(adev, DRV_NAME ": mode computation failed.\n");
 		return;
 	}
 
-- 
2.29.2

