From: Philip Armstrong <phil@kantaka.co.uk>
Subject: Re: (fwd) Re: Bug#289770: kernel-image-2.6.10-1-686: 2.6.10 fails to set up DMA on my IBM thinkpad
Date: Thu, 10 Feb 2005 20:02:01 +0000
Message-ID: <20050210200201.GA28238@kantaka.co.uk>
References: <20050111195345.GI2618@stro.at> <20050112120245.GA24839@kantaka.co.uk> <200501121352.33520.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from dsl-217-155-153-11.zen.co.uk ([217.155.153.11]:38605 "EHLO
	217.155.153.11") by vger.kernel.org with ESMTP id S261612AbVBJUCH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Feb 2005 15:02:07 -0500
Content-Disposition: inline
In-Reply-To: <200501121352.33520.bzolnier@elka.pw.edu.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: maximilian attems <debian@sternwelten.at>, linux-ide@vger.kernel.org, 289770@bugs.debian.org

On Wed, Jan 12, 2005 at 01:52:33PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 12 January 2005 13:02, Philip Armstrong wrote:
> > On Tue, Jan 11, 2005 at 08:53:45PM +0100, maximilian attems wrote:
> > > dma on a thinkpad  600E worked for 2.6.8, but didn't since 2.6.9
> > > also non working 2.6.10.
> > > 
> > > -hda: 12594960 sectors (6448 MB) w/460KiB Cache, CHS=13328/15/63, UDMA(33)
> > > +hda: 12594960 sectors (6448 MB) w/460KiB Cache, CHS=13328/15/63
> > > 
> > > could you please look at the following ide dma bug report for piix in
> > > debian -> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=289770
> > > full dmesg of both 2.6.8 and 2.6.10 are posted there.
> 
> "something" steals resource needed for IDE driver so no DMA

Further investigation reveals that turning off CONFIG_PNPBIOS solves
the problem.

With PNPBIOS set, the kernel seems to think that the io range is in
use regardless of whether quickboot is set in the BIOS or not.

cheers,

Phil

-- 
http://www.kantaka.co.uk/ .oOo. public key: http://www.kantaka.co.uk/gpg.txt
