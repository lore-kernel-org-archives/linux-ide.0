From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v3)
Date: Fri, 17 Oct 2008 01:31:01 +0900 (JST)
Message-ID: <20081017.013101.128619577.anemo@mba.ocn.ne.jp>
References: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>
	<48F7391D.8050109@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:53673 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754353AbYJPQa4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Oct 2008 12:30:56 -0400
In-Reply-To: <48F7391D.8050109@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Thu, 16 Oct 2008 16:52:45 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
>    Mostly ACK but there's still a few minor nits...

Welcome back!  I will address all of your points except for followings.

> > +			xcount = bcount & 0xffff;
> > +			if (xcount == 0x0000) {
> >   
> 
>    Hm, I'm not sure this is necessary here... although I didn't see an 
> explicit mention that zero count means 64 KB in the datasheet -- which 
> it must mean if the BMIDE spec. was followed).
> In ide-dma.c this check was added because of CS5530's brain damage...

Hmm, if I could test this case easily I will drop this.  Otherwise I
will keep it as is for future investigation.

> > +	if ((dma_stat & 7) == 0 &&
> > +	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
> > +	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
> 
>    Parens around & and | are hardly needed...

You mean more parens are needed?

---
Atsushi Nemoto
