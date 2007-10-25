From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] ide: remove IRQF_DISABLED from IRQ flags for IDE IRQ handler
Date: Fri, 26 Oct 2007 01:35:32 +0200
Message-ID: <200710260135.32345.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:3232 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758651AbXJYXdm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 19:33:42 -0400
Received: by nf-out-0910.google.com with SMTP id g13so631757nfb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 16:33:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


IRQF_DISABLED is not needed because the first thing that ide_intr()
(IDE IRQ handler) does is calling spin_lock_irqsave() which disables
local IRQs (IRQ unmasking is later handled by drive->unmask).

kernel/irq/handle.c:

irqreturn_t handle_IRQ_event(unsigned int irq, struct irqaction *action)
...
	if (!(action->flags & IRQF_DISABLED))
		local_irq_enable_in_hardirq();

	do {
		ret = action->handler(irq, action->dev_id);
		if (ret == IRQ_HANDLED)
			status |= action->flags;
		retval |= ret;
		action = action->next;
	} while (action);
...

drivers/ide/ide-io.c:

irqreturn_t ide_intr (int irq, void *dev_id)
...
	spin_lock_irqsave(&ide_lock, flags);
...
	spin_unlock(&ide_lock);
...
	if (drive->unmask)
		local_irq_enable_in_hardirq();
...

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -974,11 +974,6 @@ static int ide_init_queue(ide_drive_t *d
  * Much of the code is for correctly detecting/handling irq sharing
  * and irq serialization situations.  This is somewhat complex because
  * it handles static as well as dynamic (PCMCIA) IDE interfaces.
- *
- * The IRQF_DISABLED in sa_flags means ide_intr() is always entered with
- * interrupts completely disabled.  This can be bad for interrupt latency,
- * but anything else has led to problems on some machines.  We re-enable
- * interrupts as much as we can safely do in most places.
  */
 static int init_irq (ide_hwif_t *hwif)
 {
@@ -1061,17 +1056,13 @@ static int init_irq (ide_hwif_t *hwif)
 	 * Allocate the irq, if not already obtained for another hwif
 	 */
 	if (!match || match->irq != hwif->irq) {
-		int sa = IRQF_DISABLED;
+		int sa = 0;
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 		sa = IRQF_SHARED;
 #endif /* __mc68000__ || CONFIG_APUS */
 
-		if (IDE_CHIPSET_IS_PCI(hwif->chipset)) {
+		if (IDE_CHIPSET_IS_PCI(hwif->chipset))
 			sa = IRQF_SHARED;
-#ifndef CONFIG_IDEPCI_SHARE_IRQ
-			sa |= IRQF_DISABLED;
-#endif /* CONFIG_IDEPCI_SHARE_IRQ */
-		}
 
 		if (hwif->io_ports[IDE_CONTROL_OFFSET])
 			/* clear nIEN */
