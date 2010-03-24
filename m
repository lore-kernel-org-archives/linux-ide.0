From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH 2/2] libata: disable preemption during PIO copy
Date: Wed, 24 Mar 2010 22:52:01 +0100
Message-ID: <20100324215201.GC22847@Chamillionaire.breakpoint.cc>
References: <20100321215308.GB27709@Chamillionaire.breakpoint.cc>
 <20100323184836W.fujita.tomonori@lab.ntt.co.jp>
 <20100323110124.GA10046@Chamillionaire.breakpoint.cc>
 <20100323205030G.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:34161 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750739Ab0CXVwI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Mar 2010 17:52:08 -0400
Content-Disposition: inline
In-Reply-To: <20100323205030G.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: sebastian@breakpoint.cc, jgarzik@pobox.com, linux-ide@vger.kernel.org

* FUJITA Tomonori | 2010-03-23 20:51:34 [+0900]:

>> How so? You have to remain on the same CPU on which you started the copy
>> process. Once you get to flush_dcache_page() you may have allready
>> switched the CPU.
>
>Oops, I thought that you trying to address on the deferred
>flush_dcache_page() issue. I don't know enough about how this pio code
>works, but if your description is correct, then the patch is fine, I
>guess.

No, it is not. The dcache flush is a global one so a CPU switch does not
matter. So I NAK that one myself.

Sebastian
