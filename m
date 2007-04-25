From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.21-rc7-mm1 BUG at kernel/sched-clock.c:175
 init_sched_clock()
Date: Wed, 25 Apr 2007 11:35:22 +0100
Message-ID: <20070425113522.593cbaa3@the-village.bc.nu>
References: <462E4C4D.9020806@gmail.com>
	<20070425011654.222a2b4b.akpm@linux-foundation.org>
	<462F1481.8010807@gmail.com>
	<20070425085432.GD17130@htj.dyndns.org>
	<20070425112533.19d4a1aa@the-village.bc.nu>
	<462F2C86.7030009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34525 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992549AbXDYKbu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 06:31:50 -0400
In-Reply-To: <462F2C86.7030009@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Berck E. Nash" <flyboy@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

> > (and yes this happens on dual P3 boxes - NE2K has some fantastic bugs at
> > one point due to this)
> 
> I think the second patch should work regardless of IRQ posting.  No?

I believe so providing the IRQ handler tries to clear the cause of the
IRQ.

Alan
