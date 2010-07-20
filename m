From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ata_piix: fix locking around SIDPR access
Date: Tue, 20 Jul 2010 16:20:01 +0200
Message-ID: <4C45B091.2000002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34294 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758050Ab0GTOUL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jul 2010 10:20:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik lin <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>
Cc: Mark Knecht <markknecht@gmail.com>, Paul Check <paul@thechecks.ca>

SIDPR window registers are shared across ports and as each access is
done in two steps, accesses to different ports under EH may race.
This primarily is caused by incorrect host locking in EH context and
should be fixed by defining locking requirements for each EH operation
which can be used during EH and enforcing them but for now work around
the problem by adding a dedicated SIDPR lock and grabbing it for each
SIDPR access.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Mark Knecht <markknecht@gmail.com>
Reported-by: Paul Check <paul@thechecks.ca>
Cc: stable@kernel.org
---
 drivers/ata/ata_piix.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 7409f98..3971bc0 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -158,6 +158,7 @@ struct piix_map_db {
 struct piix_host_priv {
 	const int *map;
 	u32 saved_iocfg;
+	spinlock_t sidpr_lock;	/* FIXME: remove once locking in EH is fixed */
 	void __iomem *sidpr;
 };

@@ -951,12 +952,15 @@ static int piix_sidpr_scr_read(struct ata_link *link,
 			       unsigned int reg, u32 *val)
 {
 	struct piix_host_priv *hpriv = link->ap->host->private_data;
+	unsigned long flags;

 	if (reg >= ARRAY_SIZE(piix_sidx_map))
 		return -EINVAL;

+	spin_lock_irqsave(&hpriv->sidpr_lock, flags);
 	piix_sidpr_sel(link, reg);
 	*val = ioread32(hpriv->sidpr + PIIX_SIDPR_DATA);
+	spin_unlock_irqrestore(&hpriv->sidpr_lock, flags);
 	return 0;
 }

@@ -964,12 +968,15 @@ static int piix_sidpr_scr_write(struct ata_link *link,
 				unsigned int reg, u32 val)
 {
 	struct piix_host_priv *hpriv = link->ap->host->private_data;
+	unsigned long flags;

 	if (reg >= ARRAY_SIZE(piix_sidx_map))
 		return -EINVAL;

+	spin_lock_irqsave(&hpriv->sidpr_lock, flags);
 	piix_sidpr_sel(link, reg);
 	iowrite32(val, hpriv->sidpr + PIIX_SIDPR_DATA);
+	spin_unlock_irqrestore(&hpriv->sidpr_lock, flags);
 	return 0;
 }

@@ -1566,6 +1573,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
+	spin_lock_init(&hpriv->sidpr_lock);

 	/* Save IOCFG, this will be used for cable detection, quirk
 	 * detection and restoration on detach.  This is necessary
