From: Tejun Heo <tj@kernel.org>
Subject: Re: spin_unlock_wait() in ata_scsi_cmd_error_handler()?
Date: Thu, 29 Jun 2017 15:53:22 -0400
Message-ID: <20170629195322.GB9745@htj.duckdns.org>
References: <20170629181057.GA5228@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:34789 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbdF2TxZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jun 2017 15:53:25 -0400
Content-Disposition: inline
In-Reply-To: <20170629181057.GA5228@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Paul.

On Thu, Jun 29, 2017 at 11:10:57AM -0700, Paul E. McKenney wrote:
> If this code fragment doesn't deadlock, then CPU 0's spin_unlock_wait()
> must have executed before CPU 1's spin_lock().  However, even on x86,
> CPU 0's prior writes can be reordered with its subsequent reads, which
> means that r1 == 0 is possible, which means that the above condition
> could hold, even on x86.

I see.  Ah, that's a mind bender.

> One of the uses of spin_unlock_wait() is in ata_scsi_cmd_error_handler()
> in the file drivers/ata/libata-eh.c.  Your commit ad9e27624479b
> ("libata-eh-fw: update ata_scsi_error() for new EH") last touched it,
> though it predates that commit.
> 
> My question to you is whether the code in ata_scsi_cmd_error_handler()
> needs release semantics.  If it does, my recommendation is to replace
> the spin_unlock_wait(ap->lock) with this (adding the needed curly braces,
> of course):
> 
> 	spin_lock(ap->lock);
> 	spin_unlock(ap->lock);
> 
> If the code only needs acquire semantics, no change required.
> 
> If your code requires release semantics, and there is some reason why
> my suggested replacement above is a bad idea, please let me know!

That part of the code should be dead now.  I don't think we no longer
have any driver which doesn't have error handler set.  I should rip
out that if/else.  Also, ACQUIRE semantics should be enough there.
Nothing changes from the EH side there.

Thanks.

-- 
tejun
