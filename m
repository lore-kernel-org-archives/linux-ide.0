From: Jeff Garzik <jeff@garzik.org>
Subject: Re: cirrus ep93xx pata driver
Date: Mon, 28 May 2007 22:58:59 -0400
Message-ID: <465B96F3.4000609@garzik.org>
References: <44FC0779.9030405@garzik.org> <20060921115533.GA26960@xi.wantstofly.org> <4513B21A.30507@garzik.org> <20070128202117.GA6147@xi.wantstofly.org> <465B816E.5060407@garzik.org> <20070529014859.GB529@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49862 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbXE2C7D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 May 2007 22:59:03 -0400
In-Reply-To: <20070529014859.GB529@xi.wantstofly.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-ide@vger.kernel.org

Lennert Buytenhek wrote:
> On Mon, May 28, 2007 at 09:27:10PM -0400, Jeff Garzik wrote:
> 
>> I know it's probably a low priority, but could you rediff this against 
>> the current libata?
>>
>> I'm wondering where we are in terms of hooks that you need.  Since you 
>> posted this we added some hooks for the pata_scc driver, most notably 
>> ->irq_on() hooks.  And other code you modify, such as the 
>> ata_bus_reset() function, is slated for deletion once all drivers have 
>> been converted over to the new EH (done, in testing).
> 
> The main problem on ep93xx is that the IDE registers aren't accessible
> via memory space or I/O space reads/writes -- instead, you get to put
> the address/data on the bus by hand, twiddle the nRD/nWR lines by hand,
> enforcing PIO timings as you go along by manually delaying for the right
> number of nanoseconds, etc.

Nod, your patch explained that :)


> The libata methods I added hooks for were all methods that check
> ATA_FLAG_MMIO and do {read,write}[bwl] or {in,out}[bwl] accesses
> based on the state of that flag.  What I did in those cases was to
> verbatim cut-'n-paste the libata code into pata_ep93xx, changing
> the {read,write,in,out}[bwl] calls into calls to pata_ep93xx's
> accessor functions.  Of course, this is ugly, duplicates code, and
> will break whenever someone adds new code to libata that accesses
> the task file registers directly.

Well, judging solely from the patch you sent, it looks like we already 
have the necessary hooks for everything you need.  After reviewing each 
modification, ata_devchk() appeared to be the only function that did not 
have a directly corresponding hook.  Several of your modifications were 
to old-EH functions that your driver never calls, etc.

So if you could refresh the patch from Jan 28th, I bet recent API 
improvements can get it into upstream-mergeable shape, without having to 
create low-level IO accessor hooks.

	Jeff


