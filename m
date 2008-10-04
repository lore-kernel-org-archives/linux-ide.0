From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 2/3] ide-cd: small drive type print fix
Date: Sat, 4 Oct 2008 10:28:28 +0200
Message-ID: <20081004082827.GA4160@gollum.tnic>
References: <1222669799-6565-1-git-send-email-petkovbb@gmail.com> <1222669799-6565-3-git-send-email-petkovbb@gmail.com> <200810031918.15455.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:54666 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYJDI2f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2008 04:28:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1304085fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 04 Oct 2008 01:28:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200810031918.15455.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Fri, Oct 03, 2008 at 07:18:15PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday 29 September 2008, Borislav Petkov wrote:
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> 
> applied (though I fail to see "an added value" of this change)

It simply makes the format consistent with the lines below: CD-R/RW - which is
the more common way of enumerating supported media you find in different specs
than DVD-R-RAM, don't you think?

> > ---
> >  drivers/ide/ide-cd.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > index 9ffce7f..e41b94d 100644
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -1784,7 +1784,7 @@ static int ide_cdrom_probe_capabilities(ide_drive_t *drive)
> >  	if ((cdi->mask & CDC_DVD_R) == 0 || (cdi->mask & CDC_DVD_RAM) == 0)
> >  		printk(KERN_CONT " DVD%s%s",
> >  				 (cdi->mask & CDC_DVD_R) ? "" : "-R",
> > -				 (cdi->mask & CDC_DVD_RAM) ? "" : "-RAM");
> > +				 (cdi->mask & CDC_DVD_RAM) ? "" : "/RAM");
> >  
> >  	if ((cdi->mask & CDC_CD_R) == 0 || (cdi->mask & CDC_CD_RW) == 0)
> >  		printk(KERN_CONT " CD%s%s",

-- 
Regards/Gruss,
    Boris.
