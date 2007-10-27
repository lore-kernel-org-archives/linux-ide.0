From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.24-rc1 IDE regression on PMAC?
Date: Sat, 27 Oct 2007 21:19:42 +0200
Message-ID: <200710272119.42791.bzolnier@gmail.com>
References: <200710271756.l9RHuKub021729@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:52781 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbXJ0TOL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 15:14:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1969010mue
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 12:14:10 -0700 (PDT)
In-Reply-To: <200710271756.l9RHuKub021729@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

On Saturday 27 October 2007, Mikael Pettersson wrote:
> As shown by this dmesg diff between 2.6.23 and 2.6.24-rc1,
> IDE's PMAC driver now decides to downgrade itself to PIO2
> on this box. Is this intensional or a bug?

This drive still uses MWDMA1 according to the dmesg diff
(only the debug message from IDE PMAC is gone) but since we
have enabled PIO autotuning PIO is also tuned.

PIO downgrade is kind of expected for drives that doesn't
support PIO4 (this drive's max is PIO3).

The guilty code is in ide_get_best_pio_mode():

		/*
		 * Conservative "downgrade" for all pre-ATA2 drives
		 */
		if ((drive->hwif->host_flags & IDE_HFLAG_PIO_NO_DOWNGRADE) == 0 &&
			pio_mode && pio_mode < 4) {
			pio_mode--;
			printk(KERN_INFO "%s: applying conservative "
					 "PIO \"downgrade\"\n", drive->name);
		}

and is/was? probably needed only for CMD640 host driver so you
may try adding IDE_HFLAG_PIO_NO_DOWNGRADE to IDE PMAC driver
and see what happens. :)

> --- dmesg-2.6.23
> +++ dmesg-2.6.24-rc1
> @@ -84,8 +89,9 @@
>  ide0: Found Apple Heathrow ATA controller, bus ID 0, irq 28
>  Probing IDE interface ide0...
>  hda: MATSHITA CR-585, ATAPI CD/DVD-ROM drive
> +hda: applying conservative PIO "downgrade"
> +hda: host max PIO4 wanted PIO255(auto-tune) selected PIO2
>  hda: selected mode 0x21

0x21 == MWDMA1

Yeah, needs fixing to call ide_xfer_verbose() which prints something
human-readable.  I'll look into this, unless somebody beats me to it.

> -hda: Enabling MultiWord DMA 1
>  ide0 at 0xf1008000-0xf1008007,0xf1008160 on irq 28
>  ide1: Found Apple Heathrow ATA controller, bus ID 1, irq 30
>  Probing IDE interface ide1...

Thanks,
Bart
