From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH 2/2] libata: disable preemption during PIO copy
Date: Tue, 23 Mar 2010 20:51:34 +0900
Message-ID: <20100323205030G.fujita.tomonori@lab.ntt.co.jp>
References: <20100321215308.GB27709@Chamillionaire.breakpoint.cc>
	<20100323184836W.fujita.tomonori@lab.ntt.co.jp>
	<20100323110124.GA10046@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:43377 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab0CWLwP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Mar 2010 07:52:15 -0400
In-Reply-To: <20100323110124.GA10046@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian@breakpoint.cc
Cc: fujita.tomonori@lab.ntt.co.jp, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, 23 Mar 2010 12:01:24 +0100
Sebastian Andrzej Siewior <sebastian@breakpoint.cc> wrote:

> * FUJITA Tomonori | 2010-03-23 18:49:04 [+0900]:
> 
> >On Sun, 21 Mar 2010 22:53:08 +0100
> >Sebastian Andrzej Siewior <sebastian@breakpoint.cc> wrote:
> >
> >> If the request has been made in user context it could be moved to a
> >> different CPU on a SMP machine between the copy and cache flush. Thus we
> >> could flush the dcache on the wrong CPU.
> >
> >This issue should be addressed in flush_dcache_page() inside?
> 
> How so? You have to remain on the same CPU on which you started the copy
> process. Once you get to flush_dcache_page() you may have allready
> switched the CPU.

Oops, I thought that you trying to address on the deferred
flush_dcache_page() issue. I don't know enough about how this pio code
works, but if your description is correct, then the patch is fine, I
guess.
