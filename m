From: Andrey Korolyov <andrey@xdel.ru>
Subject: [PATCH] cs5536: add support for IDE controller variant
Date: Wed,  9 Aug 2017 21:19:26 +0300
Message-ID: <20170809181926.20015-1-andrey@xdel.ru>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.flops.ru ([91.239.27.205]:49522 "EHLO mail.adserve.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752947AbdHISZB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 9 Aug 2017 14:25:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: andrey@xdel.ru

Several legacy devices such as Geode-based Cisco ASA appliances
and DB800 development board do possess CS5536 IDE controller
with different PCI id than existing one. Using pata_generic is
not always feasible as at least DB800 requires MSR quirk from
pata_cs5536 to be used with vendor firmware.

Signed-off-by: Andrey Korolyov <andrey@xdel.ru>
CC: stable@vger.kernel.org
---
 drivers/ata/pata_amd.c    | 1 +
 drivers/ata/pata_cs5536.c | 1 +
 drivers/ide/cs5536.c      | 1 +
 include/linux/pci_ids.h   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 8d4d959..8706533 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -616,6 +616,7 @@ static const struct pci_device_id amd[] = {
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE),	8 },
 	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE),	8 },
 	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		9 },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_DEV_IDE),	9 },
 
 	{ },
 };
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 6c15a55..dc12552 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -289,6 +289,7 @@ static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 static const struct pci_device_id cs5536[] = {
 	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE), },
+	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_DEV_IDE), },
 	{ },
 };
 
diff --git a/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
index de9185d..01c250f 100644
--- a/drivers/ide/cs5536.c
+++ b/drivers/ide/cs5536.c
@@ -283,6 +283,7 @@ static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 
 static const struct pci_device_id cs5536_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CS5536_IDE), },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CS5536_DEV_IDE), },
 	{ },
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c71e532..4adf616 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -576,6 +576,7 @@
 #define PCI_DEVICE_ID_AMD_CS5536_EHC    0x2095
 #define PCI_DEVICE_ID_AMD_CS5536_UDC    0x2096
 #define PCI_DEVICE_ID_AMD_CS5536_UOC    0x2097
+#define PCI_DEVICE_ID_AMD_CS5536_DEV_IDE    0x2092
 #define PCI_DEVICE_ID_AMD_CS5536_IDE    0x209A
 #define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
 #define PCI_DEVICE_ID_AMD_LX_AES    0x2082
-- 
2.10.2

