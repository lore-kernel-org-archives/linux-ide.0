From: Marcin Kuk <marcin@laptek.servix>
Subject: Re: (fwd) Re: Bug#289770: kernel-image-2.6.10-1-686: 2.6.10 fails to set up DMA on my IBM thinkpad
Date: Fri, 11 Feb 2005 07:55:15 +0100
Message-ID: <20050211065514.GA628@laptek.servix>
References: <20050111195345.GI2618@stro.at> <20050112120245.GA24839@kantaka.co.uk> <200501121352.33520.bzolnier@elka.pw.edu.pl> <20050210200201.GA28238@kantaka.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.wp.pl ([212.77.101.1]:34987 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S262201AbVBKGzc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Feb 2005 01:55:32 -0500
Content-Disposition: inline
In-Reply-To: <20050210200201.GA28238@kantaka.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philip Armstrong <phil@kantaka.co.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 08:02:01PM +0000, Philip Armstrong wrote:
> On Wed, Jan 12, 2005 at 01:52:33PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 12 January 2005 13:02, Philip Armstrong wrote:
> > > On Tue, Jan 11, 2005 at 08:53:45PM +0100, maximilian attems wrote:
> > > > dma on a thinkpad  600E worked for 2.6.8, but didn't since 2.6.9
> > > > also non working 2.6.10.
> > > > 
> > > > -hda: 12594960 sectors (6448 MB) w/460KiB Cache, CHS=13328/15/63, UDMA(33)
> > > > +hda: 12594960 sectors (6448 MB) w/460KiB Cache, CHS=13328/15/63
> > > > 
> > > > could you please look at the following ide dma bug report for piix in
> > > > debian -> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=289770
> > > > full dmesg of both 2.6.8 and 2.6.10 are posted there.
> > 
> > "something" steals resource needed for IDE driver so no DMA
> 
> Further investigation reveals that turning off CONFIG_PNPBIOS solves
> the problem.
> 
> With PNPBIOS set, the kernel seems to think that the io range is in
> use regardless of whether quickboot is set in the BIOS or not.

I have Toshiba Satellite 320CDT.
I compiled 2.6.10 vanilla kernel with CONFIG_PNPBIOS disabled.
All IDE drivers was compiled into the kernel.
I can't still enable DMA for my harrddisk.
This is my earlier crying:

http://marc.theaimsgroup.com/?t=110789166000004&r=1&w=2

What can I do?

Best regards

-- 
Marcin Kuk
