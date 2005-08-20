From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 01/02] atapi: update ata_irq_on
Date: Sat, 20 Aug 2005 18:17:27 +0900 (KST)
Message-ID: <20050820091651.B8D48034@htj.dyndns.org>
References: <20050820091651.486821E0@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.198]:61213 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751078AbVHTJRd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 05:17:33 -0400
Received: by rproxy.gmail.com with SMTP id r35so684795rna
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2005 02:17:32 -0700 (PDT)
In-Reply-To: <20050820091651.486821E0@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com
Cc: linux-ide@vger.kernel.org

01_atapi_update-ata_irq_on.patch

	Update ata_irq_on for atapi_packet_task fix.  Changes are

	* IRQ is cleared _before_ unmasking interrupt.  This is
	  necessary as unmasking could raise a pending interrupt
	  which should have been ignored.

	* IRQ is cleared using both ata_chk_status and
          ap->ops->irq_clear.

	* ap->ctl value represents default ctl value and never gets
	  modified.  ap->last_ctl is the currently loaded ctl value.
	  Don't turn off ATA_NIEN on ap->ctl as the bit never gets set
	  on it.  Directly modify ap->last_ctl.

	* Don't do ata_wait_idle.  All current callers don't need it.
	  And it will always time out when used in atapi_packet_task.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 libata.h |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-08-20 18:12:30.000000000 +0900
+++ work/include/linux/libata.h	2005-08-20 18:16:49.000000000 +0900
@@ -565,30 +565,32 @@ static inline void ata_tf_init(struct at
  *	ata_irq_on - Enable interrupts on a port.
  *	@ap: Port on which interrupts are enabled.
  *
- *	Enable interrupts on a legacy IDE device using MMIO or PIO,
- *	wait for idle, clear any pending interrupts.
+ *	Clear pending interrupts and enable interrupts on a legacy IDE
+ *	device using MMIO or PIO.
  *
  *	LOCKING:
  *	Inherited from caller.
  */
 
-static inline u8 ata_irq_on(struct ata_port *ap)
+static inline void ata_irq_on(struct ata_port *ap)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
 
-	ap->ctl &= ~ATA_NIEN;
-	ap->last_ctl = ap->ctl;
+	/* Clear pending interrupts. */
+	ata_chk_status(ap);
+	ap->ops->irq_clear(ap);
 
-	if (ap->flags & ATA_FLAG_MMIO)
-		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-	else
-		outb(ap->ctl, ioaddr->ctl_addr);
-	tmp = ata_wait_idle(ap);
+	ap->last_ctl &= ATA_NIEN;
 
-	ap->ops->irq_clear(ap);
+	/* smp_wmb() is here to make sure that other processors see
+	 * ATA_NIEN cleared on receiving interrupts.
+	 */
+	smp_wmb();
 
-	return tmp;
+	if (ap->flags & ATA_FLAG_MMIO)
+		writeb(ap->last_ctl, (void __iomem *) ioaddr->ctl_addr);
+	else
+		outb(ap->last_ctl, ioaddr->ctl_addr);
 }
 
 

