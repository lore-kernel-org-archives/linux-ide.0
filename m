From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] pata_artop: use defines from pci.h
Date: Sat, 28 Apr 2012 17:57:09 -0400
Message-ID: <1335650229-5930-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:37005 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512Ab2D1VzG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2012 17:55:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/ata/pata_artop.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 4b8b22e..553a3b3 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -414,11 +414,11 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 static const struct pci_device_id artop_pci_tbl[] = {
-	{ PCI_VDEVICE(ARTOP, 0x0005), 0 },
-	{ PCI_VDEVICE(ARTOP, 0x0006), 1 },
-	{ PCI_VDEVICE(ARTOP, 0x0007), 1 },
-	{ PCI_VDEVICE(ARTOP, 0x0008), 2 },
-	{ PCI_VDEVICE(ARTOP, 0x0009), 2 },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF), 0 },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP860),   1 },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP860R),  1 },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP865),   2 },
+	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP865R),  2 },
 
 	{ }	/* terminate list */
 };
-- 
1.7.9.7

