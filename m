From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Sat, 13 Sep 2008 21:32:26 +0900 (JST)
Message-ID: <20080913.213226.106262199.anemo@mba.ocn.ne.jp>
References: <48CA8BEE.1090305@ru.mvista.com>
	<20080913.005904.07457691.anemo@mba.ocn.ne.jp>
	<48CAA498.9090804@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:52070 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752306AbYIMMcQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Sep 2008 08:32:16 -0400
In-Reply-To: <48CAA498.9090804@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Fri, 12 Sep 2008 21:19:20 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Well, let me explain a bit.  The datasheed say I should wait _both_
> > XFERINT and HOST interrupt.  So, if only one of them was asserted, I
> > mask it and wait another one.  But on the error case, only HOST was
> > asserted and XFERINT was never asserted.  Then I could not exit from
> > "waiting another one" state, until timeout.
> 
>     Hmm, I got it: you decide whether it's worth waiting more for XFEREND 
> interrupt based on whether ERR is set or not. I suppose IDE_INT doesn't get 
> set in case the command gets endede with ERR set?

IIRC, yes.  And anyway, the interrupt signal from this controller to
CPU is not asserted because HOSTINT was masked by int_ctl register to
wait for XFERINT interrupt.

So, regardless of IDE_INT was set or not, no more interrupt raised to
CPU.

Many of strangeness of interrupt handling in this driver is based on
the fact that the IDE_INT bit in DMA status register does not refrect
the controllers interrupt status directly.  And the implementation of
the IDE_INT bit is actually broken.  Claring the IDE_INT bit also
clears all mask bits in int_ctl registers.  Usually this sort of
behaviour is called "bug". ;)

---
Atsushi Nemoto
