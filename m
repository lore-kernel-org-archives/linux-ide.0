From: Marc Singer <elf@buici.com>
Subject: Re: overriding ioops
Date: Sat, 5 Jun 2004 15:25:35 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040605222535.GB16309@buici.com>
References: <20040605201953.GA14917@buici.com> <200406052242.19060.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:30359 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262106AbUFEWZg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Jun 2004 18:25:36 -0400
Content-Disposition: inline
In-Reply-To: <200406052242.19060.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Sat, Jun 05, 2004 at 10:42:19PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Saturday 05 of June 2004 22:19, Marc Singer wrote:
> > I know that you me to do this differently that I did in 2.6.4.  I need
> > to override the hwif->OUTB (et, all) functions.  Do I implement my own
> > version of the default_hwif_ function?
> 
> No, arch specific code shouldn't touch generic one.
> Your host driver should take care of this.
> 
> If you need some changes in generic code please describe them
> and I'll try to fix/enhance it.
> 
> [ I know about polling but this is really non trivial change as i.e.
>   we have 4 versions of IDE PIO code (!) - I'm cleaning this mess now. ]

I wonder if we're talking about the same thing.  My platform does not
have DMA nor does it have an IRQ.  PIO, as I understand it, refers to
programmed IO and not to polling proper.  Do you intend to support
polling?
