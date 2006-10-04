From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Generic platform device IDE driver
Date: Thu, 5 Oct 2006 05:05:01 +0900
Message-ID: <20061004200501.GB6664@localhost.Internal.Linux-SH.ORG>
References: <20061004074535.GA7180@localhost.hsdv.com> <1159962084.25772.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:43169 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1161206AbWJDMGk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Oct 2006 08:06:40 -0400
Content-Disposition: inline
In-Reply-To: <1159962084.25772.14.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rmk@arm.linux.org.uk, gregkh@suse.de, ysato@users.sourceforge.jp

On Wed, Oct 04, 2006 at 12:41:24PM +0100, Alan Cox wrote:
> Ar Mer, 2006-10-04 am 16:45 +0900, ysgrifennodd Paul Mundt:
> > This is intended purely for the simple NO_DMA ide_generic case.. nothing
> > complicated.
> > 
> > What do people think about this, is there a better way to do this?
> 
> drivers/ide is going away over time.

That was the impression I got.

> I think the concept is nice and it's sort of reflected in the libata
> VLB drivers. I think it would be a very good way to get good platform
> drivers for libata for the embedded platforms.
> 
Ok, I wasn't sure if libata was intended for anything outside of the
SATA case (especially non-PCI), but if that's the way to go, I'll look
at hacking something up under libata.

> Moving the existing drivers/ide stuff to a new drivers/ide variant is
> wasted work however.
> 
That's what I figured, thanks for clearing it up.
