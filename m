From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 16/86] pata_efar: MWDMA0 is unsupported
Date: Thu, 26 Nov 2009 17:29:46 +0100
Message-ID: <200911261729.46700.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200911261640.39208.bzolnier@gmail.com> <4B0EA9FC.1000208@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:47429 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbZKZQav (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 11:30:51 -0500
In-Reply-To: <4B0EA9FC.1000208@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 26 November 2009 05:17:00 pm Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>>>>MWDMA0 timings cannot be met with the PIIX based controller
> >>>>>>programming interface.
> 
> >>>>>The efar documentation makes no reference to not being capable of MWDMA0,
> >>>>>so where does this come from ? No MWDMA0 is an Intel erratum it appears.
> 
> >>>>No MWDMA0 support is a common issue on all 'PIIX-like' controllers.
> 
> >>>>In case of this chipset while the (preliminary) documentation claims MWDMA0
> >>>>support on the 'FEATURES' page the later 'programming guide' part describes
> >>>>only PIO0-4, SWDMA2, MWDMA1-2 and UDMA0-4 transfer modes as supported.
> 
> >>>Cool - I only have the original docs.
> 
> >>    Hm, me too... perhaps worth putting in Jeff's documentation archive?
> 
> > Me too?  I just have what 'The Good Uncle Google' has..
> 
>     Well, I've googled for it and was unable to find any valid links even to 
> my preliminary version anymore. Perhaps I haven't looked hard enough...

Maybe... ;)

FWIW my file is called 38384_SMSC_SLC90E66.pdf

--
Bartlomiej Zolnierkiewicz
