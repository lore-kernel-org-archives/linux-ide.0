From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH #upstream-fixes] ata_piix: save, use saved and restore
	IOCFG
Date: Fri, 2 Jan 2009 09:29:33 +0100
Message-ID: <20090102082933.GA7881@rhlx01.hs-esslingen.de>
References: <495D8450.6070505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:42985 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbZABIiM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jan 2009 03:38:12 -0500
Content-Disposition: inline
In-Reply-To: <495D8450.6070505@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, michal@physics.ubc.ca, IDE/ATA development list <linux-ide@vger.kernel.org>, Andreas Mohr <andi@lisas.de>

Hi,

On Fri, Jan 02, 2009 at 12:04:48PM +0900, Tejun Heo wrote:
> Certain ACPI implementations mess up IOCFG on _STM making libata
> detect cable type incorrectly after a suspend/resume cycle.  This
> patch makes ata_piix save IOCFG on attach, use the saved value for
> things which aren't dynamic and restore it on detach so that the next
> driver also gets the BIOS initialized value.
> 
> This patch contains the following changes.
> 
> * makes ich_pata_cable_detect() use saved_iocfg.
> 
> * make piix_iocfg_bit18_quirk() take @host and use saved_iocfg.
> 
> * hpriv allocation moved upwards to save iocfg before doing anything
>   else.
> 
> This fixes bz#11879.  Andreas Mohr reported and diagnosed the problem.

I'm mighty unhappy ;-)

First, I still think prime cause was a weak disk implementation of Word 93
and not BIOS ACPI handling itself (bug #12202 is a PATA SSD, too!).
(unless one thinks that BIOS should know about SSD variants of PATA
and actively do special-case them itself)
Second, you've been keeping silent about the duplicate processing
for too long (I didn't know about it at all until marked duplicate),
thus nobody else could derive any hard facts from the doubled information.
Third, it was not just me who reported it, Carl Michal did >= 10 reports
in his bug.
Fourth, "bz#11879" may seem a precise indication, but when writing this
within Bugzilla instead of a plain "bug #11879", you probably won't have it
hyperlinked, thus I'd always prefer the usual writing. </nitpick>


Patch seems fine to me, thanks a helluva lot for your hard work!
(probably will test, later)

> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: Andreas Mohr <andi@lisas.de>
