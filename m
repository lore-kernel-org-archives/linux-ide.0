From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
Date: Tue, 23 Sep 2008 00:16:02 +0900 (JST)
Message-ID: <20080923.001602.51867636.anemo@mba.ocn.ne.jp>
References: <48D51B48.2090400@ru.mvista.com>
	<20080922.235608.106262139.anemo@mba.ocn.ne.jp>
	<48D7B365.6070305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:54202 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbYIVPPn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Sep 2008 11:15:43 -0400
In-Reply-To: <48D7B365.6070305@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Mon, 22 Sep 2008 19:01:57 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>  BTW, how about supporting IDE aboard RBTX4938, not worth the trouble?
> 
> > Yes, next plan.  It should be much simpler than the tx4939ide driver.
> 
>     I suspect {ide|pata}_platform could be able to cover it... though I got 
> muddled in the timing diagrams for the TX4938 external bus...

We need .set_pio_mode routine to get best PIO speed, but current
{ide|pata}_platform driver does not provide a hook for it (please
correct me if I was wrong).  So current code I have does not use
ide_platform...

---
Atsushi Nemoto
