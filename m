From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] ide-cd: Improve "weird block size" error message
Date: Tue, 23 Jun 2009 10:20:45 +0200
Message-ID: <200906231020.47054.elendil@planet.nl>
References: <200906211446.38598.elendil@planet.nl> <200906230951.24615.elendil@planet.nl> <20090623075733.GA14790@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml110.kpnxchange.com ([195.121.3.14]:50669 "EHLO
	CPSMTPM-EML110.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751107AbZFWIUp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jun 2009 04:20:45 -0400
In-Reply-To: <20090623075733.GA14790@liondog.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 23 June 2009, Borislav Petkov wrote:
> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> > index 4a19686..7ec6996 100644
> > --- a/drivers/ide/ide-cd.c
> > +++ b/drivers/ide/ide-cd.c
> > @@ -886,10 +886,9 @@ static int cdrom_read_capacity(ide_drive_t
> > *drive, unsigned long *capacity, case 4096:
> >  		break;
> >  	default:
> > -		printk(KERN_ERR PFX "%s: weird block size %u\n",
> > +		printk_once(KERN_ERR PFX "%s: weird block size %u; "
                                                          ^^^^^^^
> > +				"setting default block size to 2048\n",
> >  				drive->name, blocklen);
> > -		printk(KERN_ERR PFX "%s: default to 2kb block size\n",
> > -				drive->name);
>
> Please leave the weird block size in the printk since it sometimes
> might give insights on what is going on.

I did :-)
