From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 16/20] ata_piix: add EFAR SLC90E66 support
Date: Tue, 8 Feb 2011 13:38:09 +0000
Message-ID: <20110208133809.2386ee86@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<20110208122534.19110.89437.sendpatchset@linux-mhg7.site>
	<20110208131321.6ceb9a43@lxorguk.ukuu.org.uk>
	<AANLkTikYXWAbCjLpSyEqgDKBsZuM1na-tohLoLJx3Yr4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48232 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753539Ab1BHNef (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 08:34:35 -0500
In-Reply-To: <AANLkTikYXWAbCjLpSyEqgDKBsZuM1na-tohLoLJx3Yr4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> such optimizations because maintenance cost > potential savings (i.e.
> making SCSI quirks optional, I have draft patch for this, itself cuts
> like 10k).

Interesting in itself but irrelevant because the current situation is
that a piix change cannot break oldpiix, efar, it8213, radisys etc and
vice versa. Particuarly important when the other chips are not common so
test coverage is difficult, and that far outweighs the maintenance
savings for other things, especially as this is code that just doesn't
change.

> 
> > It also leads to hideous uglies in the main code paths like this :
> >
> > +       unsigned int has_sitre  = (dev->vendor != 0x8086 ||
> > +                                  dev->device != 0x1230);
> >
> > which also has exactly zero comments.
> 
> has_sitre variable name is documentation in itself for anyone knowing
> the hardware or has read a chipset/code documentation.

And naturally anyone randomly glancing at the code knows why it's
checking 0x8086 & 0x1230, and why the radisys check interacts with it.

Bartlomiej - those are a mess, a complete and total mess. It doesn't
necessarily argue against folding them together, but at least do a clean
job of it.
