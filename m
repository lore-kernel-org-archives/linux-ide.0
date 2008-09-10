From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Thu, 11 Sep 2008 00:12:58 +0900 (JST)
Message-ID: <20080911.001258.07457550.anemo@mba.ocn.ne.jp>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<20080909174459.2aa9808a@lxorguk.ukuu.org.uk>
	<48C6AD7E.10005@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:49560 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754081AbYIJPMx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Sep 2008 11:12:53 -0400
In-Reply-To: <48C6AD7E.10005@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: alan@lxorguk.ukuu.org.uk, linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Tue, 09 Sep 2008 21:08:14 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>+#define TX4939IDE_BASE(hwif)	((hwif)->io_ports.data_addr & ~0xfff)
> 
> > Why do you have void __iomem casts all over the write methods not in the
> > _BASE() method - that would let sparse do its job properly
> 
>     I don't get why there's need for & at all -- isn't IDE data register 
> address always on 4K boundary?

On little endian, yes.  On big endian, this controller flips addr[2:0].

---
Atsushi Nemoto
