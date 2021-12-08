Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F20C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhLHQi6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:38:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbhLHQhB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:37:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 824FC1FE39;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9Q2d8W9y/07HlGjKHcrCc44ZkfQaVojpO0B1Zl6p18=;
        b=p1h0M94bYstOkqD7xCV8jOG3O1UYUpCaHBQvWBeul4c1PvkPBXo6kXC3iPwmuw8H71iJGd
        2BSAabYxIRPXAZED7dG7aeqkTTISjbS7XggC2zIEJ5q5eMZiz5Fbc52k14fwFjj3FwC2OD
        mcQXk8a8ha0xB0eiy0FfE42l//SDaQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9Q2d8W9y/07HlGjKHcrCc44ZkfQaVojpO0B1Zl6p18=;
        b=A7DqDXOC2lgFeWcRH6tCZjpCooXpApZ0aPLjGgQ0yF1e1chomEeME0LXVwwKhdppfte3k+
        YlkLsW+6cRfQ3oDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7EEC7A3BDD;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 7B5EE5191FED; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 72/73] pata_hpt366: convert pr_warn() calls
Date:   Wed,  8 Dec 2021 17:32:54 +0100
Message-Id: <20211208163255.114660-73-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert pr_warn() calls to ata_dev_warn()

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_hpt366.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 06b7c4a9ec95..c29863038428 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -15,8 +15,6 @@
  *	Look into engine reset on timeout errors. Should not be required.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -183,7 +181,7 @@ static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
 
 	i = match_string(list, -1, model_num);
 	if (i >= 0) {
-		pr_warn("%s is not supported for %s\n", modestr, list[i]);
+		ata_dev_warn(dev, "%s is not supported for %s\n", modestr, list[i]);
 		return 1;
 	}
 	return 0;
-- 
2.29.2

