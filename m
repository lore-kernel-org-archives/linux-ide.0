From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Date: Sun, 13 Jun 2004 20:01:44 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406132001.44262.bzolnier@elka.pw.edu.pl>
References: <E1BZQSC-0006vd-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42697 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265230AbUFMR54
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Jun 2004 13:57:56 -0400
In-Reply-To: <E1BZQSC-0006vd-00@gondolin.me.apana.org.au>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, Christoph Hellwig <hch@infradead.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 13 of June 2004 10:35, Herbert Xu wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> > On Fri, Jun 11, 2004 at 05:50:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >> Probably some drivers are still missed because I changed only
> >> these drivers that I knew that there are PCI cards using them.
> >>
> >> If you know about PCI cards using other drivers please speak up.
> >
> > IMHO the PCI ->probe methods should always be __devinit.  It's rather
> > hard to make sure they're never every hotplugged in any way, especially
> > with the dynamic id adding via sysfs thing.
>
> Well the reason I made them all __devinit in my patch is because it
> also tries to maintain the same PCI probing order as a builtin kernel
> when IDE is built as a module.
>
> To do that all the PCI driver modules are loaded before probing takes
> place.  Therefore if any probing funciton is declared as __init then
> this will not work.

This makes ordering of IDE devices different in Debian-2.6
and vanilla 2.4/2.6, doesn't sound like a good thing to do.

Ideally ordering should be controlled by user-space. :-)

BTW ide-generic.c is a very wrong place to add ide_scan_pcibus() call

Cheers.

> Cheers,

