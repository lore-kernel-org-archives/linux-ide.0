From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: H8/300 target support patch
Date: Thu, 26 Feb 2004 20:26:51 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402262026.51202.bzolnier@elka.pw.edu.pl>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp> <200402221828.18830.bzolnier@elka.pw.edu.pl> <m27jy9okjg.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47355 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262993AbUBZTUU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Feb 2004 14:20:20 -0500
In-Reply-To: <m27jy9okjg.wl%ysato@users.sourceforge.jp>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

On Thursday 26 of February 2004 17:46, Yoshinori Sato wrote:
> At Sun, 22 Feb 2004 18:28:18 +0100,
>
> Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 22 of February 2004 18:08, Bartlomiej Zolnierkiewicz wrote:
> > > > I corrected it to initialize it with ide_init_default_hwifs.
> > > > A correction of ide.c becomes needless.
> > >
> > > NO!!!  ide_init_default_hwifs() should DIE!
> > > The same goes for ide_default_{irq,io_base}().
> > >
> > > They are not needed - you have driver(s) for H8/300 IDE controllers!
> >
> > It should be like that:
> >
> > You should have host drivers for your IDE controllers,
> > not inline functions for ide.c and ide-probe.c.
>
> I tuned to a driver of PC/AT wherever practicable.

Just because original/legacy PC/AT driver is braindamaged (and dated)
doesn't mean your code should be, does it?  Hiding driver's code into
asm/ide.h causes MAJOR problems for IDE code reorganization.

> Examination is necessary for a call method of h8300_hwif_iops.

All ide-iops.c #ifdef-s won't be needed if you separate you driver
properly from asm/ide.h (thus overriding default_hwif_iops() ops
by ones used by your driver).

Please revert to putting your code into ide/h8300/.

Thanks.

