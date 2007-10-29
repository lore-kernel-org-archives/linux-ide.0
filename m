From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC/PATCH] libata and bogus LBA48 drives
Date: Mon, 29 Oct 2007 22:14:06 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0710292212070.20687@anakin>
References: <Pine.LNX.4.62.0710292103500.9180@pademelon.sonytel.be>
 <4726427A.3070106@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:59666 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbXJ2VOl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 17:14:41 -0400
Received: from hoboe2bl1.telenet-ops.be (hoboe2bl1.telenet-ops.be [195.130.137.73])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id 0E3E8A04A2
	for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2007 22:14:40 +0100 (CET)
In-Reply-To: <4726427A.3070106@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Ben Collins <ben.collins@ubuntu.com>, Olivier Demarto <olivierd@sonycom.com>, linux-ide@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Mon, 29 Oct 2007, Jeff Garzik wrote:
> Geert Uytterhoeven wrote:
> > A colleague noticed recent versions of Ubuntu no longer detect his 80 GB
> > ST380020ACE drive. This drive is special in that it advertises LBA48
> > support,
> > but has the lba_capacity_2 field set to zero (cfr.
> > http://lkml.org/lkml/2004/3/30/163).
> > 
> > Upon closer look, libata indeed doesn't seem to handle this case yet.
> > Below is an (untested) fix.
> > 
> > ---
> > Subject: libata: Ignore bogus lba48 drives
> > 
> > Some drives (e.g. the 80 GB ST380020ACE) advertise they support LBA48, but
> > have
> > lba_capacity_2 field set to zero. This causes the drive not being detected
> > by
> > the libata driver.
> > 
> > Add a check for this to ata_id_has_lba48(), cfr. what is done in
> > idedisk_supports_lba48().
> > 
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > NOTE: Untested due to the lack of hardware
> > 
> >  include/linux/ata.h |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > --- a/include/linux/ata.h
> > +++ b/include/linux/ata.h
> > @@ -402,6 +402,8 @@ static inline int ata_id_has_lba48(const
> >  {
> >  	if ((id[83] & 0xC000) != 0x4000)
> >  		return 0;
> > +	if (!ata_id_u64(id, 100))
> > +		return 0;
> >  	return id[83] & (1 << 10);
> >  }
> 
> Is there any hope of getting a dump of the IDENTIFY DEVICE page?
> 
> 'hdparm --Istdout /dev/DEVICE' should do the trick, for either IDE driver or
> libata.

Fortunately I still have a very old dump myself:

| kobe:~# cat /proc/ide/hdc/identify
| 0c5a 3fff 0000 0010 0000 0000 003f 0000
| 0000 0000 3547 434d 5745 344c 2020 2020
| 2020 2020 2020 2020 0000 1000 0004 362e
| 3033 2020 2020 5354 3338 3030 3230 4143
| 4520 2020 2020 2020 2020 2020 2020 2020
| 2020 2020 2020 2020 2020 2020 2020 8010
| 0000 2f00 0000 0200 0200 0007 ffff 0001
| 003f ffc1 003e 0110 f8b0 0950 0000 0007
| 0003 0078 0078 00f0 0078 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 007e 0000 346b 4f09 4003 3469 0e09 4003
| 103f 0000 0000 0040 fffe 600f 8080 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
|                     ^^^^^^^^^^^^^^^^^^^
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0201 28cc 098a f8b0 0950 2e30 0002 0cbe
| 0216 0000 3c03 3cb4 ffff 000f 0100 0800
| 0128 0400 8c02 0cb9 003c 04b0 e808 bd10
| 0000 0454 0028 0000 0000 0020 00e3 000a
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 0000
| 0000 0000 0000 0000 0000 0000 0000 38a5
| kobe:~#

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
