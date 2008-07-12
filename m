From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/8] ide: add ide_set_irq() inline helper
Date: Sat, 12 Jul 2008 12:30:47 +0200
Message-ID: <200807121230.47255.bzolnier@gmail.com>
References: <200711290104.21376.bzolnier@gmail.com> <200807112320.04264.bzolnier@gmail.com> <487727C6.7040008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:5817 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbYGKKgM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2008 06:36:12 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1151597nfc.21
        for <linux-ide@vger.kernel.org>; Fri, 11 Jul 2008 03:36:08 -0700 (PDT)
In-Reply-To: <487727C6.7040008@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>


Hi,

On Friday 11 July 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>>> Index: b/drivers/ide/ide-iops.c
> >>>>> ===================================================================
> >>>>> --- a/drivers/ide/ide-iops.c
> >>>>> +++ b/drivers/ide/ide-iops.c
> >>>>> @@ -688,8 +688,7 @@ int ide_driveid_update(ide_drive_t *driv
> >>>>> 	 */
> >>>>>
> >>>>> 	SELECT_MASK(drive, 1);
> >>>>> -	if (IDE_CONTROL_REG)
> >>>>> -		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);
> >>>>> +	ide_set_irq(drive, 1);
> >>>>>           
> >>>>    If we're going to execute the command using polling, isn't it logical to 
> >>>> *disable* drive's interrupt instead of enabling it which this code is 
> >>>> currently doing?  This looks like it might work only for the drivers having 
> >>>> the maskproc() method (of which hpt366.c is the only one that I've ever dealt 
> >>>> with).
> >>>>         
> >>> Yes, this needs fixing.
> >>>       
> >>     But should we honor drive->quirk_list here? What its different values 
> >> mean? I'm seeing either 1 or 2 is used to decide whether to set nIEN or not...
> >>     
> >
> > I did some research on ->quirk_list in the past but I couldn't exactly
> > figure it out.  I also wasn't able to trace this code to its author
> > (not that I tried very hard)...
> >
> > Anyway my current findings/theories are the following:
> >
> > - the diff between hpt366 and pdc202xx_{new,old} quirky devices:
> >
> > --- hpt366.c    2008-04-12 22:03:54.000000000 +0200
> > +++ pdc202xx_new.c      2008-04-12 22:04:03.000000000 +0200
> > @@ -1,7 +1,11 @@
> > -static const char *quirk_drives[] = {
> > +static const char *pdc_quirk_drives[] = {
> >         "QUANTUM FIREBALLlct08 08",
> >         "QUANTUM FIREBALLP KA6.4",
> > +       "QUANTUM FIREBALLP KA9.1",
> >         "QUANTUM FIREBALLP LM20.4",
> > +       "QUANTUM FIREBALLP KX13.6",
> > +       "QUANTUM FIREBALLP KX20.5",
> > +       "QUANTUM FIREBALLP KX27.3",
> >         "QUANTUM FIREBALLP LM20.5",
> >         NULL
> >  };
> >
> >   indicates that pdc202xx_{new,old} lists lack few devices that were added
> >   only to hpt366 and need fixing
> >   
> 
>    You surely meant to say the hpt366's list lacks few devices. ;-)

Yeah. :)

[...]

> > - we need to be a bit careful with hpt366's ->maskproc because it checks
> >   for ->quirk_list internally
> 
>    ... and falls back to manipuating nIEN if not -- which is not its 
> business.
> 
> >  (so either we need to mask/unmask for all devices on hpt366
> >   
> 
>    I looked at that masking code and didn't like it at all -- since the 
> interrupts are disabled for *both* channels as there's only *one* bit 
> controlling that. :-/

:-/ indeed, I didn't know about this.

> So, masking interrupt for all drives is not really desirable...

Agreed.

> >   or limit masking/unmasking to ->quirk_list on icside)
> >   
> 
>    But you just said that in the icside driver this code controls some 
> kind of IRQ routinng...

I later noticed that icside now also uses expansioncard_ops_t to do it
(like pata_icside which doesn't have ->maskproc alike) so ->maskproc may
no longer be needed for this.

> > - we should merge SELECT_MASK() with ide_set_irq() and consider skipping
> >   ide_set_irq() for ->quirk_list devices
> >   
> 
>    ... you mean where it's not already done?

We are going to mask the IRQ on controller side or enable/disable_irq()
anyway for ->quirk_list devices so we setting nIEN doesn't seem necessary?

Thanks,
Bart
