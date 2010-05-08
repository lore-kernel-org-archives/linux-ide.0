From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] cmd640: fix kernel oops in test_irq() method
Date: Sat, 8 May 2010 22:07:14 +0400
Message-ID: <201005082207.14690.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:41668 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751352Ab0EHSIC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 May 2010 14:08:02 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org

When implementing the test_iqr() method, I forgot that this driver is not an
ordinary PCI driver and also needs to support VLB variant of the chip. Moreover,
'hwif->dev' should be NULL, potentially causing oops in pci_read_config_byte().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git tree...

 drivers/ide/cmd640.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: ide-2.6/drivers/ide/cmd640.c
===================================================================
--- ide-2.6.orig/drivers/ide/cmd640.c
+++ ide-2.6/drivers/ide/cmd640.c
@@ -633,12 +633,10 @@ static void __init cmd640_init_dev(ide_d
 
 static int cmd640_test_irq(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	int irq_reg		= hwif->channel ? ARTTIM23 : CFR;
-	u8  irq_stat, irq_mask	= hwif->channel ? ARTTIM23_IDE23INTR :
+	u8  irq_mask		= hwif->channel ? ARTTIM23_IDE23INTR :
 						  CFR_IDE01INTR;
-
-	pci_read_config_byte(dev, irq_reg, &irq_stat);
+	u8  irq_stat		= get_cmd640_reg(irq_reg);
 
 	return (irq_stat & irq_mask) ? 1 : 0;
 }
