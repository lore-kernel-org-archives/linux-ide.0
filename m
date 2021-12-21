Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19748C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhLUHXG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:06 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55886 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhLUHWx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7FFF31F3CD;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4AhgSZf/VsA90VPt4h7KPMKFmeAyN+6qG9Gu7ULn/s=;
        b=tPT0zJUTQI9wiihIQnB6OtjAh+FYiKAEn0SjHfH88VntzLxrwxNM+h81i5hcMtAocba6R0
        4hAd6Pofpdu0mxcLWEbDwpMYYKTzlB1Xn78yREoiFAMYKXEWMALAPlwOnTFq5rLAh561xb
        /cbgtAsSAc0I9cyfheb9l+OLbCuKzfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4AhgSZf/VsA90VPt4h7KPMKFmeAyN+6qG9Gu7ULn/s=;
        b=P5Ny7udKjvXLScQUKfyTCZ1FGsUZFtRBCmcoGKppoVjmGPN0FTbSRToaL1IBPhB0AWAFPV
        xKW9Sm2djDBoQBCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7A943A3BB2;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 7871751923D2; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 48/68] pata_cmd640: convert printk() calls
Date:   Tue, 21 Dec 2021 08:21:11 +0100
Message-Id: <20211221072131.46673-49-hare@suse.de>
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

