From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs.
 intr race fix
Date: Mon, 22 Aug 2005 10:48:05 -0400
Message-ID: <4309E5A5.7030604@rtr.ca>
References: <20050820091651.486821E0@htj.dyndns.org> <4308DA57.9000303@pobox.com> <4308E13E.6070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:44269 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751207AbVHVVXv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 17:23:51 -0400
Received: from mail.rtr.ca (cpu1185.adsl.bellglobal.com [207.236.110.166])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7MEmXSN019780
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 07:48:34 -0700
In-Reply-To: <4308E13E.6070104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  
>   And without interrupt pending bit, shared interrupt means a lot of 
> spurious interrupts making it impossible to know when to expect interrupts.
> 
>  IDE driver deals with this by having only one command active per 
> interrupt, but SATA doesn't have such scheme yet.  And I don't know if 
> such a scheme is desirable at all.

I'm not sure which part of the IDE driver this refers to,
but there is/was code in there from 1994 or so, which enabled
sharing a single IRQ among multiple ISA IDE interfaces using
edge-triggered interrupts (rather than level-triggered).

That particular code did indeed only permit one command active per
interrupt, but only for that situation.  But later on, when simplex
DMA host controllers appeared, the scheme got reorganized into
"hardware groups" (hwgroups), which were collections of IDE interfaces
which required mutual exclusion among themselves.

If only the hardware were as simple and as well documented back then
as it is (mostly) today!

Cheers
