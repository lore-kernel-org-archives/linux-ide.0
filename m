From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: move ata_irq_on() into libata-sff.c
Date: Mon, 9 Oct 2006 11:10:26 +0900
Message-ID: <20061009021026.GA10832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:21444 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751623AbWJICKi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Oct 2006 22:10:38 -0400
Received: by py-out-1112.google.com with SMTP id n25so2124656pyg
        for <linux-ide@vger.kernel.org>; Sun, 08 Oct 2006 19:10:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

ata_irq_on() isn't used outside of libata core layer.  The function is
TF/SFF interface specific but currently used by core path with some
hack too.  Move it from include/linux/libata.h to
drivers/ata/libata-sff.c.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-sff.c |   29 +++++++++++++++++++++++++++++
 drivers/ata/libata.h     |    3 +++
 include/linux/libata.h   |   31 -------------------------------
 3 files changed, 32 insertions(+), 31 deletions(-)

Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c
+++ work/drivers/ata/libata-sff.c
@@ -39,6 +39,35 @@
 #include "libata.h"
 
 /**
+ *	ata_irq_on - Enable interrupts on a port.
+ *	@ap: Port on which interrupts are enabled.
+ *
+ *	Enable interrupts on a legacy IDE device using MMIO or PIO,
+ *	wait for idle, clear any pending interrupts.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+u8 ata_irq_on(struct ata_port *ap)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 tmp;
+
+	ap->ctl &= ~ATA_NIEN;
+	ap->last_ctl = ap->ctl;
+
+	if (ap->flags & ATA_FLAG_MMIO)
+		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
+	else
+		outb(ap->ctl, ioaddr->ctl_addr);
+	tmp = ata_wait_idle(ap);
+
+	ap->ops->irq_clear(ap);
+
+	return tmp;
+}
+
+/**
  *	ata_tf_load_pio - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
Index: work/drivers/ata/libata.h
===================================================================
--- work.orig/drivers/ata/libata.h
+++ work/drivers/ata/libata.h
@@ -119,4 +119,7 @@ extern void ata_scsi_error(struct Scsi_H
 extern void ata_port_wait_eh(struct ata_port *ap);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
 
+/* libata-sff.c */
+extern u8 ata_irq_on(struct ata_port *ap);
+
 #endif /* __LIBATA_H__ */
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -1148,37 +1148,6 @@ static inline void ata_qc_reinit(struct 
 }
 
 /**
- *	ata_irq_on - Enable interrupts on a port.
- *	@ap: Port on which interrupts are enabled.
- *
- *	Enable interrupts on a legacy IDE device using MMIO or PIO,
- *	wait for idle, clear any pending interrupts.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static inline u8 ata_irq_on(struct ata_port *ap)
-{
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	u8 tmp;
-
-	ap->ctl &= ~ATA_NIEN;
-	ap->last_ctl = ap->ctl;
-
-	if (ap->flags & ATA_FLAG_MMIO)
-		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-	else
-		outb(ap->ctl, ioaddr->ctl_addr);
-	tmp = ata_wait_idle(ap);
-
-	ap->ops->irq_clear(ap);
-
-	return tmp;
-}
-
-
-/**
  *	ata_irq_ack - Acknowledge a device interrupt.
  *	@ap: Port on which interrupts are enabled.
  *
