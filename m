From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Sat, 9 May 2009 00:07:10 +0200
Message-ID: <200905090007.10827.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <20090508212457.fxyzi9gk3cw4ksw0@webmail.inov.pt> <4A049D99.3050203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38947 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbZEHWD6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 May 2009 18:03:58 -0400
Received: by fxm2 with SMTP id 2so1634447fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 08 May 2009 15:03:57 -0700 (PDT)
In-Reply-To: <4A049D99.3050203@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: joao.ramos@inov.pt, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Friday 08 May 2009 23:01:13 Sergei Shtylyov wrote:
> Hello.
> 
> joao.ramos@inov.pt wrote:
> 
> >>> Is this correct? Sorry, has I stated earlier, I'm wasn't familiar with
> >>> the IDE susbsystem untill I wrote this patch; but I'm willing to
> >>> contribute in any way I can, so please, bear with me on this :-) .
> >>
> >> Sure, nobody starts from the expert level and not all maintainers are
> >> into "prove the maintainer wrong" elitist's idiocy. ;)
> >>
> >>> >
> >>> >>>
> >>> >>>
> >>> >>>> There's just only one issue; normally, I would setup the specific
> >>> >>>> timings (t0, t1, t2, t2i, etc) in the 'pio_set_mode' hook. 
> >>> However, if
> >>> >>>> you look further in the driver, those timings aren't defined 
> >>> through a
> >>> >>>> memory controller but instead manually enforced by 'ndelay' 
> >>> calls (arghhh).
> >>> >>>> This means that in my low-level procedures for reading and 
> >>> writing, I
> >>> >>>> need to have access to the timings (or the struct ide_timing)
> >>> >>>> corresponding to the PIO mode selected, in order to use the 
> >>> correct delays.
> >>> >>>>
> >>> >>>> My question is: which is the best way to accomplish this? 
> >>> Declaring a
> >>> >>>> global struct ide_timing variable pointer that always holds the 
> >>> correct
> >>> >>>> ide_timing struct to the selected PIO mode? Or should I always 
> >>> check (in
> >>> >>>> some manner) what is the current PIO mode and then select the 
> >>> adequate
> >>> >>>> delays?
> >>> >>>>
> >>> >>>>
> >>> >>> I think that the setting variable pointer in ->set_pio_mode 
> >>> method would
> >>> >>> work best.  Seems like the existing drive_data field of 
> >>> ide_drive_t is well
> >>> >>> suited for this purpose (however it may be worth to convert it 
> >>> to 'void *'
> >>> >>> type while we are it).
> >>> >>>
> >>> >>>
> >>> >> Did you mean 'drive_data' field, or 'driver_data' field?
> >>> >> 'drive_data' field is an unsigned int value; I guess you meant
> >>> >> 'driver_data' field as it is a (void *) field, so I can define it 
> >>> as a
> >>> >> pointer to the correct 'struct ide_timing'.
> >>> >>
> >>> >
> >>> > That is why I hinted that you may need to convert 'drive_data' to
> >>> > 'void *' type first.  You may also try to use 'driver_data' instead
> >>> > but you will discover rather quickly that you shouldn't do this... ;)
> >>> >
> >>> > 'driver_data' is for use by IDE core and IDE device drivers.
> >>> >
> >>> > 'drive_data' is for use by IDE host drivers.
> >>> >
> >>>
> >>> And this conversion is made by my driver code, or should I fix directly
> >>> in the ide_drive_t structure?
> >>
> >> The latter -- ide_drive_t is the place needing fixing.
> >
> >
> > Same: I will fix that and propose a patch.
> 
>    Hey, don't do this please! This is actually a bad idea as some 
> drivers (e.g. sl82c105) use drive_data as an integer entity. Bart, stop 
> giving such advices please. :-)

I'm not sure what you're getting at with "such advices"... :)

We need to cast somewhere anyway so we may as well cast from 'void *' to
'unsigned int' where needed and not the other way around (or rather from
'unsigned int' to 'struct ide_timing *') -- which would be an ugly hack
and could cause maintainability/portability problems later.

BTW it seems like a good occasion to add ide_{get,set}_drivedata() helpers
(ala existing ide_{get,set}_hwifdata() ones) to <linux/ide.h> and thus make
internal IDE API more coherent.

[ Yes, I know that we may get away with s/unsigned int/unsigned long/
  and casting it to 'struct ide_timing *' for now but it always better
  to at least consider more elegant solution first... ]

Thanks,
Bart
