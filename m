Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2ACC43217
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhLHQhF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:37:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37830 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbhLHQgv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3A5671FE2B;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxiFMvEkE8elYIQiJSopS6YD7z3r8ceaaifDdsBuBcM=;
        b=i0vCxkgxACDWsfw/58BKmEsMaaMRU1VDzF01CWRO4dxqwg5rsdQtMoOyuKUEp/ng5XK0LU
        TCMNmS4kXJ2DqPOIr2i2QbxGRs6YakPWOhQSQvEVzUpHGs2ot1Z0Z98N8ycDX1dDBVx2D2
        C9v2kku+ItP5/gF14N0Nud7SzAcJq7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxiFMvEkE8elYIQiJSopS6YD7z3r8ceaaifDdsBuBcM=;
        b=WbbrOC4ZwPRvFdMeGFqNR23wrnZSuiWZg/vbMwfZmNEO+ficaSsN1eSzOlfJWwY+JsaOP/
        tBVmJKEU7QeJllDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 365DDA3BCE;
        Wed,  8 Dec 2021 16:33:01 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 335E65191FD1; Wed,  8 Dec 2021 17:33:01 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 58/73] pata_cs5536: convert blank printk() calls
Date:   Wed,  8 Dec 2021 17:32:40 +0100
Message-Id: <20211208163255.114660-59-hare@suse.de>
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
 drivers/ata/pata_cs5536.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 760ac6e65216..ab47aeb5587f 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -263,12 +263,12 @@ static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	ppi[1] = &ata_dummy_port_info;
 
 	if (use_msr)
-		printk(KERN_ERR DRV_NAME ": Using MSR regs instead of PCI\n");
+		dev_err(&dev->dev, DRV_NAME ": Using MSR regs instead of PCI\n");
 
 	cs5536_read(dev, CFG, &cfg);
 
 	if ((cfg & IDE_CFG_CHANEN) == 0) {
-		printk(KERN_ERR DRV_NAME ": disabled by BIOS\n");
+		dev_err(&dev->dev, DRV_NAME ": disabled by BIOS\n");
 		return -ENODEV;
 	}
 
-- 
2.29.2

