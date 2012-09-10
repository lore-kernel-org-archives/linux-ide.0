From: Borislav Petkov <bp@alien8.de>
Subject: Re: HDD problem, software bug, bios bug, or hardware ?
Date: Mon, 10 Sep 2012 11:17:32 +0200
Message-ID: <20120910091732.GB4431@liondog.tnic>
References: <1345901771.8871.YahooMailNeo@web124706.mail.ne1.yahoo.com>
 <20120826130152.GA20021@liondog.tnic>
 <1346086872.65665.YahooMailNeo@web124704.mail.ne1.yahoo.com>
 <20120827215952.GA18719@liondog.tnic>
 <1346259574.81504.YahooMailNeo@web124706.mail.ne1.yahoo.com>
 <20120830095808.GB24680@liondog.tnic>
 <1346325007.23643.YahooMailNeo@web124706.mail.ne1.yahoo.com>
 <20547.48101.900727.735398@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46787 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441Ab2IJJRd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Sep 2012 05:17:33 -0400
Content-Disposition: inline
In-Reply-To: <20547.48101.900727.735398@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Adko Branil <adkobranil@yahoo.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Sun, Sep 02, 2012 at 10:04:53PM +0200, Mikael Pettersson wrote:
> pdc_hard_reset_port needs to serialize because hard reset has to flip
> a port-specific bit in a controller register that's shared by all
> ports, so it takes the host lock. But now an interrupt occurs during
> the hard reset, and pdc_interrupt also has to take the host lock. (I
> don't know why the interrupt occurs, hotplug events are supposed to
> have been masked by ->freeze before ->hardreset. It might come from a
> different device, my test machine has multiple ATA controllers from
> different vendors, and some of them do share IRQ.)

This sounds very fishy - could it be the hardware raising a spurious IRQ
or something although it shouldn't?

Thanks.

-- 
Regards/Gruss,
    Boris.
