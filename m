From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sun, 16 May 2004 21:33:30 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405162133.30859.bzolnier@elka.pw.edu.pl>
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <200405151958.03322.bzolnier@elka.pw.edu.pl> <20040516005146.GB23743@buici.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6877 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264801AbUEPTb2
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 15:31:28 -0400
In-Reply-To: <20040516005146.GB23743@buici.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marc Singer <elf@buici.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 16 of May 2004 02:51, Marc Singer wrote:
> On Sat, May 15, 2004 at 07:58:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > - host drivers should request/release IO resource
> > > >   themelves and set hwif->mmio to 2
> > >
> > > Don't you mean, hwif->mmio==2 for MMIO hardware?
> >
> > It is was historically for MMIO, now it means that driver
> > handles IO resource itself (per comment in <linux/ide.h>).
>
> If you are talking about this
>
>         int             mmio;           /* hosts iomio (0) or custom (2)
> select
>
> do you really think that's enough?

No and I didn't say this.  I tried to describe current state of affairs.
Don't blame me for cryptic comments in <linux/ide.h>.

