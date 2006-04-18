From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash
	devices
Date: Tue, 18 Apr 2006 12:52:33 +0100
Message-ID: <1145361153.18736.36.camel@localhost.localdomain>
References: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
	 <1145358858.18736.16.camel@localhost.localdomain>
	 <20060418113439.GA11815@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33162 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932205AbWDRLmu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Apr 2006 07:42:50 -0400
In-Reply-To: <20060418113439.GA11815@rhlx01.fht-esslingen.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: James Ausmus <james.ausmus@gmail.com>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Maw, 2006-04-18 at 13:34 +0200, Andreas Mohr wrote:
> However, while this is much better than a compile-time setting, it's still
> not fully satisfying since many users won't realize that they're hitting this
> problem and thus won't search for and find this obscure boot parameter.
> Is there any way at all to get this condition detected automatically?

Not that I can think off immediately. The controller and the drive both
report the modes they support. If that is wrong then we either need to
be able to identify the specific device (as libata does with the Palmax
systems) or try it and see (which we indeed do but takes time to error
out).

For PCMCIA CF adapters we are ok because they are ISA bus so PIO 0
cycles are all that are supported. For other controllers it will depend
whether the CF adapter is integrated into a PCI card with unique
subvendor/dev identifiers which can be blacklisted, or a motherboard
with DMI entries that can be used.

If it's just some poorly engineered 'shove a cable in one end and a CF
card the other' device which is therefore not directly detectable I
think you lose.

Alan

