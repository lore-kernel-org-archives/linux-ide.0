From: Ondrej Zary <linux@rainbow-software.org>
Subject: [RFC PATCH] sata_via: Enable hotplug on VT6420
Date: Fri, 31 Mar 2017 21:15:34 +0200
Message-ID: <201703312115.34955.linux@rainbow-software.org>
References: <1490985342-16800-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-1b.atlantis.sk ([80.94.52.26]:51626 "EHLO
        smtp-1b.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753351AbdCaTPo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2017 15:15:44 -0400
In-Reply-To: <1490985342-16800-1-git-send-email-linux@rainbow-software.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>

VT6420 seems to have the same hotplug capability as VT6421.

However, enabling hotplug needs to expose SCR registers which can cause
problems. It works for me but might break elsewhere.

---
 drivers/ata/sata_via.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index f3f538e..fafb0d3 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -132,6 +132,8 @@ struct svia_priv {
 
 static struct ata_port_operations vt6420_sata_ops = {
 	.inherits		= &svia_base_ops,
+	.scr_read		= svia_scr_read,
+	.scr_write		= svia_scr_write,
 	.freeze			= svia_noop_freeze,
 	.prereset		= vt6420_prereset,
 	.bmdma_start		= vt6420_bmdma_start,
@@ -556,7 +558,7 @@ static void svia_wd_fix(struct pci_dev *pdev)
 	pci_write_config_byte(pdev, 0x52, tmp8 | BIT(2));
 }
 
-static irqreturn_t vt6421_interrupt(int irq, void *dev_instance)
+static irqreturn_t vt642x_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
 	irqreturn_t rc = ata_bmdma_interrupt(irq, dev_instance);
@@ -644,7 +646,7 @@ static void svia_configure(struct pci_dev *pdev, int board_id,
 		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
 	}
 
-	if (board_id == vt6421) {
+	if (board_id == vt6420 || board_id == vt6421) {
 		/* enable IRQ on hotplug */
 		pci_read_config_byte(pdev, SVIA_MISC_3, &tmp8);
 		if ((tmp8 & SATA_HOTPLUG) != SATA_HOTPLUG) {
@@ -744,8 +746,8 @@ static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	svia_configure(pdev, board_id, hpriv);
 
 	pci_set_master(pdev);
-	if (board_id == vt6421)
-		return ata_host_activate(host, pdev->irq, vt6421_interrupt,
+	if (board_id == vt6420 || board_id == vt6421)
+		return ata_host_activate(host, pdev->irq, vt642x_interrupt,
 					 IRQF_SHARED, &svia_sht);
 	else
 		return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
-- 
Ondrej Zary
