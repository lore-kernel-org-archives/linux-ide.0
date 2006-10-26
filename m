From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] ata: Generic platform_device libata driver, take 2.
Date: Thu, 26 Oct 2006 10:42:23 +0900
Message-ID: <20061026014223.GA4813@linux-sh.org>
References: <20061023065907.GA22029@linux-sh.org> <20061023164220.GA24471@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:32997 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S965266AbWJZBmt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Oct 2006 21:42:49 -0400
Content-Disposition: inline
In-Reply-To: <20061023164220.GA24471@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>, Matthias Fuchs <matthias.fuchs@esd-electronics.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 05:42:21PM +0100, Russell King wrote:
> On Mon, Oct 23, 2006 at 03:59:07PM +0900, Paul Mundt wrote:
> > This is the second attempt at a generic platform_device libata driver,
> > attempting to take in to account issues raised by Matthias Fuchs and rmk.
> > 
> > Changes in this version include adding a small pata_platform.h header for
> > the private data (which at the moment is limited to a register shift
> > that's needed by ARM), though other things can be added in here if
> > platforms start having other needs.
> 
> Thanks, this will enable me to use this code on ARM.
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
Andrew, can you add this to -mm? No one has raised any other objections
to this particular patch, and without it, IDE on most SH boards is a
no-go.
