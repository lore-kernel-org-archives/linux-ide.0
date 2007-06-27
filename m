From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/6] ide: add ata_dev_has_iordy() helper
Date: Thu, 28 Jun 2007 00:10:34 +0200
Message-ID: <200706280010.34122.bzolnier@gmail.com>
References: <200706232005.10968.bzolnier@gmail.com> <200706272102.33989.bzolnier@gmail.com> <4682C87A.2040709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:55902 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbXF0Vyg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jun 2007 17:54:36 -0400
Received: by ug-out-1314.google.com with SMTP id j3so440827ugf
        for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2007 14:54:35 -0700 (PDT)
In-Reply-To: <4682C87A.2040709@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 27 June 2007, Sergei Shtylyov wrote:

> >>>>Set Transfer Mode subcode of the Set Features command, you're always selecting 
> >>>>the flow control mode, i.e. using IORDY. So, the last condition in this if 
> 
> >>    So, what actually would need fixing in *all* the drivers if one was aiming 
> >>at ATA-1 compatibility is *not* issuing that subcommand to such drives...
> 
> > I was actually thinking about a different way of fixing this:
> 
> > - remove 0x08 bit from XFER_PIO_[0,6] defines and add new XFER_PIO_IORDY
> >   define (<linux/ata.h>)
> 
>     Nah, that wouldn't match to the ATA definition of these values.
> 
> > - check for speed == XFER_PIO_[0,6] in ide-lib.c::ide_config_drive_speed()
> 
>     It's in ide-iops.c. ;-)
> 
> >   and pmac.c::pmac_ide_do_setfeature(), add XFER_PIO_IORDY if needed
> 
>     And what, just pass the mode thru to the Set Features if there's no IORDY 
> support?  That would be bogus since there are just *no* subcodes to set the 
> specific mode below 0x08 -- the only defined subcodes are 0x00 (set default 
> mode), and 0x01 (set default mode w/o IORDY).

Thinko on my side.

Damn, I should have re-check ATA specs before writing this. :)

>     I was thinking of checking if the drive really supports IORDY before 
> issuing a command to set PIO mode (and just skipping the command if there's no 
> IORDY -- well, maybe adding an extra check that the passed mode is acceptable 
> to the drive, i.e. <= its default one).  Should be quite simple to do.

Sounds fine.

> > This should be done together with fixing these host drivers that don't
> > handle IORDY properly.
> 
>     Erm, not necessarily...

Hmm, yes.

I'll just count on you with fixing all this IORDY stuff (as you have
much more expertise in this field) and concentrate on other things.

> >>>Oh yes, I keep forgetting about it - some nice FIXME comment
> >>>in <linux/ata.h> would be of a great help. :-)
> 
> >>    Well, some drivers (like pdc202xx_*) don't do the IORDY thing right for 
> >>PIO modes < 3 as well...
> 
> > Added to the existing IDE TODO at
> 
> > 	http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/TODO
> 
> > Patches adding/removing items are welcomed.
> 
> > Patches fixing actual issues are welcomed even more.
> 
>     Sigh, I'm trying to get some time (more like time slices :-) off to deal 
> with my own issues...

Which reminds me about some HPT IDE patches... 8)

Bart
