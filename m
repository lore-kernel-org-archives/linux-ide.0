From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC/BUG?] ide_cs's removable status
Date: Wed, 21 Sep 2005 20:29:32 +0100
Message-ID: <20050921192932.GB13246@flint.arm.linux.org.uk>
References: <1127319328.8542.57.camel@localhost.localdomain> <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca> <1127327243.18840.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23817 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751397AbVIUT3p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Sep 2005 15:29:45 -0400
Content-Disposition: inline
In-Reply-To: <1127327243.18840.34.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Richard Purdie <rpurdie@rpsys.net>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Wed, Sep 21, 2005 at 07:27:23PM +0100, Alan Cox wrote:
> On Mer, 2005-09-21 at 13:21 -0400, Mark Lord wrote:
> > In the case of CF cards in ide-cs, removing the card is equivalent
> > to removing the entire IDE controller, not just the media.
> 
> It isn't the same as removing the entire PCMCIA controller layer. As far
> as PCMCIA is concerned there has been no change. Thus we have no media
> change event and we need ->removable = 1
> 
> If the PCMCIA card disappeared each time it would be different

Last time I checked, with CF cards the media was an inherent part of
the CF card and is not changable without removing the card, opening
it, getting out the soldering iron... or alternatively plugging in
a different CF card.

Of course, PCMCIA will detect removal of the CF card provided the
PCMCIA hardware is working.  PCMCIA will also detect a CF card which
has been changed while the system has been suspended _provided_ the
CIS does not match the previous cards CIS.  It'll even do this if
you use cardctl suspend/cardctl resume.

However, if you suspend your system, remove your CF card, put it in
a different machine, use it (note: by doing this it could _already_
be in an inconsistent state), and put it back in the original machine
before resuming it, the cache on the original machine will disagree
with what is on the card.  But then you have done something silly
already by taking media in an inconsistent state to another machine
- and modified that inconsistent filesystem state.

It sounds like you know of a case where this isn't true - maybe a bug
report.  Can you expand on it?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
