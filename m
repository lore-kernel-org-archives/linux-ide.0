From: Jody McIntyre <scjody@sun.com>
Subject: Re: sata_mv performance; impact of NCQ
Date: Mon, 28 Apr 2008 13:33:18 -0400
Message-ID: <20080428173318.GJ17369@modernduck.com>
References: <20080426001657.GD17369@modernduck.com> <4812B43D.2040401@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:63468 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765632AbYD1Rd2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 13:33:28 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3SHXRbQ026253
	for <linux-ide@vger.kernel.org>; Mon, 28 Apr 2008 10:33:28 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0K0100C01PI88500@fe-sfbay-09.sun.com> (original mail from scjody@sun.com)
 for linux-ide@vger.kernel.org; Mon, 28 Apr 2008 10:33:27 -0700 (PDT)
In-reply-to: <4812B43D.2040401@rtr.ca>
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

On Sat, Apr 26, 2008 at 12:49:01AM -0400, Mark Lord wrote:
> >My ultimate goal is to replace mv_sata (the out-of-tree vendor driver)
> >on RHEL 4 with sata_mv on a modern kernel, and to do this I need
> >equivalent or better performance, especially on large (1MB) IOs.
> 
> Good goal, but hang on for a few weeks of updates yet-to-come first.
> sata_mv is still not safe enough for production use, but getting there soon.

OK.  For what it's worth, I've never had any problems with the 2.6.25
version of sata_mv, which is a nice improvement from the one in the
latest RHEL 5 kernel.  I haven't done any specific reliability tests
though.

> We're still behind on the errata workarounds (quite important), but should
> be catching up soon.  And I've just today noticed a bug in the recently
> reworked IRQ handling (patch to fix it coming soon-ish).

OK.  Let me know if there's anything I can help with, though my
experience with the chipset and SATA are both quite limited.  If you
need testing, I'm certainly able to do that.

> >Would it be worth re-enabling large IOs on this hardware when NCQ is
> >disabled (using the queue_depth /proc variable)?  If so I'll come up
> >with a patch.
> 
> Mmm.. I'd like to see numbers for that, though all bets are off if it's
> a WD drive that's performing more slowly with NCQ (quite common, that).

These are Hitachi drives:
  Vendor: ATA       Model: HITACHI HUA7250S  Rev: GK6O

>From my tests, NCQ is definitely a win for the IO sizes that work.

> But yes, a sata_mv specific queue_depth op would be a good thing,
> and it could revert to non-NCQ with a depth of "1", I suppose.
> 
> I'd still prefer if libata continued with NCQ on a depth of "1",
> and only switched to non-NCQ at a depth of "0", though.  That's more of
> a thing for Tejun than for you, though.  :)
> 
> If you could do a rough code-up of the non-NCQ for depth 1 patch
> then that could save me some time here, thanks!

OK, I'll work on that.

Cheers,
Jody


> Cheers

-- 
Jody McIntyre - Linux Kernel Engineer, Sun HPC
