From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/11] ppc/pmac: remove no longer needed IDE quirk
Date: Thu, 14 Feb 2008 01:37:43 +0100
Message-ID: <20080214003743.12879.33797.sendpatchset@localhost.localdomain>
References: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:27663 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934525AbYBNAXY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 19:23:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so897247ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 16:23:22 -0800 (PST)
In-Reply-To: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org

IDE PMAC host driver and all IDE PCI host drivers use pci_enable_device()
nowadays so the following quirk in pmac_pcibios_after_init() can be removed.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 arch/powerpc/platforms/powermac/pci.c |   22 ----------------------
 1 file changed, 22 deletions(-)

Index: b/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -1144,28 +1144,6 @@ void __init pmac_pcibios_after_init(void
 {
 	struct device_node* nd;
 
-#ifdef CONFIG_BLK_DEV_IDE
-	struct pci_dev *dev = NULL;
-
-	/* OF fails to initialize IDE controllers on macs
-	 * (and maybe other machines)
-	 *
-	 * Ideally, this should be moved to the IDE layer, but we need
-	 * to check specifically with Andre Hedrick how to do it cleanly
-	 * since the common IDE code seem to care about the fact that the
-	 * BIOS may have disabled a controller.
-	 *
-	 * -- BenH
-	 */
-	for_each_pci_dev(dev) {
-		if ((dev->class >> 16) != PCI_BASE_CLASS_STORAGE)
-			continue;
-		if (pci_enable_device(dev))
-			printk(KERN_WARNING
-			       "pci: Failed to enable %s\n", pci_name(dev));
-	}
-#endif /* CONFIG_BLK_DEV_IDE */
-
 	for_each_node_by_name(nd, "firewire") {
 		if (nd->parent && (of_device_is_compatible(nd, "pci106b,18") ||
 				   of_device_is_compatible(nd, "pci106b,30") ||
