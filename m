From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide-disk: Fix request requeuing
Date: Mon, 03 Oct 2011 14:28:31 -0400 (EDT)
Message-ID: <20111003.142831.762307541860800487.davem@davemloft.net>
References: <1317365132-9422-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:60166 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478Ab1JCS3s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Oct 2011 14:29:48 -0400
In-Reply-To: <1317365132-9422-1-git-send-email-bp@alien8.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bp@alien8.de
Cc: linux-ide@vger.kernel.org, sim@hostway.ca

From: Borislav Petkov <bp@alien8.de>
Date: Fri, 30 Sep 2011 08:45:32 +0200

> Simon Kirby reported that on his RAID setup with idedisk underneath
> the box OOMs after a couple of days of runtime. Running with
> CONFIG_DEBUG_KMEMLEAK pointed to idedisk_prep_fn() which unconditionally
> allocates an ide_cmd struct. However, ide_requeue_and_plug() can be
> called more than once per request, either from the request issue or the
> IRQ handler path and do blk_peek_request() ends up in idedisk_prep_fn()
> repeatedly, allocating a struct ide_cmd everytime and "forgetting" the
> previous pointer.
> 
> Make sure the code reuses the old allocated chunk.
> 
> Reported-and-tested-by: Simon Kirby <sim@hostway.ca>
> Cc: <stable@kernel.org> [ 39.x, 3.0.x ]
> Link: http://marc.info/?l=linux-kernel&m=131667641517919
> Link: http://lkml.kernel.org/r/20110922072643.GA27232@hostway.ca
> Signed-off-by: Borislav Petkov <bp@alien8.de>

Applied, thanks a lot.
