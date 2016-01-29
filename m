From: Tejun Heo <tj@kernel.org>
Subject: Re: ata: BUG in ata_sff_hsm_move
Date: Fri, 29 Jan 2016 15:23:48 -0500
Message-ID: <20160129202348.GA4534@mtj.duckdns.org>
References: <CACT4Y+b_JsOxJu2EZyEf+mOXORc_zid5V1-pLZSroJVxyWdSpw@mail.gmail.com>
 <20160129115214.GM32380@htj.duckdns.org>
 <CACT4Y+Y_w3msrTw46T8wGpK-j09e6VAoPFa93JSfm+5_kvBAYQ@mail.gmail.com>
 <20160129122317.GO32380@htj.duckdns.org>
 <CACT4Y+Z5SPCKg0bMC2sD-VbCfJPOixzntb+-zfWcU5jufjygmw@mail.gmail.com>
 <CACT4Y+axb-FagKnftWDkOynT8xWoqOw758Q9t_Whs-bZPqU1Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33810 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbcA2UXv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2016 15:23:51 -0500
Content-Disposition: inline
In-Reply-To: <CACT4Y+axb-FagKnftWDkOynT8xWoqOw758Q9t_Whs-bZPqU1Xg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzkaller <syzkaller@googlegroups.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@redhat.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>

Hello,

On Fri, Jan 29, 2016 at 02:40:33PM +0100, Dmitry Vyukov wrote:
> It now deadlocks at this stack. It is probably not OK to call
> ata_sff_hsm_move holding the spinlock.

Yeah, the locking is pretty messed up with the polling path.  Can you
please try the following?

Thanks.

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index cdf6215..7dbba38 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -997,12 +997,9 @@ static inline int ata_hsm_ok_in_wq(struct ata_port *ap,
 static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned long flags;
 
 	if (ap->ops->error_handler) {
 		if (in_wq) {
-			spin_lock_irqsave(ap->lock, flags);
-
 			/* EH might have kicked in while host lock is
 			 * released.
 			 */
@@ -1014,8 +1011,6 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 				} else
 					ata_port_freeze(ap);
 			}
-
-			spin_unlock_irqrestore(ap->lock, flags);
 		} else {
 			if (likely(!(qc->err_mask & AC_ERR_HSM)))
 				ata_qc_complete(qc);
@@ -1024,10 +1019,8 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 		}
 	} else {
 		if (in_wq) {
-			spin_lock_irqsave(ap->lock, flags);
 			ata_sff_irq_on(ap);
 			ata_qc_complete(qc);
-			spin_unlock_irqrestore(ap->lock, flags);
 		} else
 			ata_qc_complete(qc);
 	}
@@ -1048,9 +1041,10 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 {
 	struct ata_link *link = qc->dev->link;
 	struct ata_eh_info *ehi = &link->eh_info;
-	unsigned long flags = 0;
 	int poll_next;
 
+	lockdep_assert_held(ap->lock);
+
 	WARN_ON_ONCE((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
 
 	/* Make sure ata_sff_qc_issue() does not throw things
@@ -1112,14 +1106,6 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 			}
 		}
 
-		/* Send the CDB (atapi) or the first data block (ata pio out).
-		 * During the state transition, interrupt handler shouldn't
-		 * be invoked before the data transfer is complete and
-		 * hsm_task_state is changed. Hence, the following locking.
-		 */
-		if (in_wq)
-			spin_lock_irqsave(ap->lock, flags);
-
 		if (qc->tf.protocol == ATA_PROT_PIO) {
 			/* PIO data out protocol.
 			 * send first data block.
@@ -1135,9 +1121,6 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 			/* send CDB */
 			atapi_send_cdb(ap, qc);
 
-		if (in_wq)
-			spin_unlock_irqrestore(ap->lock, flags);
-
 		/* if polling, ata_sff_pio_task() handles the rest.
 		 * otherwise, interrupt handler takes over from here.
 		 */
@@ -1361,12 +1344,14 @@ static void ata_sff_pio_task(struct work_struct *work)
 	u8 status;
 	int poll_next;
 
+	spin_lock_irq(ap->lock);
+
 	BUG_ON(ap->sff_pio_task_link == NULL);
 	/* qc can be NULL if timeout occurred */
 	qc = ata_qc_from_tag(ap, link->active_tag);
 	if (!qc) {
 		ap->sff_pio_task_link = NULL;
-		return;
+		goto out_unlock;
 	}
 
 fsm_start:
@@ -1381,11 +1366,14 @@ static void ata_sff_pio_task(struct work_struct *work)
 	 */
 	status = ata_sff_busy_wait(ap, ATA_BUSY, 5);
 	if (status & ATA_BUSY) {
+		spin_unlock_irq(ap->lock);
 		ata_msleep(ap, 2);
+		spin_lock_irq(ap->lock);
+
 		status = ata_sff_busy_wait(ap, ATA_BUSY, 10);
 		if (status & ATA_BUSY) {
 			ata_sff_queue_pio_task(link, ATA_SHORT_PAUSE);
-			return;
+			goto out_unlock;
 		}
 	}
 
@@ -1402,6 +1390,8 @@ static void ata_sff_pio_task(struct work_struct *work)
 	 */
 	if (poll_next)
 		goto fsm_start;
+out_unlock:
+	spin_unlock_irq(ap->lock);
 }
 
 /**
