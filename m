From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH 2/2] libata: disable preemption during PIO copy
Date: Tue, 23 Mar 2010 12:01:24 +0100
Message-ID: <20100323110124.GA10046@Chamillionaire.breakpoint.cc>
References: <20100321215308.GB27709@Chamillionaire.breakpoint.cc>
 <20100323184836W.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:56980 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751389Ab0CWLBm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Mar 2010 07:01:42 -0400
Content-Disposition: inline
In-Reply-To: <20100323184836W.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

* FUJITA Tomonori | 2010-03-23 18:49:04 [+0900]:

>On Sun, 21 Mar 2010 22:53:08 +0100
>Sebastian Andrzej Siewior <sebastian@breakpoint.cc> wrote:
>
>> If the request has been made in user context it could be moved to a
>> different CPU on a SMP machine between the copy and cache flush. Thus we
>> could flush the dcache on the wrong CPU.
>
>This issue should be addressed in flush_dcache_page() inside?

How so? You have to remain on the same CPU on which you started the copy
process. Once you get to flush_dcache_page() you may have allready
switched the CPU.

Sebastian
