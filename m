From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] sata_mv: fix broken DSM/TRIM support (v2)
Date: Mon, 23 Aug 2010 09:41:33 -0400
Message-ID: <1282570893.30799.1.camel@corey>
References: <1282267195.8909.6.camel@corey> <1282268444.9628.4.camel@corey>
	 <4C722FD4.2010305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:46369 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751547Ab0HWNlb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Aug 2010 09:41:31 -0400
In-Reply-To: <4C722FD4.2010305@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

On Mon, 2010-08-23 at 10:22 +0200, Tejun Heo wrote:
> On 08/20/2010 03:40 AM, Mark Lord wrote:
> > Fix DSM/TRIM commands in sata_mv (v2).
> > These need to be issued using old-school "BM DMA",
> > rather than via the EDMA host queue.
> > 
> > Since the chips don't have proper BM DMA status,
> > we need to be more careful with setting the ATA_DMA_INTR bit,
> > since DSM/TRIM often has a long delay between "DMA complete"
> > and "command complete".
> > 
> > GEN_I chips don't have BM DMA, so no TRIM for them.
> > 
> > Signed-off-by: Mark Lord <mlord@pobox.com>
..


> Don't we need this for other BMDMA commands too?  If so, maybe it's
> better to make it two patches?


TRIM is the first/only command which actually breaks
without this.  It is possible that other commands may
benefit as well on some DVD-RW drives, but I have not
encountered those yet.

So for now, I've left it as a single patch,
with all of the (small) pieces together for TRIM.

Cheers

