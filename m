From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/13] libata: implement ata_port_freeze()
Date: Mon, 3 Apr 2006 03:31:09 +0900
Message-ID: <1144002669426-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:32415 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750894AbWDBSbP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:15 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550556nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:14 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Freezing is performed atomic w.r.t. host_set->lock and once frozen
LLDD is not allowed to access the port or any qc on it.  Also, libata
makes sure that no new qc gets issued to a frozen port.

A frozen port is thawed after a reset operation completes
successfully, so reset methods must do its job while the port is
frozen.  During initialization all ports get frozen before requesting
IRQ, so reset methods are always invoked on a frozen port.

Optional ->freeze operation notifies LLDD that the port is being
frozen.  LLDD can disable hardware interrupt in this callback if the
controller's IRQ mask can be changed dynamically.  If the controller
doesn't allow such operation, LLDD can check for frozen state in the
interrupt handler and ack/clear interrupts unconditionally while
frozen.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   50 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata.h      |    1 +
 2 files changed, 51 insertions(+), 0 deletions(-)

9f3913439575c8e389f3bc3d1878fdfb0f2f90cc
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 446ab53..69a069f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -988,6 +988,12 @@ unsigned ata_exec_internal(struct ata_po
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
+	/* no internal command while frozen */
+	if (ap->flags & ATA_FLAG_FROZEN) {
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		return AC_ERR_SYSTEM;
+	}
+
 	/* initialize internal qc */
 
 	/* XXX: Tag 0 is used for drivers with legacy EH as some
@@ -1659,6 +1665,39 @@ void ata_port_disable(struct ata_port *a
 }
 
 /**
+ *	ata_port_freeze - freeze port until reset thaws it
+ *	@ap: ATA port to freeze
+ *
+ *	This function is called when HSM violation or some other
+ *	condition disrupts normal operation of the port.  Frozen port
+ *	is not allowed to perform any operation until a reset puts it
+ *	into known state and thaws it.
+ *
+ *	ap->ops->freeze() callback can be used for freezing the port
+ *	hardware-wise (e.g. mask interrupt / stop DMA engine).  If a
+ *	port cannot be frozen hardware-wise, the interrupt handler
+ *	must ack and clear interrupts unconditionally while the port
+ *	is frozen.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_port_freeze(struct ata_port *ap)
+{
+	if (!ap->ops->error_handler)
+		return;
+
+	WARN_ON(ap->flags & ATA_FLAG_FROZEN);
+
+	if (ap->ops->freeze)
+		ap->ops->freeze(ap);
+
+	ap->flags |= ATA_FLAG_FROZEN;
+
+	DPRINTK("ata%u port frozen\n", ap->id);
+}
+
+/**
  *	ata_down_sata_spd_limit - adjust SATA spd limit downward
  *	@ap: Port to adjust SATA spd limit for
  *
@@ -2617,6 +2656,7 @@ int ata_do_reset(struct ata_port *ap,
 		 ata_reset_fn_t reset, ata_postreset_fn_t postreset,
 		 int verbose, unsigned int *classes)
 {
+	unsigned long flags;
 	int i, rc;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
@@ -2626,6 +2666,11 @@ int ata_do_reset(struct ata_port *ap,
 	if (rc)
 		return rc;
 
+	/* a successful reset thaws the port */
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->flags &= ~ATA_FLAG_FROZEN;
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
 	/* If any class isn't ATA_DEV_UNKNOWN, consider classification
 	 * is complete and convert all ATA_DEV_UNKNOWN to
 	 * ATA_DEV_NONE.
@@ -4052,6 +4097,10 @@ static struct ata_queued_cmd *ata_qc_new
 	struct ata_queued_cmd *qc = NULL;
 	unsigned int i;
 
+	/* no command while frozen */
+	if (unlikely(ap->flags & ATA_FLAG_FROZEN))
+		return NULL;
+
 	/* the last tag is reserved for internal command. */
 	for (i = 0; i < ATA_MAX_QUEUE - 1; i++)
 		if (!test_and_set_bit(i, &ap->qactive)) {
@@ -4764,6 +4813,7 @@ int ata_device_add(const struct ata_prob
 
 		ata_chk_status(ap);
 		host_set->ops->irq_clear(ap);
+		ata_port_freeze(ap);
 		count++;
 	}
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 31efc2e..681b203 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -50,6 +50,7 @@ extern void ata_port_flush_task(struct a
 extern unsigned ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen);
+extern void ata_port_freeze(struct ata_port *ap);
 extern int ata_down_sata_spd_limit(struct ata_port *ap);
 extern int ata_set_sata_spd_needed(struct ata_port *ap);
 extern int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
-- 
1.2.4


