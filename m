Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C49C433FE
	for <linux-ide@archiver.kernel.org>; Fri, 10 Dec 2021 07:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhLJHd2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 02:33:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35120 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbhLJHdH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 02:33:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1DA4E212BB;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639121359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/J8LYIDedkcJgvTFU5XYvz58fFXzv77lWAWvgHHtlto=;
        b=u071dkkb0LO1Xa54NT2hDiRZcBeaJBHJ4kPsa6NNnhs3mC4rioVKc8V2zbsFoaFl+3Hh6b
        O4CsdzYVeAvvuUlVGwFiPTwky6bUFZqIzAjea/ZFADEfKwCO/AoVf8uYJZHNs28N1lvoRU
        vW1n1LgvNKDYD0qz1SpUb2Nr6Ntnq6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639121359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/J8LYIDedkcJgvTFU5XYvz58fFXzv77lWAWvgHHtlto=;
        b=WofCLvGG20jk+5AXMrAF3aiOL79je1dP86jjkHwYgzHuvU+/sbxM5h8WWKXjHuUH7jLQIV
        8jOU0wE6kcJUY0Dw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 19B34A3BC4;
        Fri, 10 Dec 2021 07:29:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 17D3D519207F; Fri, 10 Dec 2021 08:29:19 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 47/68] pata_atp867x: convert printk() calls
Date:   Fri, 10 Dec 2021 08:28:44 +0100
Message-Id: <20211210072905.15666-48-hare@suse.de>
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
 drivers/ata/pata_atp867x.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index 2bc5fc81efe3..84dac8c69085 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -155,7 +155,7 @@ static int atp867x_get_active_clocks_shifted(struct ata_port *ap,
 	case 1 ... 6:
 		break;
 	default:
-		printk(KERN_WARNING "ATP867X: active %dclk is invalid. "
+		ata_port_warn(ap, "ATP867X: active %dclk is invalid. "
 			"Using 12clk.\n", clk);
 		fallthrough;
 	case 9 ... 12:
@@ -171,7 +171,8 @@ static int atp867x_get_active_clocks_shifted(struct ata_port *ap,
 	return clocks << ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
 }
 
-static int atp867x_get_recover_clocks_shifted(unsigned int clk)
+static int atp867x_get_recover_clocks_shifted(struct ata_port *ap,
+					      unsigned int clk)
 {
 	unsigned char clocks = clk;
 
@@ -188,7 +189,7 @@ static int atp867x_get_recover_clocks_shifted(unsigned int clk)
 	case 15:
 		break;
 	default:
-		printk(KERN_WARNING "ATP867X: recover %dclk is invalid. "
+		ata_port_warn(ap, "ATP867X: recover %dclk is invalid. "
 			"Using default 12clk.\n", clk);
 		fallthrough;
 	case 12:	/* default 12 clk */
@@ -225,7 +226,7 @@ static void atp867x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	iowrite8(b, dp->dma_mode);
 
 	b = atp867x_get_active_clocks_shifted(ap, t.active) |
-	    atp867x_get_recover_clocks_shifted(t.recover);
+		atp867x_get_recover_clocks_shifted(ap, t.recover);
 
 	if (adev->devno & 1)
 		iowrite8(b, dp->slave_piospd);
@@ -233,7 +234,7 @@ static void atp867x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 		iowrite8(b, dp->mstr_piospd);
 
 	b = atp867x_get_active_clocks_shifted(ap, t.act8b) |
-	    atp867x_get_recover_clocks_shifted(t.rec8b);
+		atp867x_get_recover_clocks_shifted(ap, t.rec8b);
 
 	iowrite8(b, dp->eightb_piospd);
 }
@@ -270,7 +271,6 @@ static struct ata_port_operations atp867x_ops = {
 };
 
 
-#ifdef	ATP867X_DEBUG
 static void atp867x_check_res(struct pci_dev *pdev)
 {
 	int i;
@@ -280,7 +280,7 @@ static void atp867x_check_res(struct pci_dev *pdev)
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		start = pci_resource_start(pdev, i);
 		len   = pci_resource_len(pdev, i);
-		printk(KERN_DEBUG "ATP867X: resource start:len=%lx:%lx\n",
+		dev_dbg(&pdev->dev, "ATP867X: resource start:len=%lx:%lx\n",
 			start, len);
 	}
 }
@@ -290,7 +290,7 @@ static void atp867x_check_ports(struct ata_port *ap, int port)
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	struct atp867x_priv *dp = ap->private_data;
 
-	printk(KERN_DEBUG "ATP867X: port[%d] addresses\n"
+	ata_port_dbg(ap, "ATP867X: port[%d] addresses\n"
 		"  cmd_addr	=0x%llx, 0x%llx\n"
 		"  ctl_addr	=0x%llx, 0x%llx\n"
 		"  bmdma_addr	=0x%llx, 0x%llx\n"
@@ -332,7 +332,6 @@ static void atp867x_check_ports(struct ata_port *ap, int port)
 		(unsigned long long)dp->eightb_piospd,
 		(unsigned long)dp->pci66mhz);
 }
-#endif
 
 static int atp867x_set_priv(struct ata_port *ap)
 {
@@ -370,8 +369,7 @@ static void atp867x_fixup(struct ata_host *host)
 	if (v < 0x80) {
 		v = 0x80;
 		pci_write_config_byte(pdev, PCI_LATENCY_TIMER, v);
-		printk(KERN_DEBUG "ATP867X: set latency timer of device %s"
-			" to %d\n", pci_name(pdev), v);
+		dev_dbg(&pdev->dev, "ATP867X: set latency timer to %d\n", v);
 	}
 
 	/*
@@ -419,13 +417,11 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
 		return rc;
 	host->iomap = pcim_iomap_table(pdev);
 
-#ifdef	ATP867X_DEBUG
 	atp867x_check_res(pdev);
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++)
-		printk(KERN_DEBUG "ATP867X: iomap[%d]=0x%llx\n", i,
+		dev_dbg(gdev, "ATP867X: iomap[%d]=0x%llx\n", i,
 			(unsigned long long)(host->iomap[i]));
-#endif
 
 	/*
 	 * request, iomap BARs and init port addresses accordingly
@@ -444,9 +440,8 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
 		if (rc)
 			return rc;
 
-#ifdef	ATP867X_DEBUG
 		atp867x_check_ports(ap, i);
-#endif
+
 		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
 			(unsigned long)ioaddr->cmd_addr,
 			(unsigned long)ioaddr->ctl_addr);
@@ -486,7 +481,7 @@ static int atp867x_init_one(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	printk(KERN_INFO "ATP867X: ATP867 ATA UDMA133 controller (rev %02X)",
+	dev_info(&pdev->dev, "ATP867X: ATP867 ATA UDMA133 controller (rev %02X)",
 		pdev->device);
 
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, ATP867X_NUM_PORTS);
-- 
2.29.2

