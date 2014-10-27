From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH libata/for-3.18-fixes] Revert "AHCI: Optimize
 single IRQ interrupt processing"
Date: Mon, 27 Oct 2014 09:58:02 -0400
Message-ID: <20141027135802.GI4436@htj.dyndns.org>
References: <1414082970-20775-1-git-send-email-marc.zyngier@arm.com>
 <20141027132045.GA30198@agordeev.usersys.redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDQ2FCEAWYLRB3M6XGRAKGQEAHXKFOY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20141027132045.GA30198-QOHinCyTyHu/4bX3TIDHR/XAX3CI6PSWQQ4Iyu8u01E@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
Content-Disposition: inline
To: Alexander Gordeev <agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

>From 61e268068c92ed000f078dc1ab71d1228439fecd Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Mon, 27 Oct 2014 09:50:36 -0400

This reverts commit 18dcf433f3ded61eb140a55e7048ec2fef79e723.
IRQF_ONESHOT was missing from the conversion causing screaming
interrupts problems on some setups and LKP detected measureable drop
in IO performance.  It looks like we'll first need to drop the
threaded IRQ handling first before splitting locking.

Signed-off-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alexander Gordeev <agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Reported-by: kernel test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reported-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Link: http://lkml.kernel.org/g/20141027021651.GF27038-PVvIA+FzE60D0+JXs3kMbRL4W9x8LtSr@public.gmane.org
Link: http://lkml.kernel.org/g/1414082970-20775-1-git-send-email-marc.zyngier-5wv7dgnIgG8@public.gmane.org
---
 drivers/ata/libahci.c | 74 +++++++++------------------------------------------
 1 file changed, 13 insertions(+), 61 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 5eb61c9..5b0cccc 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1778,16 +1778,15 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 	}
 }
 
-static void ahci_update_intr_status(struct ata_port *ap)
+static void ahci_port_intr(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
-	struct ahci_port_priv *pp = ap->private_data;
 	u32 status;
 
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
-	atomic_or(status, &pp->intr_status);
+	ahci_handle_port_interrupt(ap, port_mmio, status);
 }
 
 static irqreturn_t ahci_port_thread_fn(int irq, void *dev_instance)
@@ -1808,34 +1807,6 @@ static irqreturn_t ahci_port_thread_fn(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
-irqreturn_t ahci_thread_fn(int irq, void *dev_instance)
-{
-	struct ata_host *host = dev_instance;
-	struct ahci_host_priv *hpriv = host->private_data;
-	u32 irq_masked = hpriv->port_map;
-	unsigned int i;
-
-	for (i = 0; i < host->n_ports; i++) {
-		struct ata_port *ap;
-
-		if (!(irq_masked & (1 << i)))
-			continue;
-
-		ap = host->ports[i];
-		if (ap) {
-			ahci_port_thread_fn(irq, ap);
-			VPRINTK("port %u\n", i);
-		} else {
-			VPRINTK("port %u (no irq)\n", i);
-			if (ata_ratelimit())
-				dev_warn(host->dev,
-					 "interrupt on disabled port %u\n", i);
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t ahci_multi_irqs_intr(int irq, void *dev_instance)
 {
 	struct ata_port *ap = dev_instance;
@@ -1883,7 +1854,7 @@ static irqreturn_t ahci_single_irq_intr(int irq, void *dev_instance)
 
 		ap = host->ports[i];
 		if (ap) {
-			ahci_update_intr_status(ap);
+			ahci_port_intr(ap);
 			VPRINTK("port %u\n", i);
 		} else {
 			VPRINTK("port %u (no irq)\n", i);
@@ -1908,7 +1879,7 @@ static irqreturn_t ahci_single_irq_intr(int irq, void *dev_instance)
 
 	VPRINTK("EXIT\n");
 
-	return handled ? IRQ_WAKE_THREAD : IRQ_NONE;
+	return IRQ_RETVAL(handled);
 }
 
 unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
@@ -2320,8 +2291,13 @@ static int ahci_port_start(struct ata_port *ap)
 	 */
 	pp->intr_mask = DEF_PORT_IRQ;
 
-	spin_lock_init(&pp->lock);
-	ap->lock = &pp->lock;
+	/*
+	 * Switch to per-port locking in case each port has its own MSI vector.
+	 */
+	if ((hpriv->flags & AHCI_HFLAG_MULTI_MSI)) {
+		spin_lock_init(&pp->lock);
+		ap->lock = &pp->lock;
+	}
 
 	ap->private_data = pp;
 
@@ -2482,31 +2458,6 @@ out_free_irqs:
 	return rc;
 }
 
-static int ahci_host_activate_single_irq(struct ata_host *host, int irq,
-					 struct scsi_host_template *sht)
-{
-	int i, rc;
-
-	rc = ata_host_start(host);
-	if (rc)
-		return rc;
-
-	rc = devm_request_threaded_irq(host->dev, irq, ahci_single_irq_intr,
-				       ahci_thread_fn, IRQF_SHARED,
-				       dev_driver_string(host->dev), host);
-	if (rc)
-		return rc;
-
-	for (i = 0; i < host->n_ports; i++)
-		ata_port_desc(host->ports[i], "irq %d", irq);
-
-	rc = ata_host_register(host, sht);
-	if (rc)
-		devm_free_irq(host->dev, irq, host);
-
-	return rc;
-}
-
 /**
  *	ahci_host_activate - start AHCI host, request IRQs and register it
  *	@host: target ATA host
@@ -2532,7 +2483,8 @@ int ahci_host_activate(struct ata_host *host, int irq,
 	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI)
 		rc = ahci_host_activate_multi_irqs(host, irq, sht);
 	else
-		rc = ahci_host_activate_single_irq(host, irq, sht);
+		rc = ata_host_activate(host, irq, ahci_single_irq_intr,
+				       IRQF_SHARED, sht);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_host_activate);
-- 
1.9.3
