From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH] ata: read ->revision before dropping pci_device reference
Date: Wed, 28 Nov 2018 09:40:43 +0800
Message-ID: <1543369243-64252-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: linux-ide@vger.kernel.org

pci_device->revision is read after dropping pci_device reference via
pci_dev_put, which may result in use-after-free bugs. To fix this, the
patch reads ->revision before dropping reference.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/ata/pata_sis.c      | 4 +++-
 drivers/ata/pata_sl82c105.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 626f989..01635bc 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -833,6 +833,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		u16 trueid;
 		u8 prefctl;
 		u8 idecfg;
+		u8 sbrev;
 
 		/* Try the second unmasking technique */
 		pci_read_config_byte(pdev, 0x4a, &idecfg);
@@ -846,9 +847,10 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 			if (lpc_bridge == NULL)
 				break;
 			pci_read_config_byte(pdev, 0x49, &prefctl);
+			sbrev = lpc_bridge->revision;
 			pci_dev_put(lpc_bridge);
 
-			if (lpc_bridge->revision == 0x10 && (prefctl & 0x80)) {
+			if (sbrev == 0x10 && (prefctl & 0x80)) {
 				chipset = &sis133_early;
 				break;
 			}
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 4935f61f..476438e 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -264,6 +264,7 @@ static struct ata_port_operations sl82c105_port_ops = {
 static int sl82c105_bridge_revision(struct pci_dev *pdev)
 {
 	struct pci_dev *bridge;
+	u8 rev;
 
 	/*
 	 * The bridge should be part of the same device, but function 0.
@@ -285,8 +286,9 @@ static int sl82c105_bridge_revision(struct pci_dev *pdev)
 	/*
 	 * We need to find function 0's revision, not function 1
 	 */
+	rev = bridge->revision;
 	pci_dev_put(bridge);
-	return bridge->revision;
+	return rev;
 }
 
 static void sl82c105_fixup(struct pci_dev *pdev)
-- 
2.7.4
