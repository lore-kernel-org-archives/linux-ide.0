From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 22:40:47 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408172240.47646.bzolnier@elka.pw.edu.pl>
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171512.26568.bzolnier@elka.pw.edu.pl> <1092759070.22794.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16568 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268420AbUHQUlv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2004 16:41:51 -0400
In-Reply-To: <1092759070.22794.38.camel@localhost.localdomain>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Tuesday 17 August 2004 18:11, Alan Cox wrote:
> On Maw, 2004-08-17 at 14:12, Bartlomiej Zolnierkiewicz wrote:
> > > +			if (g->irq == hwif->irq)
> > > +				++irq_count;
> > > +			g = g->next;
> > > +		} while (g != hwgroup->hwif);
> > > +	}
> > > +	spin_unlock_irq(&ide_lock);
> >
> > new race(s) here because of not holding ide_cfg_sem anylonger,
> > see init_irq() in ide-probe.c and ide_cfg_sem comments in ide.h
>
> Double checked. No race. ide_cfg_sem is held over the whole
> ide_unregister path.

?
