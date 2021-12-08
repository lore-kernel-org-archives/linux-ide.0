Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9DEC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  8 Dec 2021 16:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhLHQgu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Dec 2021 11:36:50 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37724 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbhLHQgh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Dec 2021 11:36:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 919381FE17;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638981180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avHZ2T3WtPXVtL0Evjazu33BoW7vuaczHJtBbNHwQhM=;
        b=gcQs5INbnDfNKtrHei1uNZtLaH93udH/S3WHVtzh2jy+8k4hJA2pcYe4GvHZIneV3Hqz00
        Frh6SNuzOewADNUbq1DBkiVaAiiMXYCmNvhszvh0bSNi/bW8/rKq95/fd8nCZiA3IwlQ91
        eIj01LuYNKyMvN+btJ0i8wn4yxtdirk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638981180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=avHZ2T3WtPXVtL0Evjazu33BoW7vuaczHJtBbNHwQhM=;
        b=e/zdadnVMHK82Db7PmrmnVFkRbt/YB+ghKf0+I+g1EBI7uQIiNe3RjC/5G8vSCl7Q3jlgR
        D5dSbhR2t+gAS3Ag==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 8EE15A3BB2;
        Wed,  8 Dec 2021 16:33:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 8B68D5191F9B; Wed,  8 Dec 2021 17:33:00 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 31/73] ahci: Drop pointless VPRINTK() calls and convert the remaining ones
Date:   Wed,  8 Dec 2021 17:32:13 +0100
Message-Id: <20211208163255.114660-32-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211208163255.114660-1-hare@suse.de>
References: <20211208163255.114660-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drop pointless VPRINTK() calls for entering and existing interrupt
routines and convert the remaining calls to dev_dbg().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/ahci.c       |  4 +---
 drivers/ata/ahci_xgene.c |  4 ----
 drivers/ata/libahci.c    | 18 ++++--------------
 3 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6a867ef64c9c..e9fd09152a6b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -683,7 +683,7 @@ static void ahci_pci_init_controller(struct ata_host *host)
 
 		/* clear port IRQ */
 		tmp = readl(port_mmio + PORT_IRQ_STAT);
-		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
+		dev_dbg(&pdev->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
 		if (tmp)
 			writel(tmp, port_mmio + PORT_IRQ_STAT);
 	}
@@ -1468,7 +1468,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 	u32 irq_stat, irq_masked;
 	unsigned int handled = 1;
 
-	VPRINTK("ENTER\n");
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 	irq_stat = readl(mmio + HOST_IRQ_STAT);
@@ -1485,7 +1484,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 		irq_stat = readl(mmio + HOST_IRQ_STAT);
 		spin_unlock(&host->lock);
 	} while (irq_stat);
-	VPRINTK("EXIT\n");
 
 	return IRQ_RETVAL(handled);
 }
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index dffc432b9d54..4d8a186ec12a 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -588,8 +588,6 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -612,8 +610,6 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ee7e63da0437..4deb5e9295c0 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1234,12 +1234,12 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 
 	/* clear SError */
 	tmp = readl(port_mmio + PORT_SCR_ERR);
-	VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
+	dev_dbg(dev, "PORT_SCR_ERR 0x%x\n", tmp);
 	writel(tmp, port_mmio + PORT_SCR_ERR);
 
 	/* clear port IRQ */
 	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
+	dev_dbg(dev, "PORT_IRQ_STAT 0x%x\n", tmp);
 	if (tmp)
 		writel(tmp, port_mmio + PORT_IRQ_STAT);
 
@@ -1270,10 +1270,10 @@ void ahci_init_controller(struct ata_host *host)
 	}
 
 	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	dev_dbg(host->dev, "HOST_CTL 0x%x\n", tmp);
 	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
 	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	dev_dbg(host->dev, "HOST_CTL 0x%x\n", tmp);
 }
 EXPORT_SYMBOL_GPL(ahci_init_controller);
 
@@ -1911,8 +1911,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 status;
 
-	VPRINTK("ENTER\n");
-
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
@@ -1920,8 +1918,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	ahci_handle_port_interrupt(ap, port_mmio, status);
 	spin_unlock(ap->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_HANDLED;
 }
 
@@ -1938,9 +1934,7 @@ u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 		ap = host->ports[i];
 		if (ap) {
 			ahci_port_intr(ap);
-			VPRINTK("port %u\n", i);
 		} else {
-			VPRINTK("port %u (no irq)\n", i);
 			if (ata_ratelimit())
 				dev_warn(host->dev,
 					 "interrupt on disabled port %u\n", i);
@@ -1961,8 +1955,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -1990,8 +1982,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
-- 
2.29.2

