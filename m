From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [Fwd: [BUG] sata_via doesn't detect anymore my disks (broken between rc1 and rc3)]
Date: Fri, 25 Aug 2006 16:09:34 +0200
Message-ID: <m2ac5soqjl.fsf@vador.mandriva.com>
References: <m2wt98bio1.fsf@vador.mandriva.com>
	<m2sljwbil7.fsf@vador.mandriva.com> <44E37BD4.8010709@pobox.com>
	<m23bbva9cs.fsf@vador.mandriva.com> <44E46E0E.4060703@gmail.com>
	<m2fyfv7a8s.fsf@vador.mandriva.com> <44EB32AD.1080305@gmail.com>
	<m2fyfnciky.fsf@vador.mandriva.com> <m2d5aprtw0.fsf@vador.mandriva.com>
	<44EEEA29.1010008@gmail.com> <20060825135540.GE21866@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:19464 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1751211AbWHYOJg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 10:09:36 -0400
In-Reply-To: <20060825135540.GE21866@htj.dyndns.org> (Tejun Heo's message of "Fri, 25 Aug 2006 22:55:40 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo <htejun@gmail.com> writes:

> > >none of both these patches worked :-(
> > 
> > The second didn't work?  But you said the following one liner worked.
> > 
> > --- drivers/ata/sata_via.c.tv6	2006-08-20 16:37:41.000000000 +0200
> > +++ drivers/ata/sata_via.c	2006-08-20 17:20:23.000000000 +0200
> > @@ -244,7 +244,7 @@
> > 
> >  static void vt6421_error_handler(struct ata_port *ap)
> >  {
> > -	return ata_bmdma_drive_eh(ap, ata_std_prereset, NULL,
> > +	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
> >  				  sata_std_hardreset, ata_std_postreset);
> >  }
> > 
> > The second patch is essentially identical to what you did the one liner. 
> >  Can you please check it once more?  I'll prepare old-sequence 
> > hardreset in the meantime.
> 
> Okay, here's the old-sequence hardreset patch.  This should have the
> highest chance of working.  This patch should be applied on top of the
> vt6420 patch.

On top of which patch?
I just tried to apply it on top of:
- your last week patch
- your two patches of this week

and it does *not* apply on top of anyone...

Couldn't you either check first your patch or (better) just send a
patch against vanilla 2.6.18-rc4-mm2?

Thanks
