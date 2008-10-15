From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] sgiioc4: kill useless address checks
Date: Wed, 15 Oct 2008 23:29:19 +0400
Message-ID: <200810152329.20095.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:3427 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752256AbYJOT3g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 15:29:36 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

The driver performs a number of checks on the virtual/physical addresses which
would always evaluate as true:

- for sgiioc4_init_hwif_ports(), its caller, sgiioc4_ide_setup_pci_device(),
  guarantees that 'ctrl_port' and 'irq_port' parameters are never 0;

- in sgiioc4_read_status(), we always read the IDE status register, so there's
  no need to check the register's address (must be a leftover from the times
  when this function implemented the INB() method);

- in ide_dma_sgiioc4(), 'dma_base' can never be 0 as IOC4_DMA_OFFSET is not 0.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent pata-2.6 series...
Phew, it's been around since August -- sending out at last...

 drivers/ide/pci/sgiioc4.c |   28 ++++++++++------------------
 1 files changed, 10 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -101,11 +101,8 @@ sgiioc4_init_hwif_ports(hw_regs_t * hw, 
 	for (i = 0; i <= 7; i++)
 		hw->io_ports_array[i] = reg + i * 4;
 
-	if (ctrl_port)
-		hw->io_ports.ctl_addr = ctrl_port;
-
-	if (irq_port)
-		hw->io_ports.irq_addr = irq_port;
+	hw->io_ports.ctl_addr = ctrl_port;
+	hw->io_ports.irq_addr = irq_port;
 }
 
 static int
@@ -303,16 +300,14 @@ static u8 sgiioc4_read_status(ide_hwif_t
 	unsigned long port = hwif->io_ports.status_addr;
 	u8 reg = (u8) readb((void __iomem *) port);
 
-	if ((port & 0xFFF) == 0x11C) {	/* Status register of IOC4 */
-		if (!(reg & ATA_BUSY)) { /* Not busy... check for interrupt */
-			unsigned long other_ir = port - 0x110;
-			unsigned int intr_reg = (u32) readl((void __iomem *) other_ir);
-
-			/* Clear the Interrupt, Error bits on the IOC4 */
-			if (intr_reg & 0x03) {
-				writel(0x03, (void __iomem *) other_ir);
-				intr_reg = (u32) readl((void __iomem *) other_ir);
-			}
+	if (!(reg & ATA_BUSY)) {	/* Not busy... check for interrupt */
+		unsigned long other_ir = port - 0x110;
+		unsigned int intr_reg = (u32) readl((void __iomem *) other_ir);
+
+		/* Clear the Interrupt, Error bits on the IOC4 */
+		if (intr_reg & 0x03) {
+			writel(0x03, (void __iomem *) other_ir);
+			intr_reg = (u32) readl((void __iomem *) other_ir);
 		}
 	}
 
@@ -329,9 +324,6 @@ ide_dma_sgiioc4(ide_hwif_t *hwif, const 
 	int num_ports = sizeof (ioc4_dma_regs_t);
 	void *pad;
 
-	if (dma_base == 0)
-		return -1;
-
 	printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
 
 	if (request_mem_region(dma_base, num_ports, hwif->name) == NULL) {

