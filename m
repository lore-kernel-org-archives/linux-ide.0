From: David Miller <davem@davemloft.net>
Subject: Re: [Bug 14310] [bisected] 2.6.31 regression sis5513 PIO Mode 0
 hang
Date: Fri, 06 Nov 2009 04:52:04 -0800 (PST)
Message-ID: <20091106.045204.64357638.davem@davemloft.net>
References: <bug-14310-11633@http.bugzilla.kernel.org/>
	<200910270835.n9R8ZRB2007651@demeter.kernel.org>
	<200911051654.27880.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46883
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758875AbZKFMvj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Nov 2009 07:51:39 -0500
In-Reply-To: <200911051654.27880.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Thu, 5 Nov 2009 16:54:27 +0100

> The problem is that the change in the debug patch affects all host drivers
> and at this moment is not safe enough neither for -stable nor for -rc.
> 
> Somebody needs to go and review all host drivers and their usage of ->media
> field for tuning logic present in ->set_pio_mode implementations first.

The drivers which do this are:

drivers/ide/alim15x3.c
drivers/ide/it8172.c
drivers/ide/it8213.c
drivers/ide/pdc202xx_old.c
drivers/ide/piix.c
drivers/ide/qd65xx.c
drivers/ide/sis5513.c
drivers/ide/slc90e66.c

While the majority of them seem to use it to decide whether to enable
prefetching or not, alim15x3.c uses the ->media value to decide
whether to turn on the ATA or the ATAPI FIFO.

I don't think it's safe to call ->set_pio_mode() until we actually
know the media type.

I suppose we could guard the prefetch/FIFO changes in these drivers
with a test like:

	if (!(hwif->port_flags & IDE_PFLAG_PROBING))

or something like that.

But in this stage of the game, it's just too risky and reverting
the early PIO0 commit is the best way to go.

I'll do that now.
