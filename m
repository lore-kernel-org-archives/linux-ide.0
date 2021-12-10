Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F3C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhLJHd3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34970 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbhLJHdP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 28C56212BE;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UARi+nU2JLYllmXUPxhINKp1TG7iV56gX6Luyhf4UxY=;
        b=UAFbGnLsOKfG82ERA0bUzGIvd4+D3FpEQEri1YL5Y7+b05yg4l42/ofL9wRYjVv1TBlf5g
        XPnU8NvzdcnJp7nGZjtA37FhyKHC4OifPgGuhLwcoNIDeZOsNBGHwLffYOm14ekoknk45T
        +xAyezVXV3n01oHy2Sk9Wi0eVKijzKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UARi+nU2JLYllmXUPxhINKp1TG7iV56gX6Luyhf4UxY=;
        b=jhikFXKIAdKeWN/9LwUZ9ehoHOW7xQsnZ3paNxcuJPaspJjXP4ICQIeTtQavtvWbhEowxo
        DBgXnKlvFkk5RvBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 25201A3BC6;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 228595192085; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 50/68] pata_cs5520: convert printk() calls
Date:   Fri, 10 Dec 2021 08:28:47 +0100
Message-Id: <20211210072905.15666-51-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211210072905.15666-1-hare@suse.de>
References: <20211210072905.15666-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Convert printk() calls to structured logging.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/pata_cs5520.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 247c14702624..24ce8665b1f9 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -153,12 +153,12 @@ static int cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Perform set up for DMA */
 	if (pci_enable_device_io(pdev)) {
-		printk(KERN_ERR DRV_NAME ": unable to configure BAR2.\n");
+		dev_err(&pdev->dev, "unable to configure BAR2.\n");
 		return -ENODEV;
 	}
 
 	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
-		printk(KERN_ERR DRV_NAME ": unable to configure DMA mask.\n");
+		dev_err(&pdev->dev, "unable to configure DMA mask.\n");
 		return -ENODEV;
 	}
 
-- 
2.29.2

