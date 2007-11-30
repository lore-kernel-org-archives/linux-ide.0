From: Tejun Heo <htejun@gmail.com>
Subject: Re: Flexible SFF interrupt handling
Date: Fri, 30 Nov 2007 10:08:16 +0900
Message-ID: <474F6280.8090403@gmail.com>
References: <474D70E0.4060709@garzik.org> <474D7C21.9000303@rtr.ca> <474D900B.8030408@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:5193 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188AbXK3BIX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 20:08:23 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2475817wah
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 17:08:22 -0800 (PST)
In-Reply-To: <474D900B.8030408@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Actually no, and that is a key benefit of this scheme:  if we ensure
> that the polling paths are resilient even in case where interrupts are
> being delivered -- as we must do anyway -- then we don't have to worry
> about interrupt masking, either on the interrupt controller or on the
> device[1].
> 
> [1] well, there -are- exceptions, such as when we are bitbanging the ATA
> Data register

Yeah, that one exception is exactly why we need to plug the IRQ during
polling PIO or to push PIO data xfer to a workqueue and doing so by nIEN
is unreliable on several controllers and unreliable by nature in many
early SFF SATA controllers when paired with certain SATA devices as
noted in appendix C of SATA 2.5 spec.

And when reading off Status when idle, we'll need to return 0 from
irq_handler.  That will prevent IRQ screaming IRQ lock and nobody cared
detection code is exactly there to watch how often such idle IRQs occur
and disable it if necessary.

Maybe we can make irqpoll on-demand such that nobody cared turns it and
driver can also request polling on the IRQ.

Thanks.

-- 
tejun
