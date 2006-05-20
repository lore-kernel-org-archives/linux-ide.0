From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/7] sata_mv: deal with interrupt coalescing interrupts
Date: Sat, 20 May 2006 09:13:48 -0400
Message-ID: <446F160C.40204@rtr.ca>
References: <11480537082648-git-send-email-htejun@gmail.com> <446DEE92.50102@pobox.com> <200605191614.00023.liml@rtr.ca> <200605191624.56928.liml@rtr.ca> <446E9BE1.3060700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 206-248-132-125.dsl.teksavvy.com ([206.248.132.125]:42474 "EHLO
	shrimpy") by vger.kernel.org with ESMTP id S964848AbWETNNw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 May 2006 09:13:52 -0400
In-Reply-To: <446E9BE1.3060700@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Applied, though I would like a follow-up which simply guarantees that 
> irq coalescing is off.

Perhaps.  I'm getting pressure to do the exact opposite from users
of this chipset --> they'd like IRQ coalescing to be guaranteed to
be turned *on*.  Maybe a sysfs attr for it, with default == off ?

It'll be next week sometime, though -- long holiday weekend is here now.

Cheers
