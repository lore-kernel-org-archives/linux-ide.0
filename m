From: "Eddie Hung" <eddie.hung@gmail.com>
Subject: Re: CF as IDE on ICH6M using libata
Date: Tue, 4 Sep 2007 19:17:30 +0100
Message-ID: <6f9550040709041117ub6eff93w3006796f5f108761@mail.gmail.com>
References: <6f9550040709020542h530f0bfap5b01fb4ff0c00f25@mail.gmail.com>
	 <46DAB5DD.80807@gmail.com>
	 <6f9550040709021129m63b143f5jdda365f6042560d5@mail.gmail.com>
	 <46DB755C.308@gmail.com>
	 <6f9550040709030340h42dfbce4ud5919dafde4e5b69@mail.gmail.com>
	 <46DBF430.1050508@gmail.com>
	 <6f9550040709030503m1d0db50bo4266aed0475f951d@mail.gmail.com>
	 <6f9550040709030520q1682ca06k99a2537cae847ec6@mail.gmail.com>
	 <46DC00D8.30205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:20653 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbXIDSRd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Sep 2007 14:17:33 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2563174mue
        for <linux-ide@vger.kernel.org>; Tue, 04 Sep 2007 11:17:31 -0700 (PDT)
In-Reply-To: <46DC00D8.30205@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On 03/09/07, Tejun Heo <htejun@gmail.com> wrote:
> Eddie Hung wrote:
> > I am pursuing another possibility: the CF card is not a genuine
> > Sandisk one at all, especially as it was off eBay! I compared my
> > hdparm -I with the one in the thread above (which as I've found out is
> > a Sandisk Extreme II 4GB) and there are big differences, namely the
> > model number, serial number and firmware version.
> >
> > This might explain everything!
>
> We still need to fix your device.  :-)
>
> --
> tejun
>

Uhm.. it seems like I spoke too soon!

I have now acquired a Sandisk Extreme III 8GB CF card, from a
reputable source, but it doesn't support UDMA as the Extreme IV card
was supposed to... and this means I'm getting MWDMA again - and the
same timeout problems!

I had previously blamed the timeout problems on it being a completely
naff card which wasn't standards compliant, but now I know this can't
be the case.

Here is the hdparm:

/dev/sda:

CompactFlash ATA device, with removable media
	Model Number:       SanDisk SDCFX3-8192
	Serial Number:      019324G2207I5851
	Firmware Revision:  HDX 4.03
Standards:
	Supported: 4
	Likely used: 4
Configuration:
	Logical		max	current
	cylinders	15880	15880
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16007040
	LBA    user addressable sectors:   16007040
	device size with M = 1024*1024:        7815 MBytes
	device size with M = 1000*1000:        8195 MBytes (8 GB)
Capabilities:
	LBA, IORDY(may be)(cannot be disabled)
	Standby timer values: spec'd by Vendor
	R/W multiple sector transfer: Max = 4	Current = 0
	DMA: mdma0 mdma1 *mdma2
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	    	Write cache
	   *	CFA feature set
	   *	CFA advanced modes: pio5 *pio6

Note that it does identify PIO5 and PIO6 (answering my previous
question), with PIO6 even starred. I got about 9MB/s under hdparm,
too.

However, the timeouts remain, I triggered it again by doing a mkfs.ext3.

Any ideas?

Thanks,

Eddie
