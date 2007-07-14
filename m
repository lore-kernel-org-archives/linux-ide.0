From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] icside: fix ->speedproc to return on unsupported modes
Date: Sat, 14 Jul 2007 20:15:59 +0100
Message-ID: <20070714191559.GB2037@flint.arm.linux.org.uk>
References: <200707110200.37607.bzolnier@gmail.com> <200707112321.41597.bzolnier@gmail.com> <46967FA8.4090406@ru.mvista.com> <200707132302.04065.bzolnier@gmail.com> <20070713213948.GA18000@flint.arm.linux.org.uk> <20070714001523.2dafed67@the-village.bc.nu> <20070713232038.GA9352@flint.arm.linux.org.uk> <20070714005435.1507c17e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:33530 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759547AbXGNTQW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jul 2007 15:16:22 -0400
Content-Disposition: inline
In-Reply-To: <20070714005435.1507c17e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Sat, Jul 14, 2007 at 12:54:35AM +0100, Alan Cox wrote:
> > We need to set the IRQ enable initially so that the identity information
> > can be read and the drive accessed etc.  However, if no drives are
> > detected on a port, there is no callback into the low level driver -
> > the port_disable method is never called.  (I believe it is with SATA.)
> 
> No. It actually makes no sense to do so as libata is hot plug capable
> thus the usual case is "no drives are currently detected"
>  
> > I tried asking about this several times before the driver was merged
> > and every time it was completely ignored. 
> 
> Provide a private postreset method thats
> 
> 
> static void my_postreset(struct ata_port *ap, unsigned int *classes)
> {
> 	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
> 		force IRQ off [should be off anyway]
> 	} else {
> 		return ata_std_postreset(ap, classes);
> 	}
> }

So something like this?

diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index c791a46..91bdb01 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -330,17 +330,12 @@ static void ata_dummy_noret(struct ata_port *port)
 {
 }
 
-/*
- * We need to shut down unused ports to prevent spurious interrupts.
- * FIXME: the libata core doesn't call this function for PATA interfaces.
- */
-static void pata_icside_port_disable(struct ata_port *ap)
+static void pata_icside_postreset(struct ata_port *ap, unsigned int *classes)
 {
 	struct pata_icside_state *state = ap->host->private_data;
 
-	ata_port_printk(ap, KERN_ERR, "disabling icside port\n");
-
-	ata_port_disable(ap);
+	if (classes[0] != ATA_DEV_NONE || classes[1] != ATA_DEV_NONE)
+		return ata_std_postreset(ap, classes);
 
 	state->port[ap->port_no].disabled = 1;
 
@@ -356,6 +351,12 @@ static void pata_icside_port_disable(struct ata_port *ap)
 	}
 }
 
+static void pata_icside_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, NULL,
+			   pata_icside_postreset);
+}
+
 static u8 pata_icside_irq_ack(struct ata_port *ap, unsigned int chk_drq)
 {
 	unsigned int bits = chk_drq ? ATA_BUSY | ATA_DRQ : ATA_BUSY;
@@ -374,7 +375,7 @@ static u8 pata_icside_irq_ack(struct ata_port *ap, unsigned int chk_drq)
 }
 
 static struct ata_port_operations pata_icside_port_ops = {
-	.port_disable		= pata_icside_port_disable,
+	.port_disable		= ata_port_disable,
 
 	.set_dmamode		= pata_icside_set_dmamode,
 
@@ -397,7 +398,7 @@ static struct ata_port_operations pata_icside_port_ops = {
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
+	.error_handler		= pata_icside_error_handler,
 	.post_internal_cmd	= pata_icside_bmdma_stop,
 
 	.irq_clear		= ata_dummy_noret,
@@ -484,13 +485,6 @@ static int __devinit pata_icside_register_v6(struct pata_icside_info *info)
 	state->port[0].port_sel = sel;
 	state->port[1].port_sel = sel | 1;
 
-	/*
-	 * FIXME: work around libata's aversion to calling port_disable.
-	 * This permanently disables interrupts on port 0 - bad luck if
-	 * you have a drive on that port.
-	 */
-	state->port[0].disabled = 1;
-
 	info->base = easi_base;
 	info->irqops = &pata_icside_ops_arcin_v6;
 	info->nr_ports = 2;


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
