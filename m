From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Subject: [tip:core/rcu] drivers/ata: Replace spin_unlock_wait() with
 lock/unlock pair
Date: Mon, 21 Aug 2017 02:14:28 -0700
Message-ID: <tip-a4f08141d0b876407ca4e4b0ae1b2dec35851532@git.kernel.org>
Reply-To: will.deacon@arm.com, peterz@infradead.org,
          parri.andrea@gmail.com, tj@kernel.org,
          linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
          stern@rowland.harvard.edu, linux-ide@vger.kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          mingo@kernel.org, hpa@zytor.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:47265 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbdHUJTI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 21 Aug 2017 05:19:08 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, parri.andrea@gmail.com, tj@kernel.org, will.deacon@arm.com, mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org, tglx@linutronix.de, stern@rowland.harvard.edu, linux-ide@vger.kernel.org

Commit-ID:  a4f08141d0b876407ca4e4b0ae1b2dec35851532
Gitweb:     http://git.kernel.org/tip/a4f08141d0b876407ca4e4b0ae1b2dec35851532
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Thu, 29 Jun 2017 13:10:47 -0700
Committer:  Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CommitDate: Thu, 17 Aug 2017 08:08:58 -0700

drivers/ata: Replace spin_unlock_wait() with lock/unlock pair

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore eliminates the spin_unlock_wait() call and
associated else-clause and hoists the then-clause's lock and unlock out of
the "if" statement.  This should be safe from a performance perspective
because according to Tejun there should be few if any drivers that don't
set their own error handler.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: <linux-ide@vger.kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/ata/libata-eh.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b70bcf6..b325db2 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -645,12 +645,11 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 	 * completions are honored.  A scmd is determined to have
 	 * timed out iff its associated qc is active and not failed.
 	 */
+	spin_lock_irqsave(ap->lock, flags);
 	if (ap->ops->error_handler) {
 		struct scsi_cmnd *scmd, *tmp;
 		int nr_timedout = 0;
 
-		spin_lock_irqsave(ap->lock, flags);
-
 		/* This must occur under the ap->lock as we don't want
 		   a polled recovery to race the real interrupt handler
 
@@ -700,12 +699,11 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 		if (nr_timedout)
 			__ata_port_freeze(ap);
 
-		spin_unlock_irqrestore(ap->lock, flags);
 
 		/* initialize eh_tries */
 		ap->eh_tries = ATA_EH_MAX_TRIES;
-	} else
-		spin_unlock_wait(ap->lock);
+	}
+	spin_unlock_irqrestore(ap->lock, flags);
 
 }
 EXPORT_SYMBOL(ata_scsi_cmd_error_handler);
