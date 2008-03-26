From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: linux/libata.h/ata_busy_wait() inefficiencies?
Date: Wed, 26 Mar 2008 21:34:58 +0000
Message-ID: <20080326213458.5a391c00@core>
References: <20080325205904.GA19388@rhlx01.hs-esslingen.de>
	<47EA5999.2010500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42391 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756121AbYCZVvl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Mar 2008 17:51:41 -0400
In-Reply-To: <47EA5999.2010500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Andreas Mohr <andi@lisas.de>, linux-ide@vger.kernel.org

> > Those two tweaks alone may already be able to deliver a noticeable speedup
> > of ata operations given that this is frequently used inner libata code.
> ..

Unlikely given the fact that chk_status will be a synchronous I/O request
across the bus and on many controllers across to the device itself. Any
other optimisations get a bit irrelevant

> While you're at it, the udelay(10) should really be *much* smaller,
> or at least broken into a top/bottom pair of udelay(5).  I really suspect
> that much of the time, the status value is satisified on the first iteration,
> requiring no more than a microsecond or so.  Yet we always force it to take
> at least 10us, or about 15000 instructions worth on a modern CPU.

That depends how long after the event before the wait_for_ is called
must elapse before the status bits are valid. There is also a trade off
of bus usage - especially on older devices where we will lock the bus and
thus CPU for maybe 1-2uS *per* chk_status.

If you want performance get an AHCI controller 8)

Alan
