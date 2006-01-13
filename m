From: Rashkae <rashkae@tigershaunt.com>
Subject: Re: Fwd: ide-cd turning off DMA when verifying DVD-R
Date: Fri, 13 Jan 2006 10:51:49 -0500
Message-ID: <20060113155149.GC12360@tigershaunt.com>
References: <5ujmU-1UQ-665@gated-at.bofh.it> <5uoqr-Qq-7@gated-at.bofh.it> <43C72F41.5060207@shaw.ca> <20060113083009.GE12338@paradise.net.nz> <58cb370e0601130119g5c62b749r1bc5da59a0d4a56c@mail.gmail.com> <1137162265.4419.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from CPE0050fc332afc-CM00407b861c34.cpe.net.cable.rogers.com ([69.197.25.155]:38538
	"EHLO nuku.localdomain") by vger.kernel.org with ESMTP
	id S1422718AbWAMPvw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jan 2006 10:51:52 -0500
Content-Disposition: inline
In-Reply-To: <1137162265.4419.6.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Ondrej Zary <linux@rainbow-software.org>, Robert Hancock <hancockr@shaw.ca>, Volker Kuhlmann <list0570@paradise.net.nz>, Jens Axboe <axboe@suse.de>, linux-ide <linux-ide@vger.kernel.org>, linux-kernel@lkml.org

On Fri, Jan 13, 2006 at 02:24:25PM +0000, Alan Cox wrote:

> On Gwe, 2006-01-13 at 14:33 +0100, Bartlomiej Zolnierkiewicz wrote:
> > The patch was NACK-ed by Alan Cox and I agree with him (this should be
> > done differently).  This __ide_dma_off() chunk looks sensible but does it fix
> > the issue?  I was under impression that after a reset drive looses its DMA
> > xfer mode and needs to be reprogrammed (ATA spec has the answer).
> 
> Yes and the behaviour is determined by hdparm -k/-K. Its all a bit

Great theory, but unfortunately, as things are now, -k does not preserve DMA setting, contrary to it's documented function.

Quote from Bartlomiej Zolnierkiewicz:

AFAIR (2.5/2.6 and probably 2.4 also) it never worked w.r.t. to DMA
as documented in hdparm manual.
