From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: Re: (fwd) Re: Bug#289770: kernel-image-2.6.10-1-686: 2.6.10 fails to set up DMA on my IBM thinkpad
Date: Wed, 12 Jan 2005 13:52:33 +0100
Message-ID: <200501121352.33520.bzolnier@elka.pw.edu.pl>
References: <20050111195345.GI2618@stro.at> <20050112120245.GA24839@kantaka.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:35807 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261177AbVALMyD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Jan 2005 07:54:03 -0500
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:52668 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S27490AbVALMxT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jan 2005 13:53:19 +0100
In-Reply-To: <20050112120245.GA24839@kantaka.co.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philip Armstrong <phil@kantaka.co.uk>
Cc: maximilian attems <debian@sternwelten.at>, linux-ide@vger.kernel.org, 289770@bugs.debian.org

On Wednesday 12 January 2005 13:02, Philip Armstrong wrote:
> On Tue, Jan 11, 2005 at 08:53:45PM +0100, maximilian attems wrote:
> > dma on a thinkpad  600E worked for 2.6.8, but didn't since 2.6.9
> > also non working 2.6.10.
> > 
> > -hda: 12594960 sectors (6448 MB) w/460KiB Cache, CHS=13328/15/63, UDMA(33)
> > +hda: 12594960 sectors (6448 MB) w/460KiB Cache, CHS=13328/15/63
> > 
> > could you please look at the following ide dma bug report for piix in
> > debian -> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=289770
> > full dmesg of both 2.6.8 and 2.6.10 are posted there.

"something" steals resource needed for IDE driver so no DMA

> Incidentally, this may be the same bug as Debian bug #284558:
> 
>   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=284558
> 
> which involves more recent PIIX hardware.

this one is an user error, ide_generic driver shouldn't be used
at the same time as piix driver
