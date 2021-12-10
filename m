Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEF0C43217
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbhLJHdd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:33 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35098 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbhLJHdP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3A6F2212C4;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qlf+b9FHXif+j+YiCmdQefsapESgx+M4hDwu/PD7IA=;
        b=Cu2XSPe+1hqkT2hya9ibmGY0PnMzxNvraLcdqIECehKd/T6aQmFmu25I9YbTL5dR/kCVcI
        WAjtBy2Iy1BtttSJKw5T5CigDMrphvKa1NC8ZGq0BYrZywHMrDCfQr81zHHyQPTzLhBk9S
        gGHNwrD3X/I/hygdAA1794aF5MMsJ9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qlf+b9FHXif+j+YiCmdQefsapESgx+M4hDwu/PD7IA=;
        b=lcoRCLT+HQ82+AnmpRdLcdRLb9rJYowvnpnz4qCXzErNdA2DKCj7G/Qoe0+Vpu0WgSiSfI
        pwgo0QgWI+YWvfDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 36C4AA3BCB;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 3435C519208F; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 55/68] pata_rz1000: convert printk() calls
Date:   Fri, 10 Dec 2021 08:28:52 +0100
Message-Id: <20211210072905.15666-56-hare@suse.de>
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
 drivers/ata/pata_rz1000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 3722a67083fd..fb00c3e5fd19 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -69,7 +69,7 @@ static int rz1000_fifo_disable(struct pci_dev *pdev)
 	reg &= 0xDFFF;
 	if (pci_write_config_word(pdev, 0x40, reg) != 0)
 		return -1;
-	printk(KERN_INFO DRV_NAME ": disabled chipset readahead.\n");
+	dev_info(&pdev->dev, "disabled chipset readahead.\n");
 	return 0;
 }
 
@@ -97,7 +97,7 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 	if (rz1000_fifo_disable(pdev) == 0)
 		return ata_pci_sff_init_one(pdev, ppi, &rz1000_sht, NULL, 0);
 
-	printk(KERN_ERR DRV_NAME ": failed to disable read-ahead on chipset..\n");
+	dev_err(&pdev->dev, "failed to disable read-ahead on chipset.\n");
 	/* Not safe to use so skip */
 	return -ENODEV;
 }
-- 
2.29.2

