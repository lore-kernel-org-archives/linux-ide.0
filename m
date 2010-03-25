From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] ide: move dcache flushing to generic ide code
Date: Thu, 25 Mar 2010 18:17:15 +0100
Message-ID: <20100325171714.GW4554@linux-mips.org>
References: <1267371341-16684-4-git-send-email-sebastian@breakpoint.cc>
 <20100228.183417.52179576.davem@davemloft.net>
 <20100301195858.GA27906@Chamillionaire.breakpoint.cc>
 <20100301.163959.177031088.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:49754 "EHLO
	eddie.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab0CYRRX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2010 13:17:23 -0400
Received: from localhost.localdomain ([127.0.0.1]:43664 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492580Ab0CYRRW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 25 Mar 2010 18:17:22 +0100
Content-Disposition: inline
In-Reply-To: <20100301.163959.177031088.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: sebastian@breakpoint.cc, linux-mips@linux-mips.org, linux-ide@vger.kernel.org

On Mon, Mar 01, 2010 at 04:39:59PM -0800, David Miller wrote:

> From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> Date: Mon, 1 Mar 2010 20:58:58 +0100
> 
> > The part I don't get is why you have to flush dcache after the copy
> > process. I would understand a flush before reading. The dcache alias in
> > kernel shouldn't hurt since it is not used anymore. Unless we read twice
> > from the same page. Is this the trick?
> 
> Anything that puts the data into the cache on the kernel
> side is a problem.  The page is still potentially in user
> space, as a result there will be thus two active mappings
> in the cache, one in the kernel side and one in the user
> side.  The user can then do various operations which can
> access either mapping.
> 
> Writing to it via write() system call, writing to it via
> mmap(), making the kernel write to it by doing a read()
> with the buffer pointing into the mmap() area.
> 
> All we need is a modification on either side for the other
> one to potentially become stale.
> 
> >>Secondly, IDE is in deep maintainence mode, if you want to optimize
> >>cache flushing do it in the ATA layer.
> > This patch patch was mostly driven by the fact that the buffer can be a
> > normal kernel mapping or a virtual address. The latter doesn't work with
> > virt_to_page().
> > Anyway I should probably spent more time getting ATA layer wokring than
> > on the IDE layer since it is somehow working since patch#1.
> 
> All buffers passed to the architecture IDE ops should be PAGE_OFFSET
> relative kernel virtual addresses for which __pa() works.
> 
> Are kmap()'d things ending up here?
> 
> It all works out on sparc64 because we don't have highmem and
> kernel stacks are just in normal kernel pages.

Highmem on MIPS has always been a bastard child though that will probably
change now that 32-bit embedded systems are coming with more memory than
can be mapped as lowmem.

The system in question that Sebastian is talking about has the IDE cache
problems because it has no aliases.  Neither the IDE code nor the cache
flush layer does any cacheflushes because there are no cache aliases [1] to
deal with.

So eventually code from a page loaded from an IDE disk gets executed and
if the CPU's I-cache refilled from the L2 or memory, not from the D-cache
stale data may get executed.

In an earlier mail in this thread you called the MIPS ins/outs risky.
Maybe - but we have to.  At least at the time when this code was written
the IDE ins/outs variants was possibly being called with interrupts
disabled.  The normal MIPS cache flushing functions are based on
smp_call_function() on SMP systems [2] so can't be used to do cache
maintenance hence we have to avoid them.

  Ralf

[1] Configuring page size to 16k or 64k would get rid of aliases on all
    MIPS processors with VIPT D-caches, so introduce the same situation.
    Such configurations are getting common now.
[2] Because the CACHE instruction only affects the local CPU cache.
