Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3088C433F5
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhLUHXH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55894 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbhLUHWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A05A51F3D1;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u77Gi0ul4Ky4xOOmIlJD16ZQ2JKY9PNS66ja49ZXAKg=;
        b=uxYLPq4lsSxKh+R7OWPKSd+khjg0MC+AFGjrWAZFkHTCvllxC9iTMPhtajb+6Q+pefiP4l
        C/hn0VIUf/6VJ/RKs9gl99+Yy4m7OhRacZAumDX08n/SdepdyvTX0t4r36HGT8jOkgG23G
        if1CjYsErCtKLdeQIo8Fk6ka+0FUro4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u77Gi0ul4Ky4xOOmIlJD16ZQ2JKY9PNS66ja49ZXAKg=;
        b=O9DSzJJok7BNJlkzvVrnq8MrpUfr/SujQ6Y/U+9qaqYq/bMrzN7Y0TWCQ/oULabxRbsVwu
        eRKK8+RwAdlErABA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9C52AA3BBA;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 9A09A51923E2; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 56/68] pata_serverworks: convert printk() calls
Date:   Tue, 21 Dec 2021 08:21:19 +0100
Message-Id: <20211221072131.46673-57-hare@suse.de>
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
 drivers/ata/pata_serverworks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index b602e303fb54..e410fe44177f 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -286,13 +286,13 @@ static int serverworks_fixup_osb4(struct pci_dev *pdev)
 		pci_read_config_dword(isa_dev, 0x64, &reg);
 		reg &= ~0x00002000; /* disable 600ns interrupt mask */
 		if (!(reg & 0x00004000))
-			printk(KERN_DEBUG DRV_NAME ": UDMA not BIOS enabled.\n");
+			dev_info(&pdev->dev, "UDMA not BIOS enabled.\n");
 		reg |=  0x00004000; /* enable UDMA/33 support */
 		pci_write_config_dword(isa_dev, 0x64, reg);
 		pci_dev_put(isa_dev);
 		return 0;
 	}
-	printk(KERN_WARNING DRV_NAME ": Unable to find bridge.\n");
+	dev_warn(&pdev->dev, "Unable to find bridge.\n");
 	return -ENODEV;
 }
 
-- 
2.29.2

