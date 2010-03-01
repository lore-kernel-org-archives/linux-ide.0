From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/3] ide: move dcache flushing to generic ide code
Date: Sun, 28 Feb 2010 18:34:17 -0800 (PST)
Message-ID: <20100228.183417.52179576.davem@davemloft.net>
References: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
	<1267371341-16684-4-git-send-email-sebastian@breakpoint.cc>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59191
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753867Ab0CACd7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Feb 2010 21:33:59 -0500
In-Reply-To: <1267371341-16684-4-git-send-email-sebastian@breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sebastian@breakpoint.cc
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org, linux-ide@vger.kernel.org

From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Date: Sun, 28 Feb 2010 16:35:41 +0100

> the pio callbacks are called with different kind of buffers. It could be
> a straight kernel addr, kernel stack or a kmaped highmem page.
> Some of this break the virt_to_page() assumptions.
> This patch moves the dcache flush from architecture code into generic
> ide code. ide_pio_bytes() is the only place where user pages might be
> written as far as I can see.
> The dcache flush is avoided in two cases:
> - data which is written to the device (i.e. they are comming from the
>   userland)

This needs a flush on sparc, otherwise an alias now exists in the
kernel side copy of the buffer.  The D-cache flush is intentionally
unconditional for PIO mode.  I definitely don't want to take the same
risks you guys seem to be willing to take for this optimization which
is of questionable value.

I also, intrinsically, really don't like these changes.

For one thing, you're optimizing PIO mode.

Secondly, IDE is in deep maintainence mode, if you want to optimize
cache flushing do it in the ATA layer.

Thanks.
