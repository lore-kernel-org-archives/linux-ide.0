From: Tejun Heo <htejun@gmail.com>
Subject: Re: "irq 4: nobody cared" when loading ahci driver on ce4100
Date: Tue, 15 Mar 2011 08:19:37 +0100
Message-ID: <20110315071937.GB8635@htj.dyndns.org>
References: <1300129707.28545.34.camel@sakura.staff.proxad.net>
 <4D7EB9EB.8030807@gmail.com>
 <1300162840.2118.4.camel@kero>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58773 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab1COHTn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Mar 2011 03:19:43 -0400
Received: by fxm17 with SMTP id 17so274000fxm.19
        for <linux-ide@vger.kernel.org>; Tue, 15 Mar 2011 00:19:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300162840.2118.4.camel@kero>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maxime Bizon <mbizon@freebox.fr>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>

Hello,

On Tue, Mar 15, 2011 at 05:20:40AM +0100, Maxime Bizon wrote:
> On Mon, 2011-03-14 at 18:59 -0600, Robert Hancock wrote:
> 
> > Where is ahci_thaw being called? It shouldn't be called before the IRQ
> > handler is registered - I think it should only be called from the
> > error 
> 
> it is not
> 
> ahci_pmp_attach/ahci_pmp_detach are the one setting the irq_mask too
> soon

Does the following patch fix the problem?  Thanks.

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 26d4523..6a01e3d 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1897,7 +1897,9 @@ static void ahci_pmp_attach(struct ata_port *ap)
 	ahci_enable_fbs(ap);
 
 	pp->intr_mask |= PORT_IRQ_BAD_PMP;
-	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+
+	if (!(ap->pflags & ATA_PFLAG_FROZEN))
+		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
 static void ahci_pmp_detach(struct ata_port *ap)
@@ -1913,7 +1915,9 @@ static void ahci_pmp_detach(struct ata_port *ap)
 	writel(cmd, port_mmio + PORT_CMD);
 
 	pp->intr_mask &= ~PORT_IRQ_BAD_PMP;
-	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+
+	if (!(ap->pflags & ATA_PFLAG_FROZEN))
+		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
 int ahci_port_resume(struct ata_port *ap)


-- 
tejun
