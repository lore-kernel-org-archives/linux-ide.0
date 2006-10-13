From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Generic platform device IDE driver
Date: Fri, 13 Oct 2006 21:28:24 +0900
Message-ID: <20061013122824.GA26705@linux-sh.org>
References: <20061004074535.GA7180@localhost.hsdv.com> <1159972725.25772.26.camel@localhost.localdomain> <20061005091631.GA8631@localhost.hsdv.com> <200610111450.41909.matthias.fuchs@esd-electronics.com> <20061012061348.GA7844@linux-sh.org> <20061013075219.GA28654@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751653AbWJMM2o@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061013075219.GA28654@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

On Fri, Oct 13, 2006 at 08:52:19AM +0100, Russell King wrote:
> On Thu, Oct 12, 2006 at 03:13:48PM +0900, Paul Mundt wrote:
> > Yes, that's one thing I was thinking of as well.. Here's a patch that
> > makes an attempt at that, can you give it a try and see if it works for
> > you? This applies on top of the earlier patch. None of the ARM, SH, or
> > H8300 cases need to do the remapping at least.
> 
> It's likely that ARM will switch over to using the MMIO resources if
> this patch makes it in.  There's certain ARM platforms which would
> benefit from this change (since inb() and friends are more complex
> than they necessarily need to be.)
> 
> However, one issue needs to be solved before we could do that - how do
> we handle the case where the IDE registers are on a 4 byte spacing
> interval instead of the usual 1 byte?
> 
We could solve this in the driver, but it sounds like this is something
that libata should have some visibility of directly.

> I notice that this driver is calling ata_std_ports() which handles
> the standard setup.  Maybe that needs to become a little more inteligent?
> 
If we go this route, I suppose the easiest option will be simply to have
a private structure with a few function pointers for these sorts of
things, or we can simply have an element for the spacing interval if you
don't forsee needing to change the ioaddrs in any fashion beyond the
register spacing.. Which approach would you be more comfortable with?
Are there any other items that you're concerned with in the current
driver?

Thanks for the feedback!
