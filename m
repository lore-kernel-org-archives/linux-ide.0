From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-cd: Improve "weird block size" error message
Date: Tue, 23 Jun 2009 10:02:23 +0200
Message-ID: <20090623080223.GA19253@liondog.tnic>
References: <200906211446.38598.elendil@planet.nl> <200906222101.38586.elendil@planet.nl> <200906222335.06700.bzolnier@gmail.com> <200906230951.24615.elendil@planet.nl> <20090623075733.GA14790@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:52927 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbZFWICZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 04:02:25 -0400
Content-Disposition: inline
In-Reply-To: <20090623075733.GA14790@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 23, 2009 at 09:57:33AM +0200, Borislav Petkov wrote:
> On Tue, Jun 23, 2009 at 09:51:23AM +0200, Frans Pop wrote:
> 
> [..]
> 
> > ---
> > From: Frans Pop <elendil@planet.nl>
> > Subject: ide-cd: Improve "weird block size" error message
> > 
> > Currently the error gets repeated too frequently, for example
> > each time HAL polls the device when a disc is present. Avoid that
> > by using printk_once instead of printk.
> > Also join the error and corrective action messages into a single line.
> > 
> > Signed-off-by: Frans Pop <elendil@planet.nl>
> > Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > 
> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > index 4a19686..7ec6996 100644
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -886,10 +886,9 @@ static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *capacity,
> >  	case 4096:
> >  		break;
> >  	default:
> > -		printk(KERN_ERR PFX "%s: weird block size %u\n",
> > +		printk_once(KERN_ERR PFX "%s: weird block size %u; "
> > +				"setting default block size to 2048\n",
> >  				drive->name, blocklen);
> > -		printk(KERN_ERR PFX "%s: default to 2kb block size\n",
> > -				drive->name);
>

Ah, nevermind! Hadn't had a coffee yet, sorry :).

Acked-by: Borislav Petkov <petkovbb@gmail.com>

-- 
Regards/Gruss,
    Boris.
