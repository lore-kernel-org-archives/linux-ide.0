From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Date: Tue, 7 Oct 2008 10:37:23 +0100
Message-ID: <20081007103723.0224671e@lxorguk.ukuu.org.uk>
References: <20081006172653.GA26427@oksana.dev.rtsoft.ru>
	<48EA77EF.6080502@genesi-usa.com>
	<20081006213209.GA13072@oksana.dev.rtsoft.ru>
	<48EABBD3.1010401@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47935 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751081AbYJGJvV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Oct 2008 05:51:21 -0400
In-Reply-To: <48EABBD3.1010401@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: avorontsov@ru.mvista.com, Matt Sealey <matt@genesi-usa.com>, Jeff Garzik <jgarzik@pobox.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Li Yang <leoli@freescale.com>, Wang Jian <lark@linux.net.cn>

> > This was discussed years ago.
> > 
> > http://lkml.org/lkml/2005/11/22/159
> > http://lkml.org/lkml/2005/11/22/227
> > 
> 
> Would this break any existing platforms?  If so, can those be fixed
> together or does it become a much bigger problem that way?

Zero means no IRQ. Any platform with bits of code left over exposing IRQ
0 is already not supported by lots of driver code including libata.

As IRQs are unsigned using -1 is asking for trouble
