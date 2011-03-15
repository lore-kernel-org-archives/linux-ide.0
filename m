From: Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] ahci: don't enable port irq before handler is registered
Date: Tue, 15 Mar 2011 22:22:38 +0100
Message-ID: <1300224158.10827.52.camel@sakura.staff.proxad.net>
References: <1300129707.28545.34.camel@sakura.staff.proxad.net>
	 <4D7EB9EB.8030807@gmail.com> <1300162840.2118.4.camel@kero>
	 <20110315071937.GB8635@htj.dyndns.org>
	 <1300200509.10827.27.camel@sakura.staff.proxad.net>
	 <1300201422.10827.39.camel@sakura.staff.proxad.net>
	 <20110315151931.GA17376@htj.dyndns.org>
Reply-To: mbizon@freebox.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:58231 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239Ab1COVWs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Mar 2011 17:22:48 -0400
In-Reply-To: <20110315151931.GA17376@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>


From: Maxime Bizon <mbizon@freebox.fr>

The ahci_pmp_attach() & ahci_pmp_detach() unmask port irq, but they
are also called during port initialization, before ahci host irq
handler is registered. On ce4100 platform, this sometimes triggers
"irq 4: nobody cared" message when loading driver.

Fixed this by not touching the register if the port is in frozen
state, and mark all uninitialized port as frozen.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/ata/libahci.c     |   15 +++++++++++++--
 drivers/ata/libata-core.c |    2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 26d4523..eb5afdd 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1897,7 +1897,15 @@ static void ahci_pmp_attach(struct ata_port *ap)
 	ahci_enable_fbs(ap);
 
 	pp->intr_mask |= PORT_IRQ_BAD_PMP;
-	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+
+	/*
+	 * This may be called while we are still initializing the ahci
+	 * host, and interrupt handler is not yet registered at that
+	 * time. So don't mess with irq mask register unless the port
+	 * is actually enabled.
+	 */
+	if (!(ap->pflags & ATA_PFLAG_FROZEN))
+		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
 static void ahci_pmp_detach(struct ata_port *ap)
@@ -1913,7 +1921,10 @@ static void ahci_pmp_detach(struct ata_port *ap)
 	writel(cmd, port_mmio + PORT_CMD);
 
 	pp->intr_mask &= ~PORT_IRQ_BAD_PMP;
-	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
+
+	/* see comment above in ahci_pmp_attach() */
+	if (!(ap->pflags & ATA_PFLAG_FROZEN))
+		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
 int ahci_port_resume(struct ata_port *ap)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d4e52e2..02d5703 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5480,7 +5480,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	if (!ap)
 		return NULL;
 	
-	ap->pflags |= ATA_PFLAG_INITIALIZING;
+	ap->pflags |= ATA_PFLAG_INITIALIZING | ATA_PFLAG_FROZEN;
 	ap->lock = &host->lock;
 	ap->print_id = -1;
 	ap->host = host;
-- 
1.7.1




-- 
Maxime


