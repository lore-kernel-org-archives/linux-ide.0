From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH resend] pata_hpt3x2n: fix clock turnaround
Date: Mon, 7 Dec 2009 17:52:57 +0400
Message-ID: <200912071652.57615.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:42408 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S935047AbZLGNvk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 08:51:40 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org

The clock turnaround code still doesn't work for several reasons:

- 'USE_DPLL' flag in 'ap->host->private_data' is never initialized or updated,
  so the driver can only set the chip to the DPLL clock mode, not the PCI mode;

- the driver doesn't serialize access to the channels depending on the current
  clock mode like the vendor drivers, so the clock turnaround is only executed
  "optionally", not always as it should be;

- the wrong ports are written to when hpt3x2n_set_clock() is called for the
  secondary channel;

- hpt3x2n_set_clock() can inadvertently enable the disabled channels when
  resetting the channel state machines.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: stable@kernel.org

---
Resending with the corrected subject...

The patch is against the recent Linus' tree. It's intended to go into all
stable kernels starting with 2.6.19, when the PATA drivers were first merged --
the version change hunks could be dropped when merging to the older kernels...

 drivers/ata/pata_hpt3x2n.c |   64 ++++++++++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 29 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -8,7 +8,7 @@
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
- * Portions Copyright (C) 2005-2007	MontaVista Software, Inc.
+ * Portions Copyright (C) 2005-2009	MontaVista Software, Inc.
  *
  *
  * TODO
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.7"
+#define DRV_VERSION	"0.3.8"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -262,7 +262,7 @@ static void hpt3x2n_bmdma_stop(struct at
 
 static void hpt3x2n_set_clock(struct ata_port *ap, int source)
 {
-	void __iomem *bmdma = ap->ioaddr.bmdma_addr;
+	void __iomem *bmdma = ap->ioaddr.bmdma_addr - ap->port_no * 8;
 
 	/* Tristate the bus */
 	iowrite8(0x80, bmdma+0x73);
@@ -272,9 +272,9 @@ static void hpt3x2n_set_clock(struct ata
 	iowrite8(source, bmdma+0x7B);
 	iowrite8(0xC0, bmdma+0x79);
 
-	/* Reset state machines */
-	iowrite8(0x37, bmdma+0x70);
-	iowrite8(0x37, bmdma+0x74);
+	/* Reset state machines, avoid enabling the disabled channels */
+	iowrite8(ioread8(bmdma+0x70) | 0x32, bmdma+0x70);
+	iowrite8(ioread8(bmdma+0x74) | 0x32, bmdma+0x74);
 
 	/* Complete reset */
 	iowrite8(0x00, bmdma+0x79);
@@ -284,21 +284,10 @@ static void hpt3x2n_set_clock(struct ata
 	iowrite8(0x00, bmdma+0x77);
 }
 
-/* Check if our partner interface is busy */
-
-static int hpt3x2n_pair_idle(struct ata_port *ap)
-{
-	struct ata_host *host = ap->host;
-	struct ata_port *pair = host->ports[ap->port_no ^ 1];
-
-	if (pair->hsm_task_state == HSM_ST_IDLE)
-		return 1;
-	return 0;
-}
-
 static int hpt3x2n_use_dpll(struct ata_port *ap, int writing)
 {
 	long flags = (long)ap->host->private_data;
+
 	/* See if we should use the DPLL */
 	if (writing)
 		return USE_DPLL;	/* Needed for write */
@@ -307,20 +296,35 @@ static int hpt3x2n_use_dpll(struct ata_p
 	return 0;
 }
 
+static int hpt3x2n_qc_defer(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_port *alt = ap->host->ports[ap->port_no ^ 1];
+	int rc, flags = (long)ap->host->private_data;
+	int dpll = hpt3x2n_use_dpll(ap, qc->tf.flags & ATA_TFLAG_WRITE);
+
+	/* First apply the usual rules */
+	rc = ata_std_qc_defer(qc);
+	if (rc != 0)
+		return rc;
+
+	if ((flags & USE_DPLL) != dpll && alt->qc_active)
+		return ATA_DEFER_PORT;
+	return 0;
+}
+
 static unsigned int hpt3x2n_qc_issue(struct ata_queued_cmd *qc)
 {
-	struct ata_taskfile *tf = &qc->tf;
 	struct ata_port *ap = qc->ap;
 	int flags = (long)ap->host->private_data;
+	int dpll = hpt3x2n_use_dpll(ap, qc->tf.flags & ATA_TFLAG_WRITE);
 
-	if (hpt3x2n_pair_idle(ap)) {
-		int dpll = hpt3x2n_use_dpll(ap, (tf->flags & ATA_TFLAG_WRITE));
-		if ((flags & USE_DPLL) != dpll) {
-			if (dpll == 1)
-				hpt3x2n_set_clock(ap, 0x21);
-			else
-				hpt3x2n_set_clock(ap, 0x23);
-		}
+	if ((flags & USE_DPLL) != dpll) {
+		flags &= ~USE_DPLL;
+		flags |= dpll;
+		ap->host->private_data = (void *)flags;
+
+		hpt3x2n_set_clock(ap, dpll ? 0x21 : 0x23);
 	}
 	return ata_sff_qc_issue(qc);
 }
@@ -337,6 +341,8 @@ static struct ata_port_operations hpt3x2
 	.inherits	= &ata_bmdma_port_ops,
 
 	.bmdma_stop	= hpt3x2n_bmdma_stop,
+
+	.qc_defer	= hpt3x2n_qc_defer,
 	.qc_issue	= hpt3x2n_qc_issue,
 
 	.cable_detect	= hpt3x2n_cable_detect,
@@ -454,7 +460,7 @@ static int hpt3x2n_init_one(struct pci_d
 	unsigned int f_low, f_high;
 	int adjust;
 	unsigned long iobase = pci_resource_start(dev, 4);
-	void *hpriv = NULL;
+	void *hpriv = (void *)USE_DPLL;
 	int rc;
 
 	rc = pcim_enable_device(dev);
@@ -542,7 +548,7 @@ static int hpt3x2n_init_one(struct pci_d
 	/* Set our private data up. We only need a few flags so we use
 	   it directly */
 	if (pci_mhz > 60) {
-		hpriv = (void *)PCI66;
+		hpriv = (void *)(PCI66 | USE_DPLL);
 		/*
 		 * On  HPT371N, if ATA clock is 66 MHz we must set bit 2 in
 		 * the MISC. register to stretch the UltraDMA Tss timing.

