From: Jens Axboe <axboe@suse.de>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Fri, 16 Jul 2004 19:57:30 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040716175729.GI11255@suse.de>
References: <40F2CFDE.66D28904@verizon.net> <20040712183505.GE26789@bounceswoosh.org> <40F72B6A.6F12F454@verizon.net> <20040716070209.GC1336@suse.de> <40F7BD1D.ACC6EC93@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:28371 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266549AbUGPR6j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jul 2004 13:58:39 -0400
Content-Disposition: inline
In-Reply-To: <40F7BD1D.ACC6EC93@verizon.net>
List-Id: linux-ide@vger.kernel.org
To: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Cc: "Eric D. Mudama" <edmudama@bounceswoosh.org>, linux-ide@vger.kernel.org

On Fri, Jul 16 2004, Max T. Woodbury wrote:
> Jens Axboe wrote:
> > 
> > On Fri, Jul 16 2004, Max T. Woodbury wrote:
> > > "Eric D. Mudama" wrote:
> > > >
> > > > On Mon, Jul 12 at 13:52, Max T. Woodbury wrote:
> > > > >Still, why would PIO mode be unsafe?  (I can see slower, but I don't
> > > > >expect speed from this beast.  Oh well.  Thanks for the pointer.)
> > > >
> > > > PIO has no data integrity check, so bogus cables that glitch the data
> > > > will not be detected.  Not sure if that is what he was talking about,
> > > > but is definitely a problem for PIO.
> > >
> > > Huh? Unless something major has changed since the last time I looked at
> > > DMA hardware (and it has been a few years), DMA uses the same transfer
> > > sequence from the devices point of view as PIO.  The fact that the
> > > transfer is under the control of another device rather than a program
> > > should be transparent to the target device.  Impedance mismatches,
> > > reflections and constructive and destructive interference caused by
> > > cable problems don't care about who's in control of the busses.
> > >
> > > I can see a possible problem with cache consistency causing problems
> > > with PIO, but there are similar (abet in some sense inverted or
> > > reversed) problems with DMA.
> > 
> > Yes that's very clever of you. But read what Eric writes - PIO has no
> > data integrity check. DMA transfers are crc'ed so you know if something
> > goes bad between device and host in the data phase, with PIO you do not.
> 
> Sorry, NO.  From the device point of view, DMA and PIO are
> indistinguishable.

That's nonsense. Even the commands are different.

> Both have CRCs on some busses and neither have CRCs on others.  There
> are ALWAYS CRCs on transfers across the drive interface cables.  This
> is controlled by the IDE/CPU interface chip and not by the DMA
> hardware.  The transfer of the CRC is triggered by the termination of
> data transfer which happens with both DMA and PIO.  These are design
> issues that go back at least thirty years and are generally well
> understood.

So the icrc bit is where on the non-dma read commands? I repeat, if you
are in pio mode, you will not notice crc differences in data transferred
between host and device.

-- 
Jens Axboe

