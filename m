From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] ide update
Date: Fri, 19 Aug 2005 11:02:53 +0200
Message-ID: <58cb370e0508190202b0c5a5a@mail.gmail.com>
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
	 <1124406535.20755.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.204]:18911 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932554AbVHSJCz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Aug 2005 05:02:55 -0400
Received: by nproxy.gmail.com with SMTP id x37so156582nfc
        for <linux-ide@vger.kernel.org>; Fri, 19 Aug 2005 02:02:54 -0700 (PDT)
In-Reply-To: <1124406535.20755.12.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/19/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2005-08-18 at 23:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> > +     },{     /* 14 */
> > +             .name           = "Revolution",
> > +             .init_hwif      = init_hwif_generic,
> > +             .channels       = 2,
> > +             .autodma        = AUTODMA,
> > +             .bootable       = OFF_BOARD,
> >       }
> 
> This seems rather odd - the driver asks for AUTODMA yet because its IDE
> generic contains no code to retune the device interface for DMA ?

It is fine, grep drivers/ide/setup-pci.c for "d->autodma".
You are confusing 'autodma' fields in ide_hwif_t and ide_pci_device_t.

> BTW whats the status on the CS5535 driver that someone submitted a while
> back ?

lkml.org/lkml/2005/1/27/20

AFAIK CS5535 driver was never ported to 2.6.x.  Somebody needs to
port it to 2.6.x kernel, cleanup to match kernel coding standards and test.

Bartlomiej
