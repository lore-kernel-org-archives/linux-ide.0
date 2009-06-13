From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/10] ide: move IRQ clearing from ack_intr() method to clear_irq() method (take 2)
Date: Sat, 13 Jun 2009 17:31:00 +0400
Message-ID: <200906131731.00976.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-m68k-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

There are now two methods that clear the port interrupt: ack_intr() method,
implemented only on M680x0 machines, that is called at the start of ide_intr(),
and clear_irq() method, that is called somewhat later in this function.  In
order to stop this duplication, delegate the task of clearing the interrupt
to clear_irq() method, only leaving to ack_intr() the task of testing for the
port interrupt.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git 'for-next' branch.

Changes since previous take:
- undid the code reordering in ide_intr();
- converted xsurf_ack_intr() into xsurf_clear_irq();
- fixed error in gayle_init() by adding missed &;
- fixed 2 warnings by making macide_clear_irq() void.

 drivers/ide/buddha.c |   27 +++++++++++++--------------
 drivers/ide/gayle.c  |   23 +++++++++++------------
 drivers/ide/ide-io.c |    2 --
 drivers/ide/macide.c |   18 ++++++++++++++----
 4 files changed, 38 insertions(+), 32 deletions(-)

Index: ide-2.6/drivers/ide/buddha.c
===================================================================
--- ide-2.6.orig/drivers/ide/buddha.c
+++ ide-2.6/drivers/ide/buddha.c
@@ -109,16 +109,12 @@ static int buddha_ack_intr(ide_hwif_t *h
     return 1;
 }
 
