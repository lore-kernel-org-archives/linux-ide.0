From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/10] ide: flags query macros
Date: Mon, 23 Feb 2009 09:25:39 +0100
Message-ID: <20090223082539.GA24465@gollum.tnic>
References: <1234699692-9452-1-git-send-email-petkovbb@gmail.com> <200902171533.29135.bzolnier@gmail.com> <20090223070413.GA17783@gollum.tnic> <20090223073452.GA1764@uranus.ravnborg.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:60551 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbZBWIZo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Feb 2009 03:25:44 -0500
Content-Disposition: inline
In-Reply-To: <20090223073452.GA1764@uranus.ravnborg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 23, 2009 at 08:34:52AM +0100, Sam Ravnborg wrote:
> On Mon, Feb 23, 2009 at 08:04:13AM +0100, Borislav Petkov wrote:
> > > Since it is not a lot of modified lines and the change is rather
> > > straightforward it could as well be done in a single patch...
> > 
> > here's version 2:
> > --
> > From: Borislav Petkov <petkovbb@gmail.com>
> > Date: Mon, 23 Feb 2009 07:58:23 +0100
> > Subject: [PATCH] ide: flags query macros
> > 
> > Add drive->atapi_flags and drive->dev_flags macro wrappers
> > 
> > v2:
> > - use static inlines for better typechecking
> > - use macro indirection for convenience
> > 
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> 
> Version 2 looks much better - thanks.
> 
> diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
> index df3df00..3553759 100644
> --- a/drivers/ide/ide-cd_ioctl.c
> +++ b/drivers/ide/ide-cd_ioctl.c
> @@ -86,7 +86,7 @@ int ide_cdrom_check_media_change_real(struct cdrom_device_info *cdi,
> 
>         if (slot_nr == CDSL_CURRENT) {
>                 (void) cdrom_check_status(drive, NULL);
> -               retval = (drive->dev_flags & IDE_DFLAG_MEDIA_CHANGED) ? 1 : 0;
> +               retval = ide_dev_media_changed(drive) ? 1 : 0;
>                 drive->dev_flags &= ~IDE_DFLAG_MEDIA_CHANGED;
>                 return retval;
>         } else {
> 
> The use of ? 1 : 0; here is redundant.
> 
>                         if (drive->media == ide_disk) {
> -                               printk(KERN_INFO "%s: non-IDE drive, CHS=%d/%d/%d\n",
> +                               pr_info("%s: non-IDE drive, CHS=%d/%d/%d\n",
>                                         drive->name, drive->cyl,
>                                         drive->head, drive->sect);
>                         } else if (drive->media == ide_cdrom) {
> -                               printk(KERN_INFO "%s: ATAPI cdrom (?)\n", drive->name);
> +                               pr_info("%s: ATAPI cdrom (?)\n", drive->name);
>                         } else {
>                                 /* nuke it */
> -                               printk(KERN_WARNING "%s: Unknown device on bus refused identification. Ignoring.\n",
> +drive->name);
> +                               pr_warning("%s: Unknown device on bus refused "
> +                                          "identification, ignoring.\n",
> +                                          drive->name);
> I did not see this addressed in the changelog?

Actually, that was in the v1 changelog but got forgotten. Bart, can you
please add to the changelog

- shorten >80 lines

>                                 drive->dev_flags &= ~IDE_DFLAG_PRESENT;
> 
> You have a nice set of inlines to facilitate testing bits,
> but not for the above use?
> I guess this was not worth the abstraction for now.

Yeah, those are next but I'd like to wait a bit until ide rewrite
settles...

-- 
Regards/Gruss,
    Boris.
