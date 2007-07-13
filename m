From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] Make the IDE DMA timeout modifiable
Date: Fri, 13 Jul 2007 16:16:12 +0100
Message-ID: <20070713161612.2f2ebb0b@the-village.bc.nu>
References: <20070221011922.GA1777@freefall.freebsd.org>
	<200702210342.20775.bzolnier@gmail.com>
	<466EEFD6.9030001@ru.mvista.com>
	<200706160123.55636.bzolnier@gmail.com>
	<4693D9B6.4090408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:34384 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S936283AbXGMPK1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 11:10:27 -0400
In-Reply-To: <4693D9B6.4090408@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Suleiman Souhlal <ssouhlal@freebsd.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

O> >>    BTW, why the timeout is so damn long? 2*WAIT_CMD is 20 secs, and if DMA is 
> >>not complete or interrupt pending, it may wait 10 more secs...
> 
> > I really don't remember... :)
> 
> > Maybe Mark or Alan could help with figuring this out.
> 
>     They also have probably forgotten. :-)

Because that value seemed to work ok. Mark set the timeouts way back in
history and I never touched most of them.