-static int xsurf_ack_intr(ide_hwif_t *hwif)
+static void xsurf_clear_irq(ide_drive_t *drive)
 {
-    unsigned char ch;
-
-    ch = z_readb(hwif->io_ports.irq_addr);
-    /* X-Surf needs a 0 written to IRQ register to ensure ISA bit A11 stays at 0 */
-    z_writeb(0, hwif->io_ports.irq_addr);
-    if (!(ch & 0x80))
-	    return 0;
-    return 1;
+    /*
+     * X-Surf needs 0 written to IRQ register to ensure ISA bit A11 stays at 0
+     */
+    z_writeb(0, drive->hwif->io_ports.irq_addr);
 }
 
 static void __init buddha_setup_ports(struct ide_hw *hw, unsigned long base,
@@ -141,6 +137,10 @@ static void __init buddha_setup_ports(st
 	hw->ack_intr = ack_intr;
 }
 
+static const struct ide_port_ops xsurf_port_ops = {
+	.clear_irq		= xsurf_clear_irq,
+};
+
 static const struct ide_port_info buddha_port_info = {
 	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
 	.irq_flags		= IRQF_SHARED,
@@ -161,6 +161,7 @@ static int __init buddha_init(void)
 	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
 		unsigned long board;
 		struct ide_hw hw[MAX_NUM_HWIFS], *hws[MAX_NUM_HWIFS];
+		struct ide_port_info d = buddha_port_info;
 
 		if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
 			buddha_num_hwifs = BUDDHA_NUM_HWIFS;
@@ -171,6 +172,7 @@ static int __init buddha_init(void)
 		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF) {
 			buddha_num_hwifs = XSURF_NUM_HWIFS;
 			type=BOARD_XSURF;
+			d.port_ops = &xsurf_port_ops;
 		} else 
 			continue;
 		
@@ -203,28 +205,25 @@ fail_base2:
 
 		for (i = 0; i < buddha_num_hwifs; i++) {
 			unsigned long base, ctl, irq_port;
-			ide_ack_intr_t *ack_intr;
 
 			if (type != BOARD_XSURF) {
 				base = buddha_board + buddha_bases[i];
 				ctl = base + BUDDHA_CONTROL;
 				irq_port = buddha_board + buddha_irqports[i];
-				ack_intr = buddha_ack_intr;
 			} else {
 				base = buddha_board + xsurf_bases[i];
 				/* X-Surf has no CS1* (Control/AltStat) */
 				ctl = 0;
 				irq_port = buddha_board + xsurf_irqports[i];
-				ack_intr = xsurf_ack_intr;
 			}
 
 			buddha_setup_ports(&hw[i], base, ctl, irq_port,
-					   ack_intr);
+					   buddha_ack_intr);
 
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
 
-static int gayle_ack_intr_a4000(ide_hwif_t *hwif)
+static int gayle_ack_intr(ide_hwif_t *hwif)
 {
     unsigned char ch;
 
@@ -76,16 +76,12 @@ static int gayle_ack_intr_a4000(ide_hwif
     return 1;
 }
 
-static int gayle_ack_intr_a1200(ide_hwif_t *hwif)
+static void gayle_a1200_clear_irq(ide_drive_t *drive)
 {
-    unsigned char ch;
+    ide_hwif_t *hwif = drive->hwif;
 
-    ch = z_readb(hwif->io_ports.irq_addr);
-    if (!(ch & GAYLE_IRQ_IDE))
-	return 0;
     (void)z_readb(hwif->io_ports.status_addr);
     z_writeb(0x7c, hwif->io_ports.irq_addr);
-    return 1;
 }
 
 static void __init gayle_setup_ports(struct ide_hw *hw, unsigned long base,
@@ -108,6 +104,10 @@ static void __init gayle_setup_ports(str
 	hw->ack_intr = ack_intr;
 }
 
+static const struct ide_port_ops gayle_a1200_port_ops = {
+	.clear_irq		= gayle_a1200_clear_irq,
+};
+
 static const struct ide_port_info gayle_port_info = {
 	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_SERIALIZE |
 				  IDE_HFLAG_NO_DMA,
@@ -123,9 +123,9 @@ static int __init gayle_init(void)
 {
     unsigned long phys_base, res_start, res_n;
     unsigned long base, ctrlport, irqport;
-    ide_ack_intr_t *ack_intr;
     int a4000, i, rc;
     struct ide_hw hw[GAYLE_NUM_HWIFS], *hws[GAYLE_NUM_HWIFS];
+    struct ide_port_info d = gayle_port_info;
 
     if (!MACH_IS_AMIGA)
 	return -ENODEV;
@@ -148,11 +148,10 @@ found:
 	if (a4000) {
 	    phys_base = GAYLE_BASE_4000;
 	    irqport = (unsigned long)ZTWO_VADDR(GAYLE_IRQ_4000);
-	    ack_intr = gayle_ack_intr_a4000;
 	} else {
 	    phys_base = GAYLE_BASE_1200;
 	    irqport = (unsigned long)ZTWO_VADDR(GAYLE_IRQ_1200);
-	    ack_intr = gayle_ack_intr_a1200;
+	    d.port_ops = &gayle_a1200_port_ops;
 	}
 
 	res_start = ((unsigned long)phys_base) & ~(GAYLE_NEXT_PORT-1);
@@ -165,12 +164,12 @@ found:
 	base = (unsigned long)ZTWO_VADDR(phys_base + i * GAYLE_NEXT_PORT);
 	ctrlport = GAYLE_HAS_CONTROL_REG ? (base + GAYLE_CONTROL) : 0;
 
-	gayle_setup_ports(&hw[i], base, ctrlport, irqport, ack_intr);
+	gayle_setup_ports(&hw[i], base, ctrlport, irqport, gayle_ack_intr);
 
 	hws[i] = &hw[i];
     }
 
-    rc = ide_host_add(&gayle_port_info, hws, i, NULL);
+    rc = ide_host_add(&d, hws, i, NULL);
     if (rc)
 	release_mem_region(res_start, res_n);
 
Index: ide-2.6/drivers/ide/ide-io.c
===================================================================
--- ide-2.6.orig/drivers/ide/ide-io.c
+++ ide-2.6/drivers/ide/ide-io.c
@@ -671,8 +671,6 @@ void ide_timer_expiry (unsigned long dat
 		} else if (drive_is_ready(drive)) {
 			if (drive->waiting_for_dma)
 				hwif->dma_ops->dma_lost_irq(drive);
-			if (hwif->ack_intr)
-				hwif->ack_intr(hwif);
 			if (hwif->port_ops && hwif->port_ops->clear_irq)
 				hwif->port_ops->clear_irq(drive);
 
Index: ide-2.6/drivers/ide/macide.c
===================================================================
--- ide-2.6.orig/drivers/ide/macide.c
+++ ide-2.6/drivers/ide/macide.c
@@ -55,13 +55,16 @@ volatile unsigned char *ide_ifr = (unsig
 
 int macide_ack_intr(ide_hwif_t* hwif)
 {
-	if (*ide_ifr & 0x20) {
-		*ide_ifr &= ~0x20;
+	if (*ide_ifr & 0x20)
 		return 1;
-	}
 	return 0;
 }
 
+static void macide_clear_irq(ide_drive_t *drive)
+{
+	*ide_ifr &= ~0x20;
+}
+
 static void __init macide_setup_ports(struct ide_hw *hw, unsigned long base,
 				      int irq, ide_ack_intr_t *ack_intr)
 {
@@ -78,7 +81,12 @@ static void __init macide_setup_ports(st
 	hw->ack_intr = ack_intr;
 }
 
+static const struct ide_port_ops macide_port_ops = {
+	.clear_irq		= macide_clear_irq,
+};
+
 static const struct ide_port_info macide_port_info = {
+	.port_ops		= &macide_port_ops,
 	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
 	.irq_flags		= IRQF_SHARED,
 	.chipset		= ide_generic,
@@ -97,6 +105,7 @@ static int __init macide_init(void)
 	unsigned long base;
 	int irq;
 	struct ide_hw hw, *hws[] = { &hw };
+	struct ide_port_info d = macide_port_info;
 
 	if (!MACH_IS_MAC)
 		return -ENODEV;
@@ -115,6 +124,7 @@ static int __init macide_init(void)
 	case MAC_IDE_BABOON:
 		base = BABOON_BASE;
 		ack_intr = NULL;
+		d.port_ops = NULL;
 		irq = IRQ_BABOON_1;
 		break;
 	default:
@@ -126,7 +136,7 @@ static int __init macide_init(void)
 
 	macide_setup_ports(&hw, base, irq, ack_intr);
 
-	return ide_host_add(&macide_port_info, hws, 1, NULL);
+	return ide_host_add(&d, hws, 1, NULL);
 }
 
 module_init(macide_init);

