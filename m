From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [RFC/BUG?] ide_cs's removable status
Date: Wed, 21 Sep 2005 19:46:25 +0100
Message-ID: <1127328385.20660.45.camel@localhost.localdomain>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
	 <1127327243.18840.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:26056 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750797AbVIUSqm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2005 14:46:42 -0400
In-Reply-To: <1127327243.18840.34.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Wed, 2005-09-21 at 19:27 +0100, Alan Cox wrote:
> On Mer, 2005-09-21 at 13:21 -0400, Mark Lord wrote:
> > In the case of CF cards in ide-cs, removing the card is equivalent
> > to removing the entire IDE controller, not just the media.
> 
> It isn't the same as removing the entire PCMCIA controller layer. As far
> as PCMCIA is concerned there has been no change. Thus we have no media
> change event and we need ->removable = 1

CF slots have card detection and ide-cs will see a card removal event.
Have a look at ide_event() in ide-cs.c: CS_EVENT_CARD_INSERTION and
CS_EVENT_CARD_REMOVAL are what they say...

> If the PCMCIA card disappeared each time it would be different

Just the card disappears.

This along with your comments about the IDE layer having no hotplug
support suggest the code in question can be removed pending a better
replacement when hotplug is implemented.

Richard

