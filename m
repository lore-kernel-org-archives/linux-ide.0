From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: cirrus ep93xx pata driver
Date: Tue, 29 May 2007 03:48:59 +0200
Message-ID: <20070529014859.GB529@xi.wantstofly.org>
References: <44FC0779.9030405@garzik.org> <20060921115533.GA26960@xi.wantstofly.org> <4513B21A.30507@garzik.org> <20070128202117.GA6147@xi.wantstofly.org> <465B816E.5060407@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:50986 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbXE2CQZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 May 2007 22:16:25 -0400
Content-Disposition: inline
In-Reply-To: <465B816E.5060407@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Mon, May 28, 2007 at 09:27:10PM -0400, Jeff Garzik wrote:

> I know it's probably a low priority, but could you rediff this against 
> the current libata?
> 
> I'm wondering where we are in terms of hooks that you need.  Since you 
> posted this we added some hooks for the pata_scc driver, most notably 
> ->irq_on() hooks.  And other code you modify, such as the 
> ata_bus_reset() function, is slated for deletion once all drivers have 
> been converted over to the new EH (done, in testing).

The main problem on ep93xx is that the IDE registers aren't accessible
via memory space or I/O space reads/writes -- instead, you get to put
the address/data on the bus by hand, twiddle the nRD/nWR lines by hand,
enforcing PIO timings as you go along by manually delaying for the right
number of nanoseconds, etc.

The libata methods I added hooks for were all methods that check
ATA_FLAG_MMIO and do {read,write}[bwl] or {in,out}[bwl] accesses
based on the state of that flag.  What I did in those cases was to
verbatim cut-'n-paste the libata code into pata_ep93xx, changing
the {read,write,in,out}[bwl] calls into calls to pata_ep93xx's
accessor functions.  Of course, this is ugly, duplicates code, and
will break whenever someone adds new code to libata that accesses
the task file registers directly.

I did hack up the pata_ep93xx patch to add a third method,
ATA_FLAG_FITH, and call the appropriate port-specific accessor
functions via a pair of extra ops in ata_port_operations.  However,
I didn't really think that that was an upstream-mergeable solution.

(Although if we define ATA_FLAG_FITH to 0 so that all tests against
it will fail at compile time if there are no FITH drivers compiled
in or compiled as modules might make it not suck too hard.. but it's
still ugly.)
