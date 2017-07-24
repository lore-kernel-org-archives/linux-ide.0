From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 7/9] drivers/ata: Replace spin_unlock_wait() with lock/unlock pair
Date: Mon, 24 Jul 2017 15:13:07 -0700
Message-ID: <1500934389-14942-7-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20170724221252.GA14238@linux.vnet.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932304AbdGXWNR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jul 2017 18:13:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6OMCttt031703
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2017 18:13:17 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bwp0vrmx5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-ide@vger.kernel.org>; Mon, 24 Jul 2017 18:13:16 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ide@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 24 Jul 2017 18:13:15 -0400
In-Reply-To: <20170724221252.GA14238@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-ide@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

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
index b70bcf6d2914..b325db27eb8c 100644
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
-- 
2.5.2

