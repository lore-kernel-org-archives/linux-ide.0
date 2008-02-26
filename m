From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Disk shock protection (revisited)
Date: Tue, 26 Feb 2008 12:39:46 +0000
Message-ID: <20080226123946.75dbe3d2@core>
References: <87skzgd1zk.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35344 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751473AbYBZMu2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 07:50:28 -0500
In-Reply-To: <87skzgd1zk.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> The general idea: A daemon running in user space monitors input data
> from an accelerometer. When the daemon detects a critical condition,

That sounds like a non starter. What if the box is busy, what if the
daemon or something you touch needs memory and causes paging ?

Given the accelerometer data should be very simple doesn't it actually
make sense in this specific case to put the logic (not thresholds) in
kernel space.

> state. To this end, the kernel has to issue an idle immediate command
> with unload feature and stop the block layer queue afterwards. Once the

Yep. Pity the worst case completion time for an IDE I/O is 60 seconds or
so.

> 1. Who is to be in charge for the shock protection application? Should
>    userspace speak to libata / ide directly (through sysfs) and the low

I think it has to be kernel side for speed, and because you will need to
issue idle immediate while a command sequence is active which is
*extremely* hairy as you have to recover from the mess and restart the
relevant I/O. Plus you may need controller specific knowledge on issuing
it (and changes to libata).

> 2. Depending on the answer to the previous question, by what mechanism
>    should block layer and lld interact? Special requests, queue hooks or
>    something in some way similar to power management functions (once
>    suggested by James Bottomley)?

Idle immediate seem to simply fit the queue model, it happens in
*parallel* to I/O events and is special in all sorts of ways.

> 3. What is the preferred way to pass device specific configuration
>    options to libata (preferrably at runtime, i.e., after module
>    loading)?

sysfs
