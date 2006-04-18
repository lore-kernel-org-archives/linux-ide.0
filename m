From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash devices
Date: Tue, 18 Apr 2006 13:34:39 +0200
Message-ID: <20060418113439.GA11815@rhlx01.fht-esslingen.de>
References: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com> <1145358858.18736.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:49620 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932200AbWDRLek (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Apr 2006 07:34:40 -0400
Content-Disposition: inline
In-Reply-To: <1145358858.18736.16.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Ausmus <james.ausmus@gmail.com>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

On Tue, Apr 18, 2006 at 12:14:18PM +0100, Alan Cox wrote:
> On Llu, 2006-04-17 at 16:11 -0700, James Ausmus wrote:
> > Some IDE -> Compact Flash media adapters are not capable of supporting
> > UDMA, which can cause very slow boot times when the CF media itself
> > reports as capable of UDMA transfer speeds. Create Kconfig option to
> > turn off the UDMA capability bit when media is identified as Compact
> > Flash.
> 
> This would be far better if it was a boot time option than a kernel
> configuration or set using sysfs/procfs controls as users will not want
> to recompile their kernel in such cases.

Count me in.
However, while this is much better than a compile-time setting, it's still
not fully satisfying since many users won't realize that they're hitting this
problem and thus won't search for and find this obscure boot parameter.
Is there any way at all to get this condition detected automatically?
I think one should try hard to find a way to detect it, if at all possible.

Andreas Mohr
