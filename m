From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/7] pata_ninja32: update ID table
Date: Fri, 05 Dec 2008 19:42:38 +0000
Message-ID: <20081205194231.17133.42760.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40152 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752320AbYLETm3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Dec 2008 14:42:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kai@kaishome.de, linux-ide@vger.kernel.org, jeff@garzik.org

From: Alan Cox <alan@redhat.com>

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/pata_ninja32.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)


diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 4e466ea..4dd9a3b 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -44,7 +44,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_ninja32"
-#define DRV_VERSION "0.1.1"
+#define DRV_VERSION "0.1.3"
 
 
 /**
@@ -130,7 +130,8 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		return rc;
 	pci_set_master(dev);
 
-	/* Set up the register mappings */
+	/* Set up the register mappings. We use the I/O mapping as only the
+	   older chips also have MMIO on BAR 1 */
 	base = host->iomap[0];
 	if (!base)
 		return -ENOMEM;
@@ -167,8 +168,12 @@ static int ninja32_reinit_one(struct pci_dev *pdev)
 #endif
 
 static const struct pci_device_id ninja32[] = {
+	{ 0x10FC, 0x0003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0x1145, 0x8008, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0x1145, 0xf008, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0x1145, 0xf024, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0x1145, 0xf02C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ },
 };
 

