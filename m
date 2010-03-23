From: Tejun Heo <tj@kernel.org>
Subject: [libata-dev#upstream-fixes RESEND] libata-sff: fix spurious IRQ handling
Date: Tue, 23 Mar 2010 12:24:08 +0900
Message-ID: <4BA83458.6010003@kernel.org>
References: <4BA7253F.8070500@kernel.org> <4BA82BDF.2070308@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58875 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084Ab0CWDYo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Mar 2010 23:24:44 -0400
In-Reply-To: <4BA82BDF.2070308@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, b3nton@gmail.com, petr.uzel@centrum.cz, "Rafael J. Wysocki" <rjw@sisk.pl>

Commit 27943620cbd960f710a385ff4a538e14ed3f1922 introduced spurious
IRQ handling but it has a race condition where valid completion can be
lost while trying to clear spurious IRQ leading to occassional command
timeouts.

This patch improves SFF interrupt handler such that

1. Once BMDMA HSM is stopped, the condition is never considered
    spurious.  As there's no way to resume stopped BMDMA HSM, if device
    status doesn't agree with BMDMA status, the only way out is
    aborting the command (otherwise, it will just end up timing out).

2. ap->ops->sff_check_status() can be safely called to clear spurious
    device IRQ as it atomically returns completion status but BMDMA IRQ
    status can't be cleared in safe way if command is in flight.  After
    a spurious IRQ, call ap->ops->sff_irq_clear() only if the
    respective device is idle and retry completion if
    sff_check_status() indicates command completion.

Please note that ata_piix uses bmdma_status for sff_irq_check() and #2
won't weaken spurious IRQ handling even with in-flight command because
if bmdma_status indicates IRQ pending but device status is not on
spurious check, the next IRQ handler invocation will abort the command
due to #1.

This fixes bko#15537.

   https://bugzilla.kernel.org/show_bug.cgi?id=15537

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andrew Benton <b3nton@gmail.com>
Cc: Petr Uzel <petr.uzel@centrum.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
---
> hmmmm, could you resend this patch?
> Neither git am nor patch(1) seem to like it...

Here it is.  Puzzled, the original posting was whitespace corrupt (all
tabs were replaced with spaces) although I sent it exactly the same
way as other patches.

  drivers/ata/libata-sff.c |   43 +++++++++++++++++++++++++++++++++++--------
  1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 561dec2..66f6bd1 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1667,6 +1667,7 @@ unsigned int ata_sff_host_intr(struct ata_port *ap,
  {
  	struct ata_eh_info *ehi = &ap->link.eh_info;
  	u8 status, host_stat = 0;
+	bool bmdma_stopped = false;
  
  	VPRINTK("ata%u: protocol %d task_state %d\n",
  		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
@@ -1699,6 +1700,7 @@ unsigned int ata_sff_host_intr(struct ata_port *ap,
  
  			/* before we do anything else, clear DMA-Start bit */
  			ap->ops->bmdma_stop(qc);
+			bmdma_stopped = true;
  
  			if (unlikely(host_stat & ATA_DMA_ERR)) {
  				/* error when transfering data to/from memory */
@@ -1716,8 +1718,14 @@ unsigned int ata_sff_host_intr(struct ata_port *ap,
  
  	/* check main status, clearing INTRQ if needed */
  	status = ata_sff_irq_status(ap);
-	if (status & ATA_BUSY)
-		goto idle_irq;
+	if (status & ATA_BUSY) {
+		if (bmdma_stopped) {
+			/* BMDMA engine is already stopped, we're screwed */
+			qc->err_mask |= AC_ERR_HSM;
+			ap->hsm_task_state = HSM_ST_ERR;
+		} else
+			goto idle_irq;
+	}
  
  	/* ack bmdma irq events */
  	ap->ops->sff_irq_clear(ap);
@@ -1762,13 +1770,15 @@ EXPORT_SYMBOL_GPL(ata_sff_host_intr);
  irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
  {
  	struct ata_host *host = dev_instance;
+	bool retried = false;
  	unsigned int i;
-	unsigned int handled = 0, polling = 0;
+	unsigned int handled, idle, polling;
  	unsigned long flags;
  
  	/* TODO: make _irqsave conditional on x86 PCI IDE legacy mode */
  	spin_lock_irqsave(&host->lock, flags);
-
+retry:
+	handled = idle = polling = 0;
  	for (i = 0; i < host->n_ports; i++) {
  		struct ata_port *ap = host->ports[i];
  		struct ata_queued_cmd *qc;
@@ -1782,7 +1792,8 @@ irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
  				handled |= ata_sff_host_intr(ap, qc);
  			else
  				polling |= 1 << i;
-		}
+		} else
+			idle |= 1 << i;
  	}
  
  	/*
@@ -1790,7 +1801,9 @@ irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
  	 * asserting IRQ line, nobody cared will ensue.  Check IRQ
  	 * pending status if available and clear spurious IRQ.
  	 */
-	if (!handled) {
+	if (!handled && !retried) {
+		bool retry = false;
+
  		for (i = 0; i < host->n_ports; i++) {
  			struct ata_port *ap = host->ports[i];
  
@@ -1805,8 +1818,22 @@ irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
  				ata_port_printk(ap, KERN_INFO,
  						"clearing spurious IRQ\n");
  
-			ap->ops->sff_check_status(ap);
-			ap->ops->sff_irq_clear(ap);
+			if (idle & (1 << i)) {
+				ap->ops->sff_check_status(ap);
+				ap->ops->sff_irq_clear(ap);
+			} else {
+				/* clear INTRQ and check if BUSY cleared */
+				if (!(ap->ops->sff_check_status(ap) & ATA_BUSY))
+					retry |= true;
+				/*
+				 * With command in flight, we can't do
+				 * sff_irq_clear() w/o racing with completion.
+				 */
+			}
+		}
+		if (retry) {
+			retried = true;
+			goto retry;
  		}
  	}
  
