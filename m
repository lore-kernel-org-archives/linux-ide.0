From: Sander <sander@humilis.net>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Tue, 21 Mar 2006 21:44:35 +0100
Message-ID: <20060321204435.GE25066@favonius>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca> <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca> <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org> <20060321191547.GC20426@favonius> <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ookhoi.xs4all.nl ([213.84.114.66]:59276 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932367AbWCUUoi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 15:44:38 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sander <sander@humilis.net>, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Linus Torvalds wrote (ao):
> > I was not able to let 2.6.16-rc6-mm2 crash yet.
> > 
> > I'll test 2.6.16-rc6-mm1 now.
> 
> Yup, narrowing down where exactly things go south is the way to do it.

2.6.16-rc6-mm1 is as stable as 2.6.16-rc6-mm2 with my simple testcase.

Is there a quick patch to suspect, or should I narrow down some more per
Andrew's instructions?

-- 
Humilis IT Services and Solutions
http://www.humilis.net
