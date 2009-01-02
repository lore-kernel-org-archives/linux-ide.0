From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH #upstream-fixes] ata_piix: save, use saved and restore
	IOCFG
Date: Fri, 2 Jan 2009 09:58:15 +0100
Message-ID: <20090102085815.GA24609@rhlx01.hs-esslingen.de>
References: <495D8450.6070505@kernel.org> <20090102082933.GA7881@rhlx01.hs-esslingen.de> <495DD50D.7040108@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:59587 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbZABI6S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jan 2009 03:58:18 -0500
Content-Disposition: inline
In-Reply-To: <495DD50D.7040108@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andreas Mohr <andi@lisas.de>, Jeff Garzik <jeff@garzik.org>, michal@physics.ubc.ca, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

On Fri, Jan 02, 2009 at 05:49:17PM +0900, Tejun Heo wrote:
> Hello,
> 
> Andreas Mohr wrote:
> >> This fixes bz#11879.  Andreas Mohr reported and diagnosed the problem.
> > 
> > I'm mighty unhappy ;-)
> > 
> > First, I still think prime cause was a weak disk implementation of Word 93
> > and not BIOS ACPI handling itself (bug #12202 is a PATA SSD, too!).
> > (unless one thinks that BIOS should know about SSD variants of PATA
> > and actively do special-case them itself)
> 
> Frankly, I don't care one way or the other.  All ->cable_detect() is
> supposed to return is the cable type as detected by the controller and
> _STM is not supposed to alter the state no matter what.  I don't think
> delving into _STM implementation and finding out the exact cause of
> flipping cable detection bit leads to the correct solution.  It might
> be caused by PATA SSD not setting the cable bit this time but the next
> BIOS might as well get it wrong for different reason.  Plus, I don't
> see how IDENTIFY data can affect the cable bit unless the ACPI
> implementation is snooping IDENTIFY replies.

Right, viewn from this angle (of preventing _any_ incorrect messing with
cable type during _STM) it makes sense since it's a more generic
solution.

> > Second, you've been keeping silent about the duplicate processing
> > for too long (I didn't know about it at all until marked duplicate),
> > thus nobody else could derive any hard facts from the doubled information.
> 
> My fault but nothing intentional.  When I got the second report, I
> couldn't really remember your report other than the fact that I had a
> similar report which didn't lead to resolution at the time and between
> Christmas and New Year's day, I wasn't paying much attention to bugs
> other than following up on each one as comments come up.  ie. I didn't
> bother to look up which one was the other one, so the late
> association.

...and there are actually some advantages when _not_ revealing this
(comment #30 at bug #11879 for details).

> > Third, it was not just me who reported it, Carl Michal did >= 10
> > reports in his bug.
> 
> Are all of those SSD too?

That STEC PATA one at least, yes.

Thanks,

Andreas Mohr
