From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: H8/300 target support patch
Date: Tue, 17 Feb 2004 09:07:23 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1076969243.1046.58.camel@gaston>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp>
	 <200402151540.56377.bzolnier@elka.pw.edu.pl>
	 <m265e7dn02.wl%ysato@users.sourceforge.jp>
	 <200402161740.08383.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:28577 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265934AbUBPWHz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2004 17:07:55 -0500
In-Reply-To: <200402161740.08383.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-ide@vger.kernel.org

On Tue, 2004-02-17 at 03:40, Bartlomiej Zolnierkiewicz wrote:
> On Monday 16 of February 2004 17:09, Yoshinori Sato wrote:
> > > +static void _outsw(unsigned long addr, void *buf, u32 len)
> > > +{
> > > +	unsigned volatile short *ap = (unsigned volatile short *)addr;
> > > +	unsigned short *bp = (unsigned short *)buf;
> > > +	unsigned short d;
> > > +	while(len--) {
> > > +		d = *bp++;
> > > +		*ap = (d << 8) | (d >> 8);
> > > +	}
> > > +}
> > > +
> > > +static void _insw(unsigned long addr, void *buf, u32 len)
> > > +{
> > > +	unsigned volatile short *ap = (unsigned volatile short *)addr;
> > > +	unsigned short *bp = (unsigned short *)buf;
> > > +	unsigned short d;
> > > +	while(len--) {
> > > +		d = *ap;
> > > +		*bp++ = (d << 8) | (d >> 8);
> > > +	}
> > > +}
> > >
> > > why you don't use outsw() and insw() from include/asm-h8300/io.h?
> >
> > Because bus turns over, insw/outsw is not usable.
>
> Please explain.  I don't understand why outsw()/insw()
> from io.h can't be assigned to hwif->OUTSW/hwif->INSW.

I'd add that the above code is incredibely shitty... Whatever the HW
does, this is not how it should be implemented.


