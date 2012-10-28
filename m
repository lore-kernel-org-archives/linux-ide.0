From: Joe Perches <joe@perches.com>
Subject: [PATCH 02/16] ata: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
Date: Sun, 28 Oct 2012 01:05:40 -0700
Message-ID: <ff89ae9b42c644728575a3cf606184ab9875d6e9.1351411047.git.joe@perches.com>
References: <cover.1351411047.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1351411047.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

dev_<level> calls take less code than dev_printk(KERN_<LEVEL>
and reducing object size is good.
Coalesce formats for easier grep.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/ata/pata_cmd64x.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 7ba0141..2949cfc 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -474,14 +474,14 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* check for enabled ports */
 	pci_read_config_byte(pdev, CNTRL, &reg);
 	if (!port_ok)
-		dev_printk(KERN_NOTICE, &pdev->dev, "Mobility Bridge detected, ignoring CNTRL port enable/disable\n");
+		dev_notice(&pdev->dev, "Mobility Bridge detected, ignoring CNTRL port enable/disable\n");
 	if (port_ok && cntrl_ch0_ok && !(reg & CNTRL_CH0)) {
-		dev_printk(KERN_NOTICE, &pdev->dev, "Primary port is disabled\n");
+		dev_notice(&pdev->dev, "Primary port is disabled\n");
 		ppi[0] = &ata_dummy_port_info;
 
 	}
 	if (port_ok && !(reg & CNTRL_CH1)) {
-		dev_printk(KERN_NOTICE, &pdev->dev, "Secondary port is disabled\n");
+		dev_notice(&pdev->dev, "Secondary port is disabled\n");
 		ppi[1] = &ata_dummy_port_info;
 	}
 
-- 
1.7.8.112.g3fd21
