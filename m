From: Kirill Tkhai <tkhai@yandex.ru>
Subject: [PATCH] ata_port_wait_eh(): Change irqsave into unconditional closing of interrupts
Date: Thu, 26 Sep 2013 17:21:19 +0400
Message-ID: <1491380201679@web5j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from forward12.mail.yandex.net ([95.108.130.94]:48666 "EHLO
	forward12.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab3IZN14 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Sep 2013 09:27:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi,

ata_port_wait_eh() uses spin_lock_irqsave() and this can confuse in fact
that it is suitable to use in irqs_disabled() context. But we can't.

(schedule() returns with interrupts enabled so it's possible
ata_port_wait_eh() enters with disabled interrupts but returns with enabled)

So, replace irqsave to unconditional closing of interrupts.

I propose to consider to add patch like this. (If you don't have a magic
with flags which is not obvious for me :)

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
---
 drivers/ata/libata-eh.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c69fcce..502c1f9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -841,21 +841,20 @@ EXPORT_SYMBOL_GPL(ata_scsi_port_error_handler);
  */
 void ata_port_wait_eh(struct ata_port *ap)
 {
-	unsigned long flags;
 	DEFINE_WAIT(wait);
 
  retry:
-	spin_lock_irqsave(ap->lock, flags);
+	spin_lock_irq(ap->lock);
 
 	while (ap->pflags & (ATA_PFLAG_EH_PENDING | ATA_PFLAG_EH_IN_PROGRESS)) {
 		prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
-		spin_unlock_irqrestore(ap->lock, flags);
+		spin_unlock_irq(ap->lock);
 		schedule();
-		spin_lock_irqsave(ap->lock, flags);
+		spin_lock_irq(ap->lock);
 	}
 	finish_wait(&ap->eh_wait_q, &wait);
 
-	spin_unlock_irqrestore(ap->lock, flags);
+	spin_unlock_irq(ap->lock);
 
 	/* make sure SCSI EH is complete */
 	if (scsi_host_in_recovery(ap->scsi_host)) {
