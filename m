From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/4] ide: tighten checks on PCI BARs in ide_hwif_configure()
Date: Fri, 6 Jun 2008 23:41:26 +0200
Message-ID: <200806062341.26708.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:31437 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326AbYFFVkt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jun 2008 17:40:49 -0400
Received: by gv-out-0910.google.com with SMTP id e6so432565gvc.37
        for <linux-ide@vger.kernel.org>; Fri, 06 Jun 2008 14:40:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Alan has fixed PCI layer handling of PCI IDE in Compatibility mode so
PCI BAR 0/1 (and/or 2/3) content reported by kernel should never be zero.

Tighten checks on PCI BARs and also fix printk() message while on it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -319,18 +319,18 @@ static ide_hwif_t *ide_hwif_configure(st
 
 		ctl  = pci_resource_start(dev, 2*port+1);
 		base = pci_resource_start(dev, 2*port);
-		if ((ctl && !base) || (base && !ctl)) {
-			printk(KERN_ERR "%s: inconsistent baseregs (BIOS) "
-				"for port %d, skipping\n", d->name, port);
-			return NULL;
-		}
-	}
-	if (!ctl) {
+	} else {
 		/* Use default values */
 		ctl = port ? 0x374 : 0x3f4;
 		base = port ? 0x170 : 0x1f0;
 	}
 
+	if (!base || !ctl) {
+		printk(KERN_ERR "%s: bad PCI BARs for port %d, skipping\n",
+				d->name, port);
+		return NULL;
+	}
+
 	hwif = ide_find_port_slot(d);
 	if (hwif == NULL) {
 		printk(KERN_ERR "%s: too many IDE interfaces, no room in "
