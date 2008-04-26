From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv performance; impact of NCQ
Date: Sat, 26 Apr 2008 00:49:01 -0400
Message-ID: <4812B43D.2040401@rtr.ca>
References: <20080426001657.GD17369@modernduck.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1913 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbYDZEpB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 Apr 2008 00:45:01 -0400
In-Reply-To: <20080426001657.GD17369@modernduck.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jody McIntyre <scjody@sun.com>
Cc: linux-ide@vger.kernel.org

Jody McIntyre wrote:
..
> My ultimate goal is to replace mv_sata (the out-of-tree vendor driver)
> on RHEL 4 with sata_mv on a modern kernel, and to do this I need
> equivalent or better performance, especially on large (1MB) IOs.
..

Good goal, but hang on for a few weeks of updates yet-to-come first.
sata_mv is still not safe enough for production use, but getting there soon.

We're still behind on the errata workarounds (quite important), but should
be catching up soon.  And I've just today noticed a bug in the recently
reworked IRQ handling (patch to fix it coming soon-ish).
 
> I note the recent changes to enable NCQ result in a net performance gain
> for 64K and 128K IOs, but due to a chipset limitation in the 6xxx series
> (according to commit f273827e2aadcf2f74a7bdc9ad715a1b20ea7dda),
> max_sectors is now limited which means we can no longer perform IOs
> greater than 128K (ENOMEM is returned from an sg write.)  Therefore
> large IO performance suffers - for example, the performance of 2.6.25
> with NCQ support removed on 1MB IOs is better than anything possible
> with stock 2.6.25 for many workloads.
> 
> Would it be worth re-enabling large IOs on this hardware when NCQ is
> disabled (using the queue_depth /proc variable)?  If so I'll come up
> with a patch.
..

Mmm.. I'd like to see numbers for that, though all bets are off if it's
a WD drive that's performing more slowly with NCQ (quite common, that).

But yes, a sata_mv specific queue_depth op would be a good thing,
and it could revert to non-NCQ with a depth of "1", I suppose.

I'd still prefer if libata continued with NCQ on a depth of "1",
and only switched to non-NCQ at a depth of "0", though.  That's more of
a thing for Tejun than for you, though.  :)

If you could do a rough code-up of the non-NCQ for depth 1 patch
then that could save me some time here, thanks!

Cheers
