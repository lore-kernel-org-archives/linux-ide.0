From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/9] ide: move ack_intr() method into 'struct ide_port_ops'
Date: Wed, 10 Jun 2009 22:51:16 +0400
Message-ID: <200906102251.16359.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37429 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757285AbZFJStl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 14:49:41 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Move the ack_intr() method into 'struct ide_port_ops', also renaming it to
test_irq() while at it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git 'for-next' branch.

 drivers/ide/buddha.c |   27 ++++++++++++++++-----------
 drivers/ide/gayle.c  |   14 +++++++++-----
 drivers/ide/ide-io.c |    3 ++-
 drivers/ide/macide.c |   12 ++++--------
 include/linux/ide.h  |   10 +---------
 5 files changed, 32 insertions(+), 34 deletions(-)

Index: ide-2.6/drivers/ide/buddha.c
===================================================================
--- ide-2.6.orig/drivers/ide/buddha.c
+++ ide-2.6/drivers/ide/buddha.c
@@ -99,7 +99,7 @@ static const char *buddha_board_name[] =
      *  Check and acknowledge the interrupt status
      */
 
-static int buddha_ack_intr(ide_hwif_t *hwif)
+static int buddha_test_irq(ide_hwif_t *hwif)
 {
     unsigned char ch;
 
@@ -109,7 +109,7 @@ static int buddha_ack_intr(ide_hwif_t *h
     return 1;
 }
 
-static int xsurf_ack_intr(ide_hwif_t *hwif)
+static int xsurf_test_irq(ide_hwif_t *hwif)
 {
     unsigned char ch;
 
@@ -122,8 +122,7 @@ static int xsurf_ack_intr(ide_hwif_t *hw
 }
 
 static void __init buddha_setup_ports(struct ide_hw *hw, unsigned long base,
-				      unsigned long ctl, unsigned long irq_port,
-				      ide_ack_intr_t *ack_intr)
+				      unsigned long ctl, unsigned long irq_port)
 {
 	int i;
 
@@ -138,9 +137,16 @@ static void __init buddha_setup_ports(st
 	hw->io_ports.irq_addr = irq_port;
 
 	hw->irq = IRQ_AMIGA_PORTS;
-	hw->ack_intr = ack_intr;
 }
 
+static const struct ide_port_ops buddha_port_ops = {
+	.test_irq		= buddha_test_irq,
+};
+
+static const struct ide_port_ops xsurf_port_ops = {
+	.test_irq		= xsurf_test_irq,
+};
+
 static const struct ide_port_info buddha_port_info = {
 	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
 	.irq_flags		= IRQF_SHARED,
@@ -157,6 +163,7 @@ static int __init buddha_init(void)
 	u_long buddha_board = 0;
 	BuddhaType type;
 	int buddha_num_hwifs, i;
+	struct ide_port_info d = buddha_port_info;
 
 	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
 		unsigned long board;
@@ -203,28 +210,26 @@ fail_base2:
 
 		for (i = 0; i < buddha_num_hwifs; i++) {
 			unsigned long base, ctl, irq_port;
-			ide_ack_intr_t *ack_intr;
 
 			if (type != BOARD_XSURF) {
 				base = buddha_board + buddha_bases[i];
 				ctl = base + BUDDHA_CONTROL;
 				irq_port = buddha_board + buddha_irqports[i];
-				ack_intr = buddha_ack_intr;
+				d.port_ops = buddha_port_ops;
 			} else {
 				base = buddha_board + xsurf_bases[i];
 				/* X-Surf has no CS1* (Control/AltStat) */
 				ctl = 0;
 				irq_port = buddha_board + xsurf_irqports[i];
-				ack_intr = xsurf_ack_intr;
+				d.port_ops = xsurf_port_ops;
 			}
 
-			buddha_setup_ports(&hw[i], base, ctl, irq_port,
-					   ack_intr);
+			buddha_setup_ports(&hw[i], base, ctl, irq_port);
 
 			hws[i] = &hw[i];
 		}
 
-		ide_host_add(&buddha_port_info, hws, i, NULL);
+		ide_host_add(&d, hws, i, NULL);
 	}
 
 	return 0;
Index: ide-2.6/drivers/ide/gayle.c
===================================================================
--- ide-2.6.orig/drivers/ide/gayle.c
+++ ide-2.6/drivers/ide/gayle.c
@@ -66,7 +66,7 @@ MODULE_PARM_DESC(doubler, "enable suppor
      *  Check and acknowledge the interrupt status
      */
 
-static int gayle_ack_intr(ide_hwif_t *hwif)
+static int gayle_test_irq(ide_hwif_t *hwif)
 {
     unsigned char ch;
 
@@ -85,8 +85,7 @@ static void gayle_a1200_clear_irq(ide_dr
 }
 
 static void __init gayle_setup_ports(struct ide_hw *hw, unsigned long base,
-				     unsigned long ctl, unsigned long irq_port,
-				     ide_ack_intr_t *ack_intr)
+				     unsigned long ctl, unsigned long irq_port)
 {
 	int i;
 
@@ -101,11 +100,15 @@ static void __init gayle_setup_ports(str
 	hw->io_ports.irq_addr = irq_port;
 
 	hw->irq = IRQ_AMIGA_PORTS;
-	hw->ack_intr = ack_intr;
 }
 
+static const struct ide_port_ops gayle_a4000_port_ops = {
+	.test_irq		= gayle_test_irq,
+};
+
 static const struct ide_port_ops gayle_a1200_port_ops = {
 	.clear_irq		= gayle_a1200_clear_irq,
+	.test_irq		= gayle_test_irq,
 };
 
 static const struct ide_port_info gayle_port_info = {
@@ -148,6 +151,7 @@ found:
 	if (a4000) {
 	    phys_base = GAYLE_BASE_4000;
 	    irqport = (unsigned long)ZTWO_VADDR(GAYLE_IRQ_4000);
+	    d.port_ops = gayle_a4000_port_ops;
 	} else {
 	    phys_base = GAYLE_BASE_1200;
 	    irqport = (unsigned long)ZTWO_VADDR(GAYLE_IRQ_1200);
@@ -164,7 +168,7 @@ found:
 	base = (unsigned long)ZTWO_VADDR(phys_base + i * GAYLE_NEXT_PORT);
 	ctrlport = GAYLE_HAS_CONTROL_REG ? (base + GAYLE_CONTROL) : 0;
 
-	gayle_setup_ports(&hw[i], base, ctrlport, irqport, gayle_ack_intr);
+	gayle_setup_ports(&hw[i], base, ctrlport, irqport);
 
 	hws[i] = &hw[i];
     }
Index: ide-2.6/drivers/ide/ide-io.c
===================================================================
--- ide-2.6.orig/drivers/ide/ide-io.c
+++ ide-2.6/drivers/ide/ide-io.c
@@ -789,7 +789,8 @@ irqreturn_t ide_intr (int irq, void *dev
 
 	spin_lock_irqsave(&hwif->lock, flags);
 
-	if (hwif->ack_intr && hwif->ack_intr(hwif) == 0)
+	if (hwif->port_ops && hwif->port_ops->test_irq &&
+	    hwif->port_ops->test_irq(hwif) == 0)
 		goto out;
 
 	handler = hwif->handler;
Index: ide-2.6/drivers/ide/macide.c
===================================================================
--- ide-2.6.orig/drivers/ide/macide.c
+++ ide-2.6/drivers/ide/macide.c
@@ -53,7 +53,7 @@
 
 volatile unsigned char *ide_ifr = (unsigned char *) (IDE_BASE + IDE_IFR);
 
-int macide_ack_intr(ide_hwif_t* hwif)
+int macide_test_irq(ide_hwif_t *hwif)
 {
 	if (*ide_ifr & 0x20)
 		return 1;
@@ -66,7 +66,7 @@ static int macide_clear_irq(ide_drive_t 
 }
 
 static void __init macide_setup_ports(struct ide_hw *hw, unsigned long base,
-				      int irq, ide_ack_intr_t *ack_intr)
+				      int irq)
 {
 	int i;
 
@@ -78,11 +78,11 @@ static void __init macide_setup_ports(st
 	hw->io_ports.ctl_addr = base + IDE_CONTROL;
 
 	hw->irq = irq;
-	hw->ack_intr = ack_intr;
 }
 
 static const struct ide_port_ops macide_port_ops = {
 	.clear_irq		= macide_clear_irq,
+	.test_irq		= macide_test_irq,
 };
 
 static const struct ide_port_info macide_port_info = {
@@ -101,7 +101,6 @@ static const char *mac_ide_name[] =
 
 static int __init macide_init(void)
 {
-	ide_ack_intr_t *ack_intr;
 	unsigned long base;
 	int irq;
 	struct ide_hw hw, *hws[] = { &hw };
@@ -113,17 +112,14 @@ static int __init macide_init(void)
 	switch (macintosh_config->ide_type) {
 	case MAC_IDE_QUADRA:
 		base = IDE_BASE;
-		ack_intr = macide_ack_intr;
 		irq = IRQ_NUBUS_F;
 		break;
 	case MAC_IDE_PB:
 		base = IDE_BASE;
-		ack_intr = macide_ack_intr;
 		irq = IRQ_NUBUS_C;
 		break;
 	case MAC_IDE_BABOON:
 		base = BABOON_BASE;
-		ack_intr = NULL;
 		d.port_ops = NULL;
 		irq = IRQ_BABOON_1;
 		break;
@@ -134,7 +130,7 @@ static int __init macide_init(void)
 	printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
 			 mac_ide_name[macintosh_config->ide_type - 1]);
 
-	macide_setup_ports(&hw, base, irq, ack_intr);
+	macide_setup_ports(&hw, base, irq);
 
 	return ide_host_add(&d, hws, 1, NULL);
 }
Index: ide-2.6/include/linux/ide.h
===================================================================
--- ide-2.6.orig/include/linux/ide.h
+++ ide-2.6/include/linux/ide.h
@@ -157,12 +157,6 @@ enum {
 #define REQ_UNPARK_HEADS	0x23
 
 /*
- * Check for an interrupt and acknowledge the interrupt status
- */
-struct hwif_s;
-typedef int (ide_ack_intr_t)(struct hwif_s *);
-
-/*
  * hwif_chipset_t is used to keep track of the specific hardware
  * chipset used by each IDE interface, if known.
  */
@@ -185,7 +179,6 @@ struct ide_hw {
 	};
 
 	int		irq;			/* our irq number */
-	ide_ack_intr_t	*ack_intr;		/* acknowledge interrupt */
 	struct device	*dev, *parent;
 	unsigned long	config;
 };
@@ -649,6 +642,7 @@ struct ide_port_ops {
 	void	(*maskproc)(ide_drive_t *, int);
 	void	(*quirkproc)(ide_drive_t *);
 	void	(*clear_irq)(ide_drive_t *);
+	int	(*test_irq)(struct hwif_s *);
 
 	u8	(*mdma_filter)(ide_drive_t *);
 	u8	(*udma_filter)(ide_drive_t *);
@@ -708,8 +702,6 @@ typedef struct hwif_s {
 
 	struct device *dev;
 
-	ide_ack_intr_t *ack_intr;
-
 	void (*rw_disk)(ide_drive_t *, struct request *);
 
 	const struct ide_tp_ops		*tp_ops;

