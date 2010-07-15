From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Thu, 15 Jul 2010 11:29:06 +0200
Message-ID: <4C3ED4E2.9080806@kernel.org>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>    <4B5D26EF.4030709@kernel.org> <loom.20100205T041929-66@post.gmane.org>    <12193ff15b0deef3609ea93f54e5b485.squirrel@thechecks.ca>    <13096cdf5e0e6704e30364a746e60467.squirrel@thechecks.ca>    <8276efbfebcbfc3e58033ab8d5996d9d.squirrel@thechecks.ca>    <4C3DACFF.2060504@kernel.org>    <0d9ccbbb9ed0fb46dc9497888cd92c6e.squirrel@thechecks.ca>    <4C3E4A04.5030000@kernel.org> <6cb5020f769580a1f431ed5bb8709b6a.squirrel@thechecks.ca> <4C3ED2C3.9050907@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000304000304010406070508"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54341 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874Ab0GOJ3K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jul 2010 05:29:10 -0400
In-Reply-To: <4C3ED2C3.9050907@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Check <paul@thechecks.ca>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------000304000304010406070508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07/15/2010 11:20 AM, Tejun Heo wrote:
> Hmm... it looks like SStatus and SControl are swapped here.  Maybe
> there's a race condition in SIDPR code.  I'll look into it a bit more.

So, something like this.  Can you please apply the patch and see
whether the problem goes away?

Thanks.

-- 
tejun

--------------000304000304010406070508
Content-Type: text/x-patch;
 name="ata_piix-sidpr-lock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ata_piix-sidpr-lock.patch"

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

--------------000304000304010406070508--
