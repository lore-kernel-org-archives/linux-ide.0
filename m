From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/2] TXx9: Add TX4939 ATA support (v2)
Date: Mon, 22 Sep 2008 23:56:08 +0900 (JST)
Message-ID: <20080922.235608.106262139.anemo@mba.ocn.ne.jp>
References: <20080918.001358.08318211.anemo@mba.ocn.ne.jp>
	<48D51B48.2090400@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:59434 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbYIVOzr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Sep 2008 10:55:47 -0400
In-Reply-To: <48D51B48.2090400@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Sat, 20 Sep 2008 19:48:24 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Add a helper routine to register tx4939ide driver and use it on
> > RBTX4939 board.
> 
>   BTW, how about supporting IDE aboard RBTX4938, not worth the trouble?

Yes, next plan.  It should be much simpler than the tx4939ide driver.

---
Atsushi Nemoto
