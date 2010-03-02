From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/3] ide: move dcache flushing to generic ide code
Date: Mon, 01 Mar 2010 16:39:59 -0800 (PST)
Message-ID: <20100301.163959.177031088.davem@davemloft.net>
References: <1267371341-16684-4-git-send-email-sebastian@breakpoint.cc>
	<20100228.183417.52179576.davem@davemloft.net>
	<20100301195858.GA27906@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36568
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751792Ab0CBAjk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Mar 2010 19:39:40 -0500
In-Reply-To: <20100301195858.GA27906@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian@breakpoint.cc
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org, linux-ide@vger.kernel.org

From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Date: Mon, 1 Mar 2010 20:58:58 +0100

> The part I don't get is why you have to flush dcache after the copy
> process. I would understand a flush before reading. The dcache alias in
> kernel shouldn't hurt since it is not used anymore. Unless we read twice
> from the same page. Is this the trick?

Anything that puts the data into the cache on the kernel
side is a problem.  The page is still potentially in user
space, as a result there will be thus two active mappings
in the cache, one in the kernel side and one in the user
side.  The user can then do various operations which can
access either mapping.

Writing to it via write() system call, writing to it via
mmap(), making the kernel write to it by doing a read()
with the buffer pointing into the mmap() area.

All we need is a modification on either side for the other
one to potentially become stale.

>>Secondly, IDE is in deep maintainence mode, if you want to optimize
>>cache flushing do it in the ATA layer.
> This patch patch was mostly driven by the fact that the buffer can be a
> normal kernel mapping or a virtual address. The latter doesn't work with
> virt_to_page().
> Anyway I should probably spent more time getting ATA layer wokring than
> on the IDE layer since it is somehow working since patch#1.

All buffers passed to the architecture IDE ops should be PAGE_OFFSET
relative kernel virtual addresses for which __pa() works.

Are kmap()'d things ending up here?

It all works out on sparc64 because we don't have highmem and
kernel stacks are just in normal kernel pages.
