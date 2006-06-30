From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] ide_end_drive_cmd(): avoid instruction pipeline
 stall
Date: Fri, 30 Jun 2006 11:00:18 -0700
Message-ID: <20060630110018.f45b40e2.akpm@osdl.org>
References: <20060630161351.GA17434@rhlx01.fht-esslingen.de>
	<1151688416.31392.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:55479 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751837AbWF3SAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2006 14:00:35 -0400
In-Reply-To: <1151688416.31392.66.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andi@rhlx01.fht-esslingen.de, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 18:26:56 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Gwe, 2006-06-30 am 18:13 +0200, ysgrifennodd Andreas Mohr:
> > Use an independently-formatted "unsigned int" for data instead of a
> > restrictive "u16" to avoid instruction fetch pipeline stalls
> > probably caused by the byte calculations later.
> 
> drivers/ide is on its way out.

Like sound/oss ;)

> I'm also curious that this shows up given
> that the inw() is going to cause a PCI sequence and stall the CPU
> entirely for ages anyway.

I guess because he was profiling for IFU_MEM_STALL, not for wall-time.

> NAK because
> 1. This is a gcc problem
> 2. Not everyone is using an intel x86-32 box which has such problems
> 3. IDE is in life-support mode and the relatives are already planning
> the flowers.

Well.  If the patch breaks anything we can dine on hats for a month.  Seems
pretty inoffensive to me.

