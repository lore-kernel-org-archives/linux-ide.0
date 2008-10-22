From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v5)
Date: Thu, 23 Oct 2008 01:00:55 +0900 (JST)
Message-ID: <20081023.010055.128619796.anemo@mba.ocn.ne.jp>
References: <20081020.212701.59651580.anemo@mba.ocn.ne.jp>
	<48FDFE89.5030501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:65275 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbYJVQAq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 12:00:46 -0400
In-Reply-To: <48FDFE89.5030501@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Tue, 21 Oct 2008 20:08:41 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
>     I'm inclined to ACK the driver (besides, TX49xx patches are
> holding up my own series of patches since it needs to modify both
> these drivers) but I'm not sure about the error cleanup path now
> that I looked at it again -- probably' devres' handles all that
> automagically but peering into the sources didn't enlignten me on
> how it does it, so I would like to be explicitly assured. :-)

Yes, devres do it, as written in Documentation/driver-model/devres.txt.

If in doubt, 'probe_failed:' label in drivers/base/dd.c:really_probe()
is probably where you want to look at :-)

>     There are also some nits, mostly ignorable...

OK, I will send v6 patch which fixes most of them.

> > +	tx4939ide_writew(0x0008, base, TX4939IDE_Lo_Burst_Cnt);
> > +	tx4939ide_writew(0, base, TX4939IDE_Up_Burst_Cnt);
> 
>     I think that these fit better to tx4939ide_init_dma().

Unfortunately (and surprisingly) this did not work.  The kernel
crashed with strange memory corruption.  It seems Burst_Cnt must be
initialized before any transfer including PIO.  I don't know why...

>     Same question about the error cleanup here -- will the acquired resources 
> be auto-released? If so, then:
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Yes.  So I will send v6 patch with your Acked-by line.  Thank you very
much!

---
Atsushi Nemoto
