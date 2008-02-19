From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/12] ide: add ide-4drives host driver
Date: Tue, 19 Feb 2008 22:24:35 +0100
Message-ID: <200802192224.36088.bzolnier@gmail.com>
References: <20080216163856.10174.72546.sendpatchset@localhost.localdomain> <20080216163911.10174.58246.sendpatchset@localhost.localdomain> <47BAD3AE.7060906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:1724 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788AbYBSWD6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 17:03:58 -0500
Received: by nf-out-0910.google.com with SMTP id g13so756845nfb.21
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 14:03:54 -0800 (PST)
In-Reply-To: <47BAD3AE.7060906@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 19 February 2008, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > CONFIG_BLK_DEV_4DRIVES deserves its own host driver:
> 
> > * Add drivers/ide/legacy/ide-4drives.c and move "4drives" support there.
> 
> > * Add ide-4drives.o in the link order after all other legacy host
> >   drivers enabled by "ide0=" options (they all are mutually exclusive).
> 
> > * Make ide-4drives host driver probe itself for IDE devices instead of
> >   indirectly depending on ide_generic host driver.
> 
> > * Add "probe" module parameter to ide-4drives and update documentation.
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> > Index: b/drivers/ide/Kconfig
> > ===================================================================
> > --- a/drivers/ide/Kconfig
> > +++ b/drivers/ide/Kconfig
> > @@ -1042,8 +1042,8 @@ config BLK_DEV_4DRIVES
> >  	  Certain older chipsets, including the Tekram 690CD, use a single set
> >  	  of I/O ports at 0x1f0 to control up to four drives, instead of the
> >  	  customary two drives per port. Support for this can be enabled at
> > -	  runtime using the "ide0=four" kernel boot parameter if you say Y
> > -	  here.
> > +	  runtime using the "ide_4drives.probe" kernel boot parameter if you
> 
>     Not "ide-4drives.probe?
>     Looks correct otherwise.

I believe that both versions are correct but I fixed this in 'take 3' to
be on the safe side.

Thanks,
Bart
