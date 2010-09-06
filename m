From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 3/3] ata_piix: remove SIDPR locking
Date: Mon, 06 Sep 2010 17:57:40 +0200
Message-ID: <4C850F74.3020908@gmail.com>
References: <4C850F2D.4030601@kernel.org> <4C850F5A.7030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43244 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942Ab0IFP5n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Sep 2010 11:57:43 -0400
Received: by mail-fx0-f46.google.com with SMTP id 13so2522611fxm.19
        for <linux-ide@vger.kernel.org>; Mon, 06 Sep 2010 08:57:43 -0700 (PDT)
In-Reply-To: <4C850F5A.7030602@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, yuanding02@gmail.com

Now that libata provides proper cross-port EH exclusion.  The SIDPR
locking added by commit 213373cf (ata_piix: fix locking around SIDPR
access) is no longer necessary.  Remove it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ata_piix.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 3971bc0..7409f98 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -158,7 +158,6 @@ struct piix_map_db {
 struct piix_host_priv {
 	const int *map;
 	u32 saved_iocfg;
-	spinlock_t sidpr_lock;	/* FIXME: remove once locking in EH is fixed */
 	void __iomem *sidpr;
 };

@@ -952,15 +951,12 @@ static int piix_sidpr_scr_read(struct ata_link *link,
 			       unsigned int reg, u32 *val)
 {
 	struct piix_host_priv *hpriv = link->ap->host->private_data;
-	unsigned long flags;

 	if (reg >= ARRAY_SIZE(piix_sidx_map))
 		return -EINVAL;

-	spin_lock_irqsave(&hpriv->sidpr_lock, flags);
 	piix_sidpr_sel(link, reg);
 	*val = ioread32(hpriv->sidpr + PIIX_SIDPR_DATA);
-	spin_unlock_irqrestore(&hpriv->sidpr_lock, flags);
 	return 0;
 }

@@ -968,15 +964,12 @@ static int piix_sidpr_scr_write(struct ata_link *link,
 				unsigned int reg, u32 val)
 {
 	struct piix_host_priv *hpriv = link->ap->host->private_data;
-	unsigned long flags;

 	if (reg >= ARRAY_SIZE(piix_sidx_map))
 		return -EINVAL;

-	spin_lock_irqsave(&hpriv->sidpr_lock, flags);
 	piix_sidpr_sel(link, reg);
 	iowrite32(val, hpriv->sidpr + PIIX_SIDPR_DATA);
-	spin_unlock_irqrestore(&hpriv->sidpr_lock, flags);
 	return 0;
 }

@@ -1573,7 +1566,6 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
-	spin_lock_init(&hpriv->sidpr_lock);

 	/* Save IOCFG, this will be used for cable detection, quirk
 	 * detection and restoration on detach.  This is necessary
-- 
1.7.1

