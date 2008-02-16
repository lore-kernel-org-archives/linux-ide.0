From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Optiarc DVD RW AD-5200A audio playing
Date: Sat, 16 Feb 2008 16:24:01 +0100
Message-ID: <200802161624.02768.bzolnier@gmail.com>
References: <47B5EDB7.5050709@canonical.com> <20080216090532.GK13446@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.229]:39119 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995AbYBPPQR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 10:16:17 -0500
Received: by wx-out-0506.google.com with SMTP id h31so906081wxd.4
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 07:16:17 -0800 (PST)
In-Reply-To: <20080216090532.GK13446@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Stefan Bader <stefan.bader@canonical.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>


Hi,

On Saturday 16 February 2008, Borislav Petkov wrote:
> On Fri, Feb 15, 2008 at 02:53:27PM -0500, Stefan Bader wrote:
> > Hello Borislav,
> > 
> > I worked on a problem with an DVD driver (model=Optiarc DVD RW AD-5200A)
> > which obviously has the same problem as some Matshita drives. The
> > following patch was reported to enabled audio playing on this drive.
> > Would this approach be suitable for upstream or are there other
> > solutions to this problem?
> > 
> > Regards,
> > Stefan
> > 
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -2988,7 +2988,8 @@ int ide_cdrom_probe_capabilities (ide_drive_t *drive)
> >  	if (strcmp(drive->id->model, "MATSHITADVD-ROM SR-8187") == 0 ||
> >  	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8186") == 0 ||
> >  	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8176") == 0 ||
> > -	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8174") == 0)
> > +	    strcmp(drive->id->model, "MATSHITADVD-ROM SR-8174") == 0 ||
> > +	    strcmp(drive->id->model, "Optiarc DVD RW AD-5200A") == 0)
> >  		CDROM_CONFIG_FLAGS(drive)->audio_play = 1;
> > 
> >  #if ! STANDARD_ATAPI
> 
> Hi Stefan,
> 
> just to make sure that the audioplay bit is not set in the capabilities page,
> can you please try the following patch applied against 2.6.25-rc2 and send me
> the output. Thanks!
> 
> @Bart: by the way, this cdi->mask thingy is kinda unintuitive doing double
> negation to check whether a feature is supported or not. Yeah, this comes from
> "above," i.e. uniform cdrom layer. But still, shouldn't we use a cdi->caps_flags
> or something similar instead, which mirrors the caps page bits setting?

It seems so (at least having negative flags is very unintuitive) but they
might be some reason for this ugliness, Jens?

[ Please also remember that since cdrom layer is _uniform_ it may be not
  possible and/or desirable to have 1-1 mapping between caps page bits
  and the future cdi->caps_flags. ]

> commit 435f0f4496a1b32af2d542f43b2370a890fe2f83
> Author: Borislav Petkov <petkovbb@gmail.com>
> Date:   Sat Feb 16 09:56:36 2008 +0100
> 
>     ide-cd: Enable audio play quirk for Optiarc DVD RW AD-5200A drive
>     
>     Reported-by: Stefan Bader <stefan.bader@canonical.com>
>     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index f77db6b..2c9d06e 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1750,6 +1750,10 @@ int ide_cdrom_probe_capabilities (ide_drive_t *drive)
>  		cdi->mask &= ~(CDC_DVD_RAM | CDC_RAM);
>  	if (buf[8 + 3] & 0x10)
>  		cdi->mask &= ~CDC_DVD_R;
> +	if (!(buf[8 + 4] & 0x01)) {

Hmm, shouldn't there be '&& (cd->cd_flags & IDE_CD_FLAG_PLAY_AUDIO_OK)'
to prevent false positives?

> +		printk(KERN_INFO "ide-cd: audio play not advertised in caps page,"

Would be nice to also printk() the device name.

> +				 " enabling quirk.\n");
> +	}
>  	if ((buf[8 + 4] & 0x01) || (cd->cd_flags & IDE_CD_FLAG_PLAY_AUDIO_OK))
>  		cdi->mask &= ~CDC_PLAY_AUDIO;
>  
> @@ -1929,6 +1933,7 @@ static const struct cd_list_entry ide_cd_quirks_list[] = {
>  	{ "MATSHITADVD-ROM SR-8186", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
>  	{ "MATSHITADVD-ROM SR-8176", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
>  	{ "MATSHITADVD-ROM SR-8174", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK	    },
> +	{ "Optiarc DVD RW AD-5200A", NULL,   IDE_CD_FLAG_PLAY_AUDIO_OK      },
>  	{ NULL, NULL, 0 }
>  };
