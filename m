From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: H8/300 target support patch
Date: Sat, 28 Feb 2004 18:55:15 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402281855.15611.bzolnier@elka.pw.edu.pl>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp> <200402262026.51202.bzolnier@elka.pw.edu.pl> <m2brnj3zop.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:23742 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261880AbUB1RsT
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Feb 2004 12:48:19 -0500
In-Reply-To: <m2brnj3zop.wl%ysato@users.sourceforge.jp>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

On Saturday 28 of February 2004 18:02, Yoshinori Sato wrote:
> At Thu, 26 Feb 2004 20:26:51 +0100,
>
> Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 26 of February 2004 17:46, Yoshinori Sato wrote:
> > > At Sun, 22 Feb 2004 18:28:18 +0100,
> > >
> > > Bartlomiej Zolnierkiewicz wrote:
> > > > On Sunday 22 of February 2004 18:08, Bartlomiej Zolnierkiewicz wrote:
> > > > > > I corrected it to initialize it with ide_init_default_hwifs.
> > > > > > A correction of ide.c becomes needless.
> > > > >
> > > > > NO!!!  ide_init_default_hwifs() should DIE!
> > > > > The same goes for ide_default_{irq,io_base}().
> > > > >
> > > > > They are not needed - you have driver(s) for H8/300 IDE
> > > > > controllers!
> > > >
> > > > It should be like that:
> > > >
> > > > You should have host drivers for your IDE controllers,
> > > > not inline functions for ide.c and ide-probe.c.
> > >
> > > I tuned to a driver of PC/AT wherever practicable.
> >
> > Just because original/legacy PC/AT driver is braindamaged (and dated)
> > doesn't mean your code should be, does it?  Hiding driver's code into
> > asm/ide.h causes MAJOR problems for IDE code reorganization.
> >
> > > Examination is necessary for a call method of h8300_hwif_iops.
> >
> > All ide-iops.c #ifdef-s won't be needed if you separate you driver
> > properly from asm/ide.h (thus overriding default_hwif_iops() ops
> > by ones used by your driver).
> >
> > Please revert to putting your code into ide/h8300/.
>
> I did overriding of default_hwif_iops in form to replace obj because
> it was not possible well.
>
> It is difference m with linux-2.6.4-rc1.

This change won't be needed if you correct your driver as asked.
BTW Your patch re-adds recently deleted unplugged_hwif_iops for no reason.

> Do not change asm/ide.h.

Please correct your patch to not abuse asm/ide.h (ide_init_default_hwifs(),
ide_default_irq() and ide_default_io_base() needs to die).

Cheers,
Bartlomiej

