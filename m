From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ata: pata_oldpiix: Add missing device ID for INTEL_82371AB
Date: Mon, 10 Dec 2018 13:46:04 +0000
Message-ID: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, b.zolnierkie@samsung.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

When playing with a virtual SPARC machine with qemu, I found that the
IDE emulated device was not probing with the ata/pata_oldpiix driver.
But with the old ide/piix, it was probed.

This is due to this PCI devid was not migrated from the old ide/piix.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/pata_oldpiix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index b9bf78b7d48d..63a964062865 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -249,6 +249,7 @@ static int oldpiix_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 
 static const struct pci_device_id oldpiix_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x1230), },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_82371AB), },
 
 	{ }	/* terminate list */
 };
-- 
2.19.2
