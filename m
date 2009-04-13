From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] libata: add CFA specific identify data words
Date: Mon, 13 Apr 2009 21:42:49 +0200
Message-ID: <200904132142.49279.bzolnier@gmail.com>
References: <200903032029.29073.sshtylyov@ru.mvista.com> <49E36F3F.6080907@ru.mvista.com> <49E37385.6070506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:46246 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbZDMTkF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2009 15:40:05 -0400
Received: by fxm2 with SMTP id 2so2125719fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 13 Apr 2009 12:40:02 -0700 (PDT)
In-Reply-To: <49E37385.6070506@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Monday 13 April 2009 19:16:53 Jeff Garzik wrote:
> Sergei Shtylyov wrote:
> > Jeff Garzik wrote:
> > 
> >>>>>> Declare and use constants for CFA specific identify data words 162 
> >>>>>> and 163.
> > 
> >>>>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > 
> >>>>>    Jeff, have you forgotten about this one too?
> > 
> >>>>>> Index: linux-2.6/drivers/ata/libata-core.c
> >>>>>> ===================================================================
> >>>>>> --- linux-2.6.orig/drivers/ata/libata-core.c
> >>>>>> +++ linux-2.6/drivers/ata/libata-core.c
> >>>>>> @@ -1650,8 +1650,8 @@ unsigned long ata_id_xfermask(const 
> >>>>>> u16          /*
> >>>>>>           *    Process compact flash extended modes
> >>>>>>           */
> >>>>>> -        int pio = id[163] & 0x7;
> >>>>>> -        int dma = (id[163] >> 3) & 7;
> >>>>>> +        int pio = (id[ATA_ID_CFA_MODES] >> 0) & 0x7;
> >>>>>> +        int dma = (id[ATA_ID_CFA_MODES] >> 3) & 0x7;
> >>>>>>  
> >>>>>>          if (pio)
> >>>>>>              pio_mask |= (1 << 5);
> >>>>>> @@ -2408,7 +2408,8 @@ int ata_dev_configure(struct ata_device      
> >>>>>> /* ATA-specific feature tests */
> >>>>>>      if (dev->class == ATA_DEV_ATA) {
> >>>>>>          if (ata_id_is_cfa(id)) {
> >>>>>> -            if (id[162] & 1) /* CPRM may make this media unusable */
> >>>>>> +            /* CPRM may make this media unusable */
> >>>>>> +            if (id[ATA_ID_CFA_KEY_MGMT] & 1)
> >>>>>>                  ata_dev_printk(dev, KERN_WARNING,
> >>>>>>                             "supports DRM functions and may "
> >>>>>>                             "not be fully accessable.\n");
> > 
> >>>> This you'll need to resend...
> > 
> >>>    I wonder why you're telling me this only now
> > 
> >> Because you asked "have you forgotten about this one?" on April 8th.
> > 
> >    I mean why didn't you tell me to resubmit when you split off the 
> > ata.h part of the original patch? I was under impression that you would 
> > queue this part too...
> 
> It got lost in the confusion, I suppose.  I figured you would resubmit 
> when you posted the IDE version.
> 
> If you recall, you requested that this go via Bart's tree on March 3rd. 
>   Then Bart did a big push without it.  So, to prevent delaying you 
> further, I split off the ata.h patch and forwarded that upstream.

Heh, you make it sound like I was delaying Sergei's work...

On March 3rd Sergei has posted initial CFA patches for review + testing by
Stanislaw (at91_ide Author), with the following extra information contained
in patches:

"[PATCH 1/2] libata: add CFA specific identify data words" said:

  ...
  This patch is against the current pata-2.6 series. I'd prefer that Bart merged
  it thru his tree as my next patch adding CF mode support to IDE depends on it.
  ...

"[PATCH 2/2] ide: add support for CFA specified transfer modes":

  ...
  This patch is against the current pata-2.6 series. Since there were no PIO5
  capable hard drives produced and you also need 66 MHz input clock to actually
  get the difference WRT the setup timing programmed, I decided to simply replace
  the old non-standard PIO mode 5 timings with CFA specified ones.
  Phew, hopefully I haven't overlooked anything -- quite a lot had to be changed.

  Stanislaw, please give it a try -- I don't have any CF hardware now.
  ...

Patch 1/2 was acked by you on March 4th.  However patch 2/2 was still going
through review and few issues needing addressing were raised (subsequently
revised versions of patch were posted on March 10th and later on March 11th).

The next day (March 5th) while I was pushing "IDE fixes" pull request (we
were in the 2.6.29-rc7 stabilization period at that time) you stepped in
(cc:ing Linus and Andrew) with:

"[PATCH] libata: add CFA specific identify data words"

which contained following info:

  ...
  Sergei said:
  This patch is against the current pata-2.6 series. I'd prefer that Bart merged
  it thru his tree as my next patch adding CF mode support to IDE depends on it.

  jgarzik adds:
  I didn't see this in your latest submission, Bart.  It is simple and
  harmless and might as well go ahead upstream, to eliminate the
  cross-tree dependency that Sergei speaks of (his patch also touched
  drivers/ata/libata-core.c, but I excluded that from below).
  ...

to which I replied:

  ...
  Simply because I haven't yet got to those patches + Sergei mentioned
  that they need to be tested yet.
  ...
  Fine with me if this makes things easier for everyone.

  I updated git pull request with this patch fixing patch summary
  (this is not libata specific change) and patch description (constants
  are not currently unused) while at it.
  ...

As I see it, there was absolutely no need to rush things -- I simply didn't
get to processing newer submissions yet and I would just push Sergei's patch
in the next IDE pull request (which happened on March 13th).

Simple reminder/query about the patch status would be more than enough but
instead you wasted time for everybody by splitting libata part from Sergei's
patch (without updating patch summary+description which I had to fix) and
later forgotting about it.  Moreover instead of simply pushing forgotten
part yourself you requested Sergei to resubmit it and at the same time you
tried to put the blame about the whole situation on me.

Thanks,
Bart
