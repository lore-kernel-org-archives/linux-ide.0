From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] libata: introduce sff_set_devctl() method
Date: Fri, 7 May 2010 22:47:50 +0400
Message-ID: <201005072247.50318.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:58705 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754050Ab0EGSsi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 May 2010 14:48:38 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

The set of libata's taskfile access methods is clearly incomplete as it lacks
a method to write to the device control register -- which forces drivers like
'pata_bf54x' and 'pata_scc' to implement more "high level" (and more weighty)
methods like freeze() and postreset().

So, introduce the optional sff_set_devctl() method which the drivers only have
to implement if the standard iowrite8() can't be used (just like the existing
sff_check_altstatus() method) and make use of it in the freeze() and postreset()
method implementations (I could also have used it in softreset() method but it
also reads other taskfile registers without using tf_read() making that quite
pointless); this makes freeze() method implementations in the 'pata_bf54x' and
'pata_scc' methods virtually identical to ata_sff_freeze(), so we can get rid
of them completely.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 Documentation/DocBook/libata.tmpl |   12 +++++++++++
 drivers/ata/libata-sff.c          |   31 +++++++++++++++++++++++------
 drivers/ata/pata_bf54x.c          |   40 ++++++++++++--------------------------
 drivers/ata/pata_scc.c            |   38 +++++++++++-------------------------
 include/linux/libata.h            |    1 
 5 files changed, 63 insertions(+), 59 deletions(-)

