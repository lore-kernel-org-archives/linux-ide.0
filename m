From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 2/7] sata_mv: deal with interrupt coalescing interrupts
Date: Fri, 19 May 2006 16:24:56 -0400
Message-ID: <200605191624.56928.liml@rtr.ca>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:6798 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964821AbWESUY5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 16:24:57 -0400
In-Reply-To: <200605191614.00023.liml@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

In some systems, it is possible that the BIOS may have enabled interrupt coalescing
for the Marvell controllers which support it.  This patch adds code to detect/ack
interrupts from the chip's coalescing (combing) logic.

Signed-off-by: Mark Lord <liml@rtr.ca>

---

--- linux/drivers/scsi/sata_mv.c	2006-05-19 15:05:40.000000000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-05-19 15:17:19.000000000 -0400
@@ -50,6 +50,12 @@
 
 	MV_PCI_REG_BASE		= 0,
 	MV_IRQ_COAL_REG_BASE	= 0x18000,	/* 6xxx part only */
+	MV_IRQ_COAL_CAUSE		= (MV_IRQ_COAL_REG_BASE + 0x08),
+	MV_IRQ_COAL_CAUSE_LO		= (MV_IRQ_COAL_REG_BASE + 0x88),
+	MV_IRQ_COAL_CAUSE_HI		= (MV_IRQ_COAL_REG_BASE + 0x8c),
+	MV_IRQ_COAL_THRESHOLD		= (MV_IRQ_COAL_REG_BASE + 0xcc),
+	MV_IRQ_COAL_TIME_THRESHOLD	= (MV_IRQ_COAL_REG_BASE + 0xd0),
+
 	MV_SATAHC0_REG_BASE	= 0x20000,
 	MV_FLASH_CTL		= 0x1046c,
 	MV_GPIO_PORT_CTL	= 0x104f0,
@@ -1448,6 +1454,7 @@
 	struct ata_host_set *host_set = dev_instance;
 	unsigned int hc, handled = 0, n_hcs;
 	void __iomem *mmio = host_set->mmio_base;
+	struct mv_host_priv *hpriv;
 	u32 irq_stat;
 
 	irq_stat = readl(mmio + HC_MAIN_IRQ_CAUSE_OFS);
@@ -1469,6 +1476,17 @@
 			handled++;
 		}
 	}
+
+	hpriv = host_set->private_data;
+	if (IS_60XX(hpriv)) {
+		/* deal with the interrupt coalescing bits */
+		if (irq_stat & (TRAN_LO_DONE | TRAN_HI_DONE | PORTS_0_7_COAL_DONE)) {
+			writelfl(0, mmio + MV_IRQ_COAL_CAUSE_LO);
+			writelfl(0, mmio + MV_IRQ_COAL_CAUSE_HI);
+			writelfl(0, mmio + MV_IRQ_COAL_CAUSE);
+		}
+	}
+
 	if (PCI_ERR & irq_stat) {
 		printk(KERN_ERR DRV_NAME ": PCI ERROR; PCI IRQ cause=0x%08x\n",
 		       readl(mmio + PCI_IRQ_CAUSE_OFS));
