From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 17:11:19 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092759070.22794.38.camel@localhost.localdomain>
References: <20040815151346.GA13761@devserv.devel.redhat.com>
	 <200408171512.26568.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:33769 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268342AbUHQRNq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Aug 2004 13:13:46 -0400
In-Reply-To: <200408171512.26568.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org

On Maw, 2004-08-17 at 14:12, Bartlomiej Zolnierkiewicz wrote:
> > +			if (g->irq == hwif->irq)
> > +				++irq_count;
> > +			g = g->next;
> > +		} while (g != hwgroup->hwif);
> > +	}
> > +	spin_unlock_irq(&ide_lock);
> 
> new race(s) here because of not holding ide_cfg_sem anylonger,
> see init_irq() in ide-probe.c and ide_cfg_sem comments in ide.h

Double checked. No race. ide_cfg_sem is held over the whole 
ide_unregister path.


