From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 25/64] ide: use standard timing for XFER_PIO_SLOW mode
 in ide_timing_compute()
Date: Tue, 19 Jan 2010 11:30:24 -0800 (PST)
Message-ID: <20100119.113024.20311861.davem@davemloft.net>
References: <20100118171729.14623.46024.sendpatchset@localhost>
	<20100119.012526.203639880.davem@davemloft.net>
	<201001191609.42582.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37831
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752146Ab0ASTaP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 14:30:15 -0500
In-Reply-To: <201001191609.42582.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Tue, 19 Jan 2010 16:09:42 +0100

> Here is a bonus fixup for a small issue noticed by Sergei yesterday.
> 
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: ide_timing_compute() fixup
> 
> XFER_SW_DMA_0 mode should be excluded from the extended cycle
> timing computations.
> 
> [ This is just a documentation fix -- code inside the affected
>   'if' block already makes sure to accept only PIO modes. ]
> 
> Noticed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Applied, thanks Bart.
