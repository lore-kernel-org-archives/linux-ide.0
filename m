From: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH 1/2] pata_cs5535: add pci id for AMD based CS5535 controllers
Date: Fri,  3 Jul 2009 11:22:42 -0300
Message-ID: <1246630963-5831-1-git-send-email-otavio@ossystems.com.br>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:54870 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbZGCOWV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Jul 2009 10:22:21 -0400
Received: by rv-out-0506.google.com with SMTP id k40so172639rvb.5
        for <linux-ide@vger.kernel.org>; Fri, 03 Jul 2009 07:22:24 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Otavio Salvador <otavio@ossystems.com.br>


Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
 drivers/ata/pata_cs5535.c |    3 ++-
 include/linux/pci_ids.h   |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index d33aa28..403f561 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -202,7 +202,8 @@ static int cs5535_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 }
 
 static const struct pci_device_id cs5535[] = {
-	{ PCI_VDEVICE(NS, 0x002D), },
+	{ PCI_VDEVICE(NS, PCI_DEVICE_ID_NS_CS5535_IDE), },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CS5535_IDE), },
 
 	{ },
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 73b46b6..b100b4c 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -537,6 +537,7 @@
 #define PCI_DEVICE_ID_AMD_8131_BRIDGE	0x7450
 #define PCI_DEVICE_ID_AMD_8131_APIC	0x7451
 #define PCI_DEVICE_ID_AMD_8132_BRIDGE	0x7458
+#define PCI_DEVICE_ID_AMD_CS5535_IDE    0x208F
 #define PCI_DEVICE_ID_AMD_CS5536_ISA    0x2090
 #define PCI_DEVICE_ID_AMD_CS5536_FLASH  0x2091
 #define PCI_DEVICE_ID_AMD_CS5536_AUDIO  0x2093
-- 
1.6.3.3.385.g60647

