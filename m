From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/BUG?] ide_cs's removable status
Date: Tue, 1 Jan 2002 06:18:12 +0100
Message-ID: <20020101051811.GA8946@openzaurus.ucw.cz>
References: <1127319328.8542.57.camel@localhost.localdomain> <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca> <1127327243.18840.34.camel@localhost.localdomain> <1127328385.20660.45.camel@localhost.localdomain> <1127348289.18840.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932158AbVIXJ5z@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1127348289.18840.62.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Purdie <rpurdie@rpsys.net>, Mark Lord <liml@rtr.ca>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi!


> > CF slots have card detection and ide-cs will see a card removal event.
> > Have a look at ide_event() in ide-cs.c: CS_EVENT_CARD_INSERTION and
> > CS_EVENT_CARD_REMOVAL are what they say...
> 
> Not implemented on large numbers of adapters. Been there tried that,
> been 2.4 IDE maintainer.

How is CF flash card different from CF microdrive? AFAIK they are
not, so we may need to detect IBM microdrives as "is_flash"...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
