From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH] pata_artop: Use ioread8.
Date: Thu, 14 Apr 2016 16:26:03 +0900
Message-ID: <1460618763-1712-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Support for non x86 targets.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/ata/pata_artop.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 96c05c9..3731dea 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -340,6 +340,18 @@ static void atp8xx_fixup(struct pci_dev *pdev)
 	}
 }
 
+static int is_fast(struct pci_dev *pdev)
+{
+	int ret = 0;
+	void __iomem *addr;
+
+	addr = pci_iomap(pdev, 4, 1);
+	if (ioread8(addr) & 0x10)
+		ret = 1;
+	pci_iounmap(pdev, addr);
+
+	return ret;
+}
 /**
  *	artop_init_one - Register ARTOP ATA PCI device with kernel services
  *	@pdev: PCI device to register
@@ -398,10 +410,8 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 	else if (id->driver_data == 1)	/* 6260 */
 		ppi[0] = &info_626x;
 	else if (id->driver_data == 2)	{ /* 6280 or 6280 + fast */
-		unsigned long io = pci_resource_start(pdev, 4);
-
 		ppi[0] = &info_628x;
-		if (inb(io) & 0x10)
+		if (is_fast(pdev))
 			ppi[0] = &info_628x_fast;
 	}
 
-- 
2.7.0
