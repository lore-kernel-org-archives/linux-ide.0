From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream] pata_jmicron: match vendor and class code only
Date: Sun, 7 Oct 2007 07:04:50 +0900
Message-ID: <20071006220450.GD12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:64680 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764420AbXJFWE5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Oct 2007 18:04:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1098103wah
        for <linux-ide@vger.kernel.org>; Sat, 06 Oct 2007 15:04:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, ethanhsiao@jmicron.com, justin@jmicron.com

PATA part of all current JMB controllers behave the same way and
JMicron confirms that all future ones will stay compatible.  Drop
device matching and match only vendor and class.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Ethan Hsiao <ethanhsiao@jmicron.com>
Cc: Justin Tsai <justin@jmicron.com>
---
 drivers/ata/pata_jmicron.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 6d5a818..225a722 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -204,17 +204,8 @@ static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 }
 
 static const struct pci_device_id jmicron_pci_tbl[] = {
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 361 },
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 363 },
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 365 },
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 366 },
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 368 },
-
+	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 0 },
 	{ }	/* terminate list */
 };
 
