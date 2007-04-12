From: Mark Lord <liml@rtr.ca>
Subject: Re: IDE driver in polling mode
Date: Thu, 12 Apr 2007 09:40:53 -0400
Message-ID: <461E36E5.1000909@rtr.ca>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>	 <461B9D04.2000109@ru.mvista.com>	 <20070410171125.3aeed29d@the-village.bc.nu>	 <461BB8C7.9050900@garzik.org>	 <20070410172942.7f63d49c@the-village.bc.nu>	 <1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>	 <20070411094702.74774d25@the-village.bc.nu> <1ea6be8e0704110810l205f5dc7gb831603455a883e2@mail.gmail.com> <461E3677.6030104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:4773 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbXDLNkw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Apr 2007 09:40:52 -0400
In-Reply-To: <461E3677.6030104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael <michaelzwrk@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-embedded@ozlabs.org, linux-ide@vger.kernel.org

Mark Lord wrote:
> Michael,
> 
> Here is a patch to have drivers/ide use polling
> for all operations, in addition to IRQs.

s/in addition to/instead of/

If you need IRQs + polling, then just un-ifdef
the request_irq() and free_irq() lines.

Cheers


