From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/8] ide: fix ide_scan_pcibus() error message
Date: Thu, 29 Nov 2007 01:06:23 +0100
Message-ID: <200711290106.23295.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:43911 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757999AbXK2ACu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 19:02:50 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1659770ugc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 16:02:48 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -792,9 +792,10 @@ int __init ide_scan_pcibus(void)
 	list_for_each_safe(l, n, &ide_pci_drivers) {
 		list_del(l);
 		d = list_entry(l, struct pci_driver, node);
-		if (__pci_register_driver(d, d->driver.owner, d->driver.mod_name))
-			printk(KERN_ERR "%s: failed to register driver for %s\n",
-			       __FUNCTION__, d->driver.mod_name);
+		if (__pci_register_driver(d, d->driver.owner,
+					  d->driver.mod_name))
+			printk(KERN_ERR "%s: failed to register %s driver\n",
+					__FUNCTION__, d->driver.mod_name);
 	}
 
 	return 0;
