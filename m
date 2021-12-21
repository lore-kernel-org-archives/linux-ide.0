Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63557C43217
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhLUHXC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:23:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52638 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhLUHWr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8DE8421921;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f49FC2ZlOR4wrmdnNE/mZJvkEpcq4Lw9i+Zt1VAAqDI=;
        b=TxETLqbgUmb6eIafOFI6RlRSWUuXPK9+pwL6+Kt3qHF7FTHWsbQdAF/lkk+cJTZw0knT+c
        w5kwi/dZdjv5MoaG8AHR2dF0Dh2BCXSf8LE94GNaGZ6IOzKTvREtP7/1Z/A2AaGSdaC/Nh
        8QknPqmZOC8n8+7upbCMLzrvkIIiWX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f49FC2ZlOR4wrmdnNE/mZJvkEpcq4Lw9i+Zt1VAAqDI=;
        b=V+I3n9IqZFNPJ8kB/8myRleoNelQ/TV1D6n6KX7aJBtnfUmeRfaKsDTn+u0DAiHmBcn1Um
        SicTvjps2NYqwCBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 88347A3BB5;
        Tue, 21 Dec 2021 07:22:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 83DAF51923D8; Tue, 21 Dec 2021 08:22:42 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 51/68] pata_cs5536: convert printk() calls
Date:   Tue, 21 Dec 2021 08:21:14 +0100
Message-Id: <20211221072131.46673-52-hare@suse.de>
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

