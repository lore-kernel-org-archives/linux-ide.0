Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BBEC433FE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhLUHXK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55908 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C5EBB1F3D2;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nah/E6kDfHB508qVcSy/9ksLMC3mT9wgzTPNMtGtFnc=;
        b=gMJwK4lSuzsyFFhZTb2bGpe15Vpo4jlKhgACuZva7l0Y1BKXdqH5LH4bdP3JuihLSnLWW2
        tusZBC5hkp8l9ZFD6zswQvKmoZx9a2N9WPqa7X5Kv0L6XRixiP4reuxJHukmcVw2Fzcxgt
        AlZ5XsimPWa/4R6UQJ+N57nEW6BleKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nah/E6kDfHB508qVcSy/9ksLMC3mT9wgzTPNMtGtFnc=;
        b=MrDugHk0t4m29WaPNVL2aEDIzHuhysITmdkcZ5JX4wz2HwT204Y9hjOmTUkDKmjvixnDVT
        no3fN66fqgih8UAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id C11DCA3BC1;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id BEE4851923F2; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 64/68] pata_hpt366: convert pr_warn() calls
Date:   Tue, 21 Dec 2021 08:21:27 +0100
Message-Id: <20211221072131.46673-65-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert pr_warn() calls to ata_dev_warn()

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_hpt366.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 06b7c4a9ec95..778c893f276b 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -14,9 +14,6 @@
  * TODO
  *	Look into engine reset on timeout errors. Should not be required.
  */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -183,7 +180,7 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
 
 	i = match_string(list, -1, model_num);
 	if (i >= 0) {
-		pr_warn("%s is not supported for %s\n", modestr, list[i]);
+		ata_dev_warn(dev, "%s is not supported for %s\n", modestr, list[i]);
 		return 1;
 	}
 	return 0;
-- 
2.29.2

