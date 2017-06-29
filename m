From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: spin_unlock_wait() in ata_scsi_cmd_error_handler()?
Date: Thu, 29 Jun 2017 13:14:43 -0700
Message-ID: <20170629201443.GD2393@linux.vnet.ibm.com>
References: <20170629181057.GA5228@linux.vnet.ibm.com>
 <20170629195322.GB9745@htj.duckdns.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753458AbdF2UOw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jun 2017 16:14:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5TKDwSF019293
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2017 16:14:47 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bd6t33txb-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2017 16:14:46 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ide@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 29 Jun 2017 16:14:45 -0400
Content-Disposition: inline
In-Reply-To: <20170629195322.GB9745@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 29, 2017 at 03:53:22PM -0400, Tejun Heo wrote:
> Hello, Paul.
> 
> On Thu, Jun 29, 2017 at 11:10:57AM -0700, Paul E. McKenney wrote:
> > If this code fragment doesn't deadlock, then CPU 0's spin_unlock_wait()
> > must have executed before CPU 1's spin_lock().  However, even on x86,
> > CPU 0's prior writes can be reordered with its subsequent reads, which
> > means that r1 == 0 is possible, which means that the above condition
> > could hold, even on x86.
> 
> I see.  Ah, that's a mind bender.

It has indeed been providing at least its share of entertainment over
the past little while.  ;-)

> > One of the uses of spin_unlock_wait() is in ata_scsi_cmd_error_handler()
> > in the file drivers/ata/libata-eh.c.  Your commit ad9e27624479b
> > ("libata-eh-fw: update ata_scsi_error() for new EH") last touched it,
> > though it predates that commit.
> > 
> > My question to you is whether the code in ata_scsi_cmd_error_handler()
> > needs release semantics.  If it does, my recommendation is to replace
> > the spin_unlock_wait(ap->lock) with this (adding the needed curly braces,
> > of course):
> > 
> > 	spin_lock(ap->lock);
> > 	spin_unlock(ap->lock);
> > 
> > If the code only needs acquire semantics, no change required.
> > 
> > If your code requires release semantics, and there is some reason why
> > my suggested replacement above is a bad idea, please let me know!
> 
> That part of the code should be dead now.  I don't think we no longer
> have any driver which doesn't have error handler set.  I should rip
> out that if/else.  Also, ACQUIRE semantics should be enough there.
> Nothing changes from the EH side there.

It looks like we actually might get rid of spin_unlock_wait entirely.
But how about if I just pull the spin_lock_irqsave() before the "if"
and the spin_lock_irqrestore() after the "if"?  Same effect, only
difference is that the "if" and the "ap->eh_tries = ATA_EH_MAX_TRIES"
end up under the lock, and I bet that you won't be able to measure
the difference.  (Please see below.)

I will do this because I just now happened to be editing that file on
my "eradicate spin_unlock_wait()" quest, but can easily rework the
patch as desired.  If you want something different, just let me know!

							Thanx, Paul

------------------------------------------------------------------------

commit 39a15ef3b324b08606953d519e9bc538318f3c15
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Thu Jun 29 13:10:47 2017 -0700

    drivers/ata: Replace spin_unlock_wait() with lock/unlock pair
    
    There is no agreed-upon definition of spin_unlock_wait()'s semantics,
    and it appears that all callers could do just as well with a lock/unlock
    pair.  This commit therefore eliminates the spin_unlock_wait() call and
    associated else-clause and hoists the then-clause's lock and unlock out of
    the "if" statement.  This should be safe from a performance perspective
    because according to Tejun there should be few if any drivers that don't
    set their own error handler.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Tejun Heo <tj@kernel.org>
    Cc: <linux-ide@vger.kernel.org>
    Cc: Will Deacon <will.deacon@arm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Alan Stern <stern@rowland.harvard.edu>
    Cc: Andrea Parri <parri.andrea@gmail.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ef68232b5222..779f6f18c1f4 100644
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

