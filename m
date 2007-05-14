From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/7] libata: move and reduce locking to the pio data
 xfer functions
Date: Mon, 14 May 2007 12:29:02 +0100
Message-ID: <20070514122902.6eee494f@the-village.bc.nu>
References: <463EAB4D.3000309@tw.ibm.com>
	<463ED8B9.4060501@gmail.com>
	<463F0B25.40103@tw.ibm.com>
	<463F0DAD.5060307@gmail.com>
	<463F1374.1010100@tw.ibm.com>
	<463F1509.30100@gmail.com>
	<46405F50.5090901@tw.ibm.com>
	<20070508130025.7693980c@the-village.bc.nu>
	<464066A4.1010008@gmail.com>
	<20070508132046.70a4d9ed@the-village.bc.nu>
	<46406C9A.4000802@gmail.com>
	<20070508134540.509f4704@the-village.bc.nu>
	<464073B1.80303@gmail.com>
	<4644192A.8090809@tw.ibm.com>
	<46441CA9.4030109@tw.ibm.com>
	<46447FB5.3040306@gmail.com>
	<20070511155504.37e12a12@the-village.bc.nu>
	<46448469.7070704@gmail.com>
	<20070511161252.14b61207@the-village.bc.nu>
	<4644885B.3050006@gmail.com>
	<20070511163953.5060c670@the-village.bc.nu>
	<4644A109.6010704@gmail.com>
	<20070511184651.0543d5ac@the-village.bc.nu>
	<4644AD91.3000600@gmail.com>
	<20070511230017.5905b10b@the-village.bc.nu>
	<46481CAB.50405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46407 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755674AbXENLZD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 07:25:03 -0400
In-Reply-To: <46481CAB.50405@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Mark Lord <liml@rtr.ca>

> Yeah, it's not a water-tight solution.  I don't think we can do that
> with IRQ enabled during transfer.  So, we can have either highly jerky
> but reliable system if PIO is used or usually better behaving PIO with
> some chance of getting nobody-cared.  Also, we can flag known buggy
> devices/controllers such that IRQ is disabled over PIO by default.  I
> think it's worth doing but this definitely should be debated better.

Which leaves us back at enable/disable_irq as with the old IDE - which
*are* much better because most of the time the IRQ isn't shared. Sucks
when it is but that is life.