Index: linux-2.6/Documentation/DocBook/libata.tmpl
===================================================================
--- linux-2.6.orig/Documentation/DocBook/libata.tmpl
+++ linux-2.6/Documentation/DocBook/libata.tmpl
@@ -225,6 +225,18 @@ u8   (*sff_check_altstatus)(struct ata_p
 
 	</sect2>
 
+	<sect2><title>Write specific ATA shadow register</title>
+	<programlisting>
+void (*sff_set_devctl)(struct ata_port *ap, u8 ctl);
+	</programlisting>
+
+	<para>
+	Write the device control ATA shadow register to the hardware.
+	Most drivers don't need to define this.
+	</para>
+
+	</sect2>
+
 	<sect2><title>Select ATA device on bus</title>
 	<programlisting>
 void (*sff_dev_select)(struct ata_port *ap, unsigned int device);
Index: linux-2.6/drivers/ata/libata-sff.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-sff.c
+++ linux-2.6/drivers/ata/libata-sff.c
@@ -446,6 +446,27 @@ int ata_sff_wait_ready(struct ata_link *
 EXPORT_SYMBOL_GPL(ata_sff_wait_ready);
 
 /**
+ *	ata_sff_set_devctl - Write device control reg
+ *	@ap: port where the device is
+ *	@ctl: value to write
+ *
+ *	Writes ATA taskfile device control register.
+ *
+ *	Note: may NOT be used as the sff_set_devctl() entry in
+ *	ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static void ata_sff_set_devctl(struct ata_port *ap, u8 ctl)
+{
+	if (ap->ops->sff_set_devctl)
+		ap->ops->sff_set_devctl(ap, ctl);
+	else
+		iowrite8(ctl, ap->ioaddr.ctl_addr);
+}
+
+/**
  *	ata_sff_dev_select - Select device 0/1 on ATA bus
  *	@ap: ATA channel to manipulate
  *	@device: ATA device (numbered from zero) to select
@@ -1895,13 +1916,11 @@ EXPORT_SYMBOL_GPL(ata_sff_lost_interrupt
  */
 void ata_sff_freeze(struct ata_port *ap)
 {
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
 	ap->ctl |= ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
-	if (ioaddr->ctl_addr)
-		iowrite8(ap->ctl, ioaddr->ctl_addr);
+	if (ap->ops->sff_set_devctl || ap->ioaddr.ctl_addr)
+		ata_sff_set_devctl(ap, ap->ctl);
 
 	/* Under certain circumstances, some controllers raise IRQ on
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
@@ -2301,8 +2320,8 @@ void ata_sff_postreset(struct ata_link *
 	}
 
 	/* set up device control */
-	if (ap->ioaddr.ctl_addr) {
-		iowrite8(ap->ctl, ap->ioaddr.ctl_addr);
+	if (ap->ops->sff_set_devctl || ap->ioaddr.ctl_addr) {
+		ata_sff_set_devctl(ap, ap->ctl);
 		ap->last_ctl = ap->ctl;
 	}
 }
Index: linux-2.6/drivers/ata/pata_bf54x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_bf54x.c
+++ linux-2.6/drivers/ata/pata_bf54x.c
@@ -821,6 +821,18 @@ static void bfin_dev_select(struct ata_p
 }
 
 /**
+ *	bfin_set_devctl - Write device control reg
+ *	@ap: port where the device is
+ *	@ctl: value to write
+ */
+
+static u8 bfin_set_devctl(struct ata_port *ap, u8 ctl)
+{
+	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
+	write_atapi_register(base, ATA_REG_CTRL, ctl);
+}
+
+/**
  *	bfin_bmdma_setup - Set up IDE DMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
@@ -1240,32 +1252,6 @@ static unsigned char bfin_irq_on(struct 
 }
 
 /**
- *	bfin_freeze - Freeze DMA controller port
- *	@ap: port to freeze
- *
- *	Note: Original code is ata_sff_freeze().
- */
-
-static void bfin_freeze(struct ata_port *ap)
-{
-	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
-
-	dev_dbg(ap->dev, "in atapi dma freeze\n");
-	ap->ctl |= ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	write_atapi_register(base, ATA_REG_CTRL, ap->ctl);
-
-	/* Under certain circumstances, some controllers raise IRQ on
-	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
-	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
-	 */
-	ap->ops->sff_check_status(ap);
-
-	bfin_irq_clear(ap);
-}
-
-/**
  *	bfin_thaw - Thaw DMA controller port
  *	@ap: port to thaw
  *
@@ -1476,6 +1462,7 @@ static struct ata_port_operations bfin_p
 	.sff_check_status	= bfin_check_status,
 	.sff_check_altstatus	= bfin_check_altstatus,
 	.sff_dev_select		= bfin_dev_select,
+	.sff_set_devctl		= bfin_set_devctl,
 
 	.bmdma_setup		= bfin_bmdma_setup,
 	.bmdma_start		= bfin_bmdma_start,
@@ -1485,7 +1472,6 @@ static struct ata_port_operations bfin_p
 
 	.qc_prep		= ata_noop_qc_prep,
 
-	.freeze			= bfin_freeze,
 	.thaw			= bfin_thaw,
 	.softreset		= bfin_softreset,
 	.postreset		= bfin_postreset,
Index: linux-2.6/drivers/ata/pata_scc.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_scc.c
+++ linux-2.6/drivers/ata/pata_scc.c
@@ -416,6 +416,17 @@ static void scc_dev_select (struct ata_p
 }
 
 /**
+ *	scc_set_devctl - Write device control reg
+ *	@ap: port where the device is
+ *	@ctl: value to write
+ */
+
+static void scc_set_devctl(struct ata_port *ap, u8 ctl)
+{
+	out_be32(ap->ioaddr.ctl_addr, ctl);
+}
+
+/**
  *	scc_bmdma_setup - Set up PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
@@ -840,31 +851,6 @@ static u8 scc_irq_on (struct ata_port *a
 }
 
 /**
- *	scc_freeze - Freeze BMDMA controller port
- *	@ap: port to freeze
- *
- *	Note: Original code is ata_sff_freeze().
- */
-
-static void scc_freeze (struct ata_port *ap)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-
-	ap->ctl |= ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	out_be32(ioaddr->ctl_addr, ap->ctl);
-
-	/* Under certain circumstances, some controllers raise IRQ on
-	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
-	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.
-	 */
-	ap->ops->sff_check_status(ap);
-
-	ap->ops->sff_irq_clear(ap);
-}
-
-/**
  *	scc_pata_prereset - prepare for reset
  *	@ap: ATA port to be reset
  *	@deadline: deadline jiffies for the operation
@@ -977,6 +963,7 @@ static struct ata_port_operations scc_pa
 	.sff_check_status	= scc_check_status,
 	.sff_check_altstatus	= scc_check_altstatus,
 	.sff_dev_select		= scc_dev_select,
+	.sff_set_devctl		= scc_set_devctl,
 
 	.bmdma_setup		= scc_bmdma_setup,
 	.bmdma_start		= scc_bmdma_start,
@@ -984,7 +971,6 @@ static struct ata_port_operations scc_pa
 	.bmdma_status		= scc_bmdma_status,
 	.sff_data_xfer		= scc_data_xfer,
 
-	.freeze			= scc_freeze,
 	.prereset		= scc_pata_prereset,
 	.softreset		= scc_softreset,
 	.postreset		= scc_postreset,
Index: linux-2.6/include/linux/libata.h
===================================================================
--- linux-2.6.orig/include/linux/libata.h
+++ linux-2.6/include/linux/libata.h
@@ -849,6 +849,7 @@ struct ata_port_operations {
 	 * SFF / taskfile oriented ops
 	 */
 	void (*sff_dev_select)(struct ata_port *ap, unsigned int device);
+	void (*sff_set_devctl)(struct ata_port *ap, u8 ctl);
 	u8   (*sff_check_status)(struct ata_port *ap);
 	u8   (*sff_check_altstatus)(struct ata_port *ap);
 	void (*sff_tf_load)(struct ata_port *ap, const struct ata_taskfile *tf);
