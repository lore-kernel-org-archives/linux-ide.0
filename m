From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Mon, 21 Jan 2008 16:47:44 +0000
Message-ID: <20080121164744.2f7d0ed1@lxorguk.ukuu.org.uk>
References: <200801140019.20668.g.chulkov@jacobs-university.de>
	<20080115025435.1e21b703.akpm@linux-foundation.org>
	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>
	<4794501E.90306@gmail.com>
	<20080121130256.2443d7c1@lxorguk.ukuu.org.uk>
	<47949AA4.9090601@gmail.com>
	<20080121141425.45aa9c61@lxorguk.ukuu.org.uk>
	<4794ACAF.70505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59514 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755165AbYAUQtw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 11:49:52 -0500
In-Reply-To: <4794ACAF.70505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

> Can you elaborate a bit?  I don't really think completing a command
> after 30sec timeout contributes a lot to driver stability.

Timeout, timeout, timeout, reset, timeout.. (repeat), failed I/O

This gives the end user no information about the fault, nor does it let
the upper layers of SCSI and above distinguish between a random passing
sulk and media errors which need the disk replacing.

> > Should that not then be a per host flag ?
> 
> Yeah, that would be the best.  The problem is that there are several
> different kinds of timeouts and we don't know which controller locks up
> after which timeout and investigating them is really difficult.

PATA controllers don't lock up in that case so its quite easy. The one
exception is if the device jams IORDY but in that case you are dead
anyway the next I/O (except on a SIL680 which has a timer we could use).

Old IDE says it works for PATA. For SATA I can see it might need more
care and you might simply not be able to get the info.

Alan
