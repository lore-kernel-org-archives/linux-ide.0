From: "James Ausmus" <james.ausmus@gmail.com>
Subject: Re: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash devices
Date: Tue, 18 Apr 2006 09:32:18 -0700
Message-ID: <b79f23070604180932p760e29fapa6967a707a01b672@mail.gmail.com>
References: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
	 <1145358858.18736.16.camel@localhost.localdomain>
	 <20060418113439.GA11815@rhlx01.fht-esslingen.de>
	 <1145361153.18736.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.204]:23695 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750928AbWDRQcS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Apr 2006 12:32:18 -0400
Received: by xproxy.gmail.com with SMTP id t10so557990wxc
        for <linux-ide@vger.kernel.org>; Tue, 18 Apr 2006 09:32:18 -0700 (PDT)
In-Reply-To: <1145361153.18736.36.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On 4/18/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2006-04-18 at 13:34 +0200, Andreas Mohr wrote:
> > However, while this is much better than a compile-time setting, it's still
> > not fully satisfying since many users won't realize that they're hitting this
> > problem and thus won't search for and find this obscure boot parameter.
> > Is there any way at all to get this condition detected automatically?
>
> Not that I can think off immediately. The controller and the drive both
> report the modes they support. If that is wrong then we either need to
> be able to identify the specific device (as libata does with the Palmax
> systems) or try it and see (which we indeed do but takes time to error
> out).
>
> For PCMCIA CF adapters we are ok because they are ISA bus so PIO 0
> cycles are all that are supported. For other controllers it will depend
> whether the CF adapter is integrated into a PCI card with unique
> subvendor/dev identifiers which can be blacklisted, or a motherboard
> with DMI entries that can be used.
>
> If it's just some poorly engineered 'shove a cable in one end and a CF
> card the other' device which is therefore not directly detectable I
> think you lose.
>

This is exactly the situation that I have with 2 separate "dumb" (just
physical interfaces, essentially - not at all detectable) IDE->CF
adapters - both the IDE controller and the CF media support several
UDMA modes, so the IDE driver throws the CF device into UDMA mode on
bootup. However, as the physical interface between the IDE cable and
the CF socket is poorly engineered, it cannot handle the higher
speeds, causing the timeout errors. For some people, this can just be
fixed with an ide=nodma boot option, but as I also have a (quite
large) rotating media device on the controller, this is not an option,
as, if a fsck is performed on a boot, the boot-up time is upwards of
30 minutes.

I would be happy to look into making this a boot option - but my
project schedule won't allow for the kind of time for me to figure out
how to do that :), so this is just a quick hack that works for my
situation.

-James



> Alan
>
>
