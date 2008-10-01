From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: lockdep warning inside ide/bio
Date: Wed, 01 Oct 2008 13:12:35 -0500
Message-ID: <1222884755.3230.38.camel@localhost.localdomain>
References: <20081001172138.GA17806@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:36352 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753273AbYJASNH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Oct 2008 14:13:07 -0400
In-Reply-To: <20081001172138.GA17806@doriath.ww600.siemens.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

lockdep people cc'd, thread is at

http://marc.info/?l=linux-ide&m=122288193424170

On Wed, 2008-10-01 at 21:21 +0400, Dmitry Baryshkov wrote:
> After 88c381bf09d7b3f2c2e8749150087aff2c434be4 soon after rootfs is
> mounted I'm getting the following lockdep trace (the machine in
> question is my tosa, booted from CF card with ide-cs driver).

I've no idea what a tosa is, but from the traces, I guess it's a VIVT
arm system?

> ------------[ cut here ]------------
> WARNING: at /home/lumag/tosa-tree/kernel/lockdep.c:2195 trace_hardirqs_on_caller+0xf0/0x170()
> Modules linked in:
> [<c0029fe4>] (dump_stack+0x0/0x14) from [<c003fc40>] (warn_on_slowpath+0x4c/0x84)
> [<c003fbf4>] (warn_on_slowpath+0x0/0x84) from [<c00629ac>] (trace_hardirqs_on_caller+0xf0/0x170)
>  r6:c0062a40 r5:00000001 r4:c381b080
> [<c00628bc>] (trace_hardirqs_on_caller+0x0/0x170) from [<c0062a40>] (trace_hardirqs_on+0x14/0x18)
>  r6:00000092 r5:00000000 r4:c3412b30
> [<c0062a2c>] (trace_hardirqs_on+0x0/0x18) from [<c03172b0>] (_spin_unlock_irq+0x30/0x60)
> [<c0317280>] (_spin_unlock_irq+0x0/0x60) from [<c002c3f4>] (__flush_dcache_aliases+0xec/0xf8)
>  r4:c3412b50
> [<c002c308>] (__flush_dcache_aliases+0x0/0xf8) from [<c002c474>] (flush_dcache_page+0x74/0x9c)
> [<c002c400>] (flush_dcache_page+0x0/0x9c) from [<c008f958>] (copy_to_high_bio_irq+0x64/0xb0)
>  r5:c386d668 r4:c3a2b000

OK, so this is the problem and it's coming from within arch/arm.  The
complaint is that we're still running at hardirq context but the
spin_unlock_irq would enable interrupts.

This is because of the definition in asm/cacheflush.h of
flush_dcache_mmap_unlock().

This looks to be a lockdep bug:  IDE interrupts don't have IRQF_DISABLED
set, so they're supposed to be running with interrupts enabled.
However, lockdep actually turns interrupts off anyway and complains
bitterly (in this case) if they get turned on for any reason.

A work around would be to run without lockdep, but I think we really
need lockdep fixing to work properly when IRQF_DISABLED isn't set.

James


