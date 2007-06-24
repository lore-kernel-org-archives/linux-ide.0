From: Thanos Kyritsis <djart@linux.gr>
Subject: Re: [PROBLEM]: hdparm strange behaviour for 2.6.21 and later
Date: Sun, 24 Jun 2007 20:47:13 +0300
Message-ID: <200706242047.13466.djart@linux.gr>
References: <200706161958.05313.djart@linux.gr> <200706201807.41646.djart@linux.gr> <200706232028.58193.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rosebud.otenet.gr ([195.170.0.94]:40145 "EHLO rosebud.otenet.gr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbXFXRsy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Jun 2007 13:48:54 -0400
In-Reply-To: <200706232028.58193.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Saturday 23 June 2007, Bartlomiej Zolnierkiewicz wrote:
> Hi,

Hello, thanks for answering :-D


> Also could you try running UP kernel without PREEMPT and see
> if it makes difference?

Yes, it did make a difference. I've just tried both UP and SMP kernels 
(22-rc5) *without* PREEMPT. Neither of these locked!

I also tried UP with PREEMPT and it locks.

> Adding a couple of printk-s to ide.c::set_using_dma() and
> ide.c::ide_spin_wait_hwgroup() will for sure help in debugging
> it further.

I just tried that as well. I placed printk-s when entering and exiting 
these 2 functions and when they use spin_lock_irq() and 
spin_unlock_irq(), and then watched the output:

I didn't see something odd. For every hdparm execution, set_using_dma() 
is called, it successfully calls ide_spin_wait_hwgroup(), then 
set_using_dma() finishes.
After set_using_dma() finishes, one more ide_spin_wait_hwgroup() 
is called and finishes.

This pattern happens always, no matter if the kernel will eventually 
lock (preempt) or not lock (no preempt), with absolutely no 
differences. 

entering ide.c::set_using_dma()
|
  entering ide.c::ide_spin_wait_hwgroup()
    ide.c::ide_spin_wait_hwgroup: LOCK
  exiting ide.c::ide_spin_wait_hwgroup()
|
ide.c::set_using_dma: set ->busy flag, unlock and let it ride
ide.c::set_using_dma: UNLOCK
ide.c::set_using_dma: lock, clear ->busy flag and unlock before leaving
ide.c::set_using_dma: LOCK
ide.c::set_using_dma: UNLOCK
|
exiting ide.c::set_using_dma()

entering ide.c::ide_spin_wait_hwgroup()
ide.c::ide_spin_wait_hwgroup: LOCK
exiting ide.c::ide_spin_wait_hwgroup()

The above gets printed twice (one for the hda hdparm and one for hdb).

But I noticed something extra. 

Sometimes, the ide_spin_wait_hwgroup() that runs either before the 1st 
set_using_dma() or between the 1st and the 2nd (1st for hda, 2nd for 
hdb) (*but never the one called last*) is waiting A LOT inside the busy 
loop (while (hwgroup->busy)).

I think PREEMPT kernels always produce a lot of this while loop output, 
and then print the above pattern, then lock.

Non-PREEMPT kernels don't always produce the huge while loop output, 
only sometimes, but they never have locking problem.
I don't know if this is at all relevant to the problem. Perhaps it's 
normal that during some of the bootups the IDE device group is busy 
while during other bootups it's not busy, right ?


However, since all functions exit properly, should I try to place 
printk-s in other functions as well ? 

(I kind of need and appreciate guideance in order to help you, because 
I've never been in the kernel hacking business before :) )

> Thanks,
> Bart


-- 
Thanos Kyritsis <djart at linux.gr>

- What's your ONE purpose in life ?
- To explode, of course! ;-)
