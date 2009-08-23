From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: [PATCH resend] ata: use printk_once
Date: Sun, 23 Aug 2009 20:23:34 +0200
Message-ID: <4A918926.8020801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933657AbZHWSXk@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 0c574c0..a5e4dfe 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -85,7 +85,6 @@ static int rz1000_fifo_disable(struct pci_dev *pdev)
 
 static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	static int printed_version;
 	static const struct ata_port_info info = {
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = ATA_PIO4,
@@ -93,8 +92,7 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
 
-	if (!printed_version++)
-		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+	printk_once(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
 
 	if (rz1000_fifo_disable(pdev) == 0)
 		return ata_pci_sff_init_one(pdev, ppi, &rz1000_sht, NULL);
