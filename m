From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] libata: extend ata_acpi_cbl_80wire() and fix cable detection in pata_via and pata_amd
Date: Sat, 3 Nov 2007 02:12:08 +0100
Message-ID: <200711030212.08427.bzolnier@gmail.com>
References: <472B402A.4030009@gmail.com> <20071102154215.1a93249c@the-village.bc.nu> <200711030157.00354.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:17463 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbXKCBFp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 21:05:45 -0400
Received: by fk-out-0910.google.com with SMTP id z23so923645fkz
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 18:05:43 -0700 (PDT)
In-Reply-To: <200711030157.00354.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Saturday 03 November 2007, Bartlomiej Zolnierkiewicz wrote:
> On Friday 02 November 2007, Alan Cox wrote:
> > > Using the initial GTM value is the right thing to do because both are
> > > trying to check firmware setting and by the time ->cable_detect runs
> > > the controller is already forced into PIO0 by reset.
> > 
> > As we only look at the DMA bits that doesn't matter but I agree it would
> 
> It does matter,
> 
> http://lkml.org/lkml/2007/10/12/537
> 
> "
> >       libata: correct handling of SRST reset sequences
> 
> This potentially adds a regression for nVidia boxes (but ACPI cable
> detection should compensate for it):
> 
> pata_amd's ->cable_detect checks UDMA timings to get the cable type
> (cable detection is done before the SRST) but pata_amd's ->set_piomode

s/after/before/ of course

> messes with UDMA timings.  It seems that both methods need fixing.
> "
> 
> [ Now we see that since ACPI can just dump the current settings
>   ACPI cable detection won't help a tiny bit. ]
> 
> AFAICS pata_via.c has the same problem w.r.t. ->set_piomode
> 
> > be cleaner if we were more careful. Also our mode setting outside
> > pata_acpi doesn't touch the ACPI settings so its ok for that reason too.
> 
> Thanks,
> Bart
