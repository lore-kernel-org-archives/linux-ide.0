From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 5/9] cmd640: implement test_irq() method
Date: Wed, 10 Jun 2009 22:58:23 +0400
Message-ID: <200906102258.23133.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37619 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756063AbZFJS4t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 14:56:49 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Implement test_irq() method, adding the drive 2/3 interrupt bit definition.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This is based on PCI0640B datasheet.
The patch is atop of ide-2.6.git 'for-next' branch.

 drivers/ide/cmd640.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

Index: ide-2.6/drivers/ide/cmd640.c
===================================================================
--- ide-2.6.orig/drivers/ide/cmd640.c
+++ ide-2.6/drivers/ide/cmd640.c
@@ -153,6 +153,7 @@ static int cmd640_vlb;
 #define ARTTIM23	0x57
 #define   ARTTIM23_DIS_RA2	0x04
 #define   ARTTIM23_DIS_RA3	0x08
+#define   ARTTIM23_IDE23INTR	0x10
 #define DRWTIM23	0x58
 #define BRST		0x59
 
@@ -629,12 +630,24 @@ static void cmd640_init_dev(ide_drive_t 
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 }
 
+static int cmd640_test_irq(ide_hwif_t *hwif)
+{
+	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	int irq_reg		= hwif->channel ? ARTTIM23 : CFR;
+	u8  irq_stat, irq_mask	= hwif->channel ? ARTTIM23_IDE23INTR :
+						  CFR_IDE01INTR;
+
+	pci_read_config_byte(dev, irq_reg, &irq_stat);
+
+	return (irq_stat & irq_mask) ? 1 : 0;
+}
 
 static const struct ide_port_ops cmd640_port_ops = {
 	.init_dev		= cmd640_init_dev,
 #ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
 	.set_pio_mode		= cmd640_set_pio_mode,
 #endif
+	.test_irq		= cmd640_test_irq,
 };
 
 static int pci_conf1(void)

