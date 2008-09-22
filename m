From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
Date: Mon, 22 Sep 2008 19:47:22 +0100
Message-ID: <20080922194722.11e9908e@lxorguk.ukuu.org.uk>
References: <48D51B48.2090400@ru.mvista.com>
	<20080922.235608.106262139.anemo@mba.ocn.ne.jp>
	<48D7B365.6070305@ru.mvista.com>
	<20080923.001602.51867636.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54832 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752500AbYIVSxn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 14:53:43 -0400
In-Reply-To: <20080923.001602.51867636.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: sshtylyov@ru.mvista.com, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Tue, 23 Sep 2008 00:16:02 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Mon, 22 Sep 2008 19:01:57 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > >>  BTW, how about supporting IDE aboard RBTX4938, not worth the trouble?
> > 
> > > Yes, next plan.  It should be much simpler than the tx4939ide driver.
> > 
> >     I suspect {ide|pata}_platform could be able to cover it... though I got 
> > muddled in the timing diagrams for the TX4938 external bus...
> 
> We need .set_pio_mode routine to get best PIO speed, but current
> {ide|pata}_platform driver does not provide a hook for it (please
> correct me if I was wrong).  So current code I have does not use
> ide_platform...

You are correct. The platform driver is intended to be totally dumb. It's
not clear at what point having a specific driver is more sensible as a
libata driver is tiny anyway (especially with tejuns inherited ops stuff)
