From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Bug 11602
Date: Fri, 3 Oct 2008 18:38:41 +0200
Message-ID: <200810031838.41337.bzolnier@gmail.com>
References: <20080922045859.GA30163@gollum.tnic> <200809271939.52785.bzolnier@gmail.com> <20080927191044.GB11672@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:31658 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbYJCRna (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Oct 2008 13:43:30 -0400
Received: by gv-out-0910.google.com with SMTP id e6so296255gvc.37
        for <linux-ide@vger.kernel.org>; Fri, 03 Oct 2008 10:43:28 -0700 (PDT)
In-Reply-To: <20080927191044.GB11672@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org


[ added linux-ide@ to cc: ]

On Saturday 27 September 2008, Borislav Petkov wrote:
> > so just a minor nitpicks and I could have applied it now
> > (since I see in bugzilla that it has been successfully tested)
> > except that it completely lacks the patch description...
> 
> Here we go:
> 
> ---
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Thu, 25 Sep 2008 07:57:07 +0200
> Subject: [PATCH] ide-cd: temporary tray close fix
> 
> This one fixes http://bugzilla.kernel.org/show_bug.cgi?id=11602. A more generic fix
> for drives which cannot autoclose tray will follow.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied, thanks!

> ---
>  drivers/ide/ide-cd.c |    5 ++++-
>  include/linux/ide.h  |    3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 49a8c58..a3198f6 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1661,7 +1661,9 @@ static int ide_cdrom_probe_capabilities(ide_drive_t *drive)
>  		cdi->mask &= ~CDC_PLAY_AUDIO;
>  
>  	mechtype = buf[8 + 6] >> 5;
> -	if (mechtype == mechtype_caddy || mechtype == mechtype_popup)
> +	if (mechtype == mechtype_caddy ||
> +	    mechtype == mechtype_popup ||
> +	    drive->atapi_flags & IDE_AFLAG_NO_AUTOCLOSE)

I added an extra parentheses for consistency with the rest of kernel code

>  		cdi->mask |= CDC_CLOSE_TRAY;
>  
>  	if (cdi->sanyo_slot > 0) {
> @@ -1859,6 +1861,7 @@ static const struct cd_list_entry ide_cd_quirks_list[] = {
>  	{ "MATSHITADVD-ROM SR-8176", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
>  	{ "MATSHITADVD-ROM SR-8174", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
>  	{ "Optiarc DVD RW AD-5200A", NULL,   IDE_AFLAG_PLAY_AUDIO_OK	     },
> +	{ "Optiarc DVD RW AD-7543A", NULL,   IDE_AFLAG_NO_AUTOCLOSE	     },
>  	{ NULL, NULL, 0 }
>  };
>  
> diff --git a/include/linux/ide.h b/include/linux/ide.h
> index 1524829..d0c73f7 100644
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -366,7 +366,8 @@ enum {
>  	/* Currently on a filemark */
>  	IDE_AFLAG_FILEMARK		= (1 << 25),
>  	/* 0 = no tape is loaded, so we don't rewind after ejecting */
> -	IDE_AFLAG_MEDIUM_PRESENT	= (1 << 26)
> +	IDE_AFLAG_MEDIUM_PRESENT	= (1 << 26),
> +	IDE_AFLAG_NO_AUTOCLOSE		= (1 << 27),
>  };
>  
>  struct ide_drive_s {
