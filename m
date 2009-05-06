From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/4] ata_piix: Turn on hotplugging support for older chips
Date: Wed, 06 May 2009 17:10:08 +0100
Message-ID: <20090506160947.24191.32143.stgit@t61.ukuu.org.uk>
References: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58422 "EHLO
	t61.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759518AbZEFPLs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 May 2009 11:11:48 -0400
In-Reply-To: <20090506160612.24191.90737.stgit@t61.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

From: Alan Cox <alan@linux.intel.com>

We can't do this for the later ones as they have all sorts of magic boot
time stuff that needs reviewing and the like. However we can do it for the
older ones and it turns out we need to as some IBM docking stations have a
second PIIX series device in them and without this change you can't use it
very well

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/ata_piix.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index d51a17c..3434468 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1500,8 +1500,8 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	/* no hotplugging support (FIXME) */
-	if (!in_module_init)
+	/* no hotplugging support for later devices (FIXME) */
+	if (!in_module_init && ent->driver_data >= ich5_sata)
 		return -ENODEV;
 
 	if (piix_broken_system_poweroff(pdev)) {

