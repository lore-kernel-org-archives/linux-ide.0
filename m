From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Sat, 1 Nov 2008 17:09:30 +0100
Message-ID: <20081101160930.GA10321@nuty>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org> <490A4156.5080302@ru.mvista.com> <20081031000912.GB10620@nuty> <490AE023.9040906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:51875 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbYKAQIX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Nov 2008 12:08:23 -0400
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id CDA6B386DBBE
	for <linux-ide@vger.kernel.org>; Sat,  1 Nov 2008 17:08:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <490AE023.9040906@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

On Fri, Oct 31, 2008 at 01:38:27PM +0300, Sergei Shtylyov wrote:
> >The original driver (see my patch) accesses 0x80D to read error codes,
> >so I assumed this is correct. Indeed, the driver works also with the
> >standard setting. Is there a way I can clearly verify which is the right
> >offset?
> >  
> 
>   I assume you don't have the documentation? I wodner why they needed 
> to duplicate (or remap) this register...

Sadly not. All I have is the specification of the SoC by IDT, but the
CompactFlash slot was added by Mikrotik, so it's not mentioned in there.
The routerboard user's manual Mikrotik has published doesn't contain
much more information about it than "it's there".

>   No. The alternatives would be to use local variable as a loop counter 
> or, better yet, using readsb()/writesb() instead of the loops...
> Wait! The original driver used 32-bit I/O to this register, not 8-bit -- 
> so it looks like you have artificially slowed it down... :-/

Ok, so this should be clear now. I changed the code to use readl() and
writel() (the reads*() and writes*() versions sadly aren't useable as
they increment the target memory pointer) which worked fine.

When it comes to the register offsets I'd say in dubio pro reo and keep
the custom error address. Changing it afterwards to the standard should
also be much easier than fiddling out what the custom offset was again.

I'll reply to this mail with an updated patch addressing all discussed
problems.

Greetings and many thanks, Phil
