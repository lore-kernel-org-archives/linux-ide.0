From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: save, use saved and restore
 IOCFG
Date: Fri, 02 Jan 2009 17:49:17 +0900
Message-ID: <495DD50D.7040108@kernel.org>
References: <495D8450.6070505@kernel.org> <20090102082933.GA7881@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52253 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbZABItx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jan 2009 03:49:53 -0500
In-Reply-To: <20090102082933.GA7881@rhlx01.hs-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Jeff Garzik <jeff@garzik.org>, michal@physics.ubc.ca, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

Andreas Mohr wrote:
>> This fixes bz#11879.  Andreas Mohr reported and diagnosed the problem.
> 
> I'm mighty unhappy ;-)
> 
> First, I still think prime cause was a weak disk implementation of Word 93
> and not BIOS ACPI handling itself (bug #12202 is a PATA SSD, too!).
> (unless one thinks that BIOS should know about SSD variants of PATA
> and actively do special-case them itself)

Frankly, I don't care one way or the other.  All ->cable_detect() is
supposed to return is the cable type as detected by the controller and
_STM is not supposed to alter the state no matter what.  I don't think
delving into _STM implementation and finding out the exact cause of
flipping cable detection bit leads to the correct solution.  It might
be caused by PATA SSD not setting the cable bit this time but the next
BIOS might as well get it wrong for different reason.  Plus, I don't
see how IDENTIFY data can affect the cable bit unless the ACPI
implementation is snooping IDENTIFY replies.

> Second, you've been keeping silent about the duplicate processing
> for too long (I didn't know about it at all until marked duplicate),
> thus nobody else could derive any hard facts from the doubled information.

My fault but nothing intentional.  When I got the second report, I
couldn't really remember your report other than the fact that I had a
similar report which didn't lead to resolution at the time and between
Christmas and New Year's day, I wasn't paying much attention to bugs
other than following up on each one as comments come up.  ie. I didn't
bother to look up which one was the other one, so the late
association.

> Third, it was not just me who reported it, Carl Michal did >= 10
> reports in his bug.

Are all of those SSD too?

> Fourth, "bz#11879" may seem a precise indication, but when writing
> this within Bugzilla instead of a plain "bug #11879", you probably
> won't have it hyperlinked, thus I'd always prefer the usual
> writing. </nitpick>

Heh... yeah, well.  I've always used OSDL bz#nnnn till now.  Maybe
it's better to use kernel bug#nnnn.

> Patch seems fine to me, thanks a helluva lot for your hard work!
> (probably will test, later)

>> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> Acked-by: Andreas Mohr <andi@lisas.de>

Thanks.

-- 
tejun
