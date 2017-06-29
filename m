From: Tejun Heo <tj@kernel.org>
Subject: Re: spin_unlock_wait() in ata_scsi_cmd_error_handler()?
Date: Thu, 29 Jun 2017 16:17:54 -0400
Message-ID: <20170629201754.GC9745@htj.duckdns.org>
References: <20170629181057.GA5228@linux.vnet.ibm.com>
 <20170629195322.GB9745@htj.duckdns.org>
 <20170629201443.GD2393@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170629201443.GD2393@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Thu, Jun 29, 2017 at 01:14:43PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 29, 2017 at 03:53:22PM -0400, Tejun Heo wrote:
> > Hello, Paul.
> > 
> > On Thu, Jun 29, 2017 at 11:10:57AM -0700, Paul E. McKenney wrote:
> > > If this code fragment doesn't deadlock, then CPU 0's spin_unlock_wait()
> > > must have executed before CPU 1's spin_lock().  However, even on x86,
> > > CPU 0's prior writes can be reordered with its subsequent reads, which
> > > means that r1 == 0 is possible, which means that the above condition
> > > could hold, even on x86.
> > 
> > I see.  Ah, that's a mind bender.
> 
> It has indeed been providing at least its share of entertainment over
> the past little while.  ;-)

lol :)

> > That part of the code should be dead now.  I don't think we no longer
> > have any driver which doesn't have error handler set.  I should rip
> > out that if/else.  Also, ACQUIRE semantics should be enough there.
> > Nothing changes from the EH side there.
> 
> It looks like we actually might get rid of spin_unlock_wait entirely.
> But how about if I just pull the spin_lock_irqsave() before the "if"
> and the spin_lock_irqrestore() after the "if"?  Same effect, only
> difference is that the "if" and the "ap->eh_tries = ATA_EH_MAX_TRIES"
> end up under the lock, and I bet that you won't be able to measure
> the difference.  (Please see below.)
> 
> I will do this because I just now happened to be editing that file on
> my "eradicate spin_unlock_wait()" quest, but can easily rework the
> patch as desired.  If you want something different, just let me know!

Sounds good to me.  That path isn't hot at all.  No change made at
this level is gonna have any actual impact.  Please go for whatever is
the simplest.  For moving out the lock/unlock outside if/else,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
