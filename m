From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/6] ide: add ata_dev_has_iordy() helper
Date: Sat, 30 Jun 2007 00:16:34 +0200
Message-ID: <200706300016.34267.bzolnier@gmail.com>
References: <200706232005.10968.bzolnier@gmail.com> <200706280010.34122.bzolnier@gmail.com> <46856A77.9050808@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:62712 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756842AbXF2WBY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 18:01:24 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1453298mue
        for <linux-ide@vger.kernel.org>; Fri, 29 Jun 2007 15:01:23 -0700 (PDT)
In-Reply-To: <46856A77.9050808@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Friday 29 June 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> [...]
> 
> > Damn, I should have re-check ATA specs before writing this. :)
> 
>     Yeah, never hurts... but takes time. ;-)
> 
> >>    I was thinking of checking if the drive really supports IORDY before 
> >>issuing a command to set PIO mode (and just skipping the command if there's no 
> >>IORDY -- well, maybe adding an extra check that the passed mode is acceptable 
> >>to the drive, i.e. <= its default one).  Should be quite simple to do.
> 
> > Sounds fine.
> 
>     I'll look into doing this some time... :-)

Cool.

> >>>This should be done together with fixing these host drivers that don't
> >>>handle IORDY properly.
> 
> >>    Erm, not necessarily...
> 
> > Hmm, yes.
> 
> > I'll just count on you with fixing all this IORDY stuff (as you have
> > much more expertise in this field) and concentrate on other things.
> 
>     I'm afraid this compliment is not well deserved. :-<
> 
> >>>>>Oh yes, I keep forgetting about it - some nice FIXME comment
> >>>>>in <linux/ata.h> would be of a great help. :-)
> 
> >>>>   Well, some drivers (like pdc202xx_*) don't do the IORDY thing right for 
> >>>>PIO modes < 3 as well...
> 
> >>>Added to the existing IDE TODO at
> 
> >>>	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/TODO
> 
>     I think this list already needs cleaning -- e.g. at least cmd64x.c and 
> hpt366.c have been deatl with.

Thanks, removed.

> >>>Patches adding/removing items are welcomed.
> 
> >>>Patches fixing actual issues are welcomed even more.
> 
> >>    Sigh, I'm trying to get some time (more like time slices :-) off to deal 
> >>with my own issues...
> 
>     By by "my own issues" I don't mean patches -- patches don't help me, it's 
> rather injections and pills... +:-)

Heh, sorry I didn't know about that.

I hope that it is nothing serious and wish you quick recovery...

So you could hack some more... :-)

> > Which reminds me about some HPT IDE patches... 8)
> 
>     Done now -- at last. However, I've had troubles with SMPT sending them. :-/

Looks good, applied all three patches.

Thanks,
Bart
