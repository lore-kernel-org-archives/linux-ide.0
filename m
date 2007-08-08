From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Tue, 07 Aug 2007 21:22:21 -0400
Message-ID: <46B91ACD.2000104@garzik.org>
References: <200708052245.16406.sshtylyov@ru.mvista.com>	<20070805202359.41fd0236@the-village.bc.nu>	<46B9131E.3040404@garzik.org> <20070808021703.77114775@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33513 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934458AbXHHBWX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 21:22:23 -0400
In-Reply-To: <20070808021703.77114775@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, rah@bash.sh

Alan Cox wrote:
> On Tue, 07 Aug 2007 20:49:34 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Alan Cox wrote:
>>>>  		/* Compute DPLL */
>>>> -		dpll = 2;
>>>> -		if (port->udma_mask & 0xE0)
>>>> -			dpll = 3;
>>>> +		dpll = (port->udma_mask & 0xC0) ? 3 : 2;
>>> Gak, I'd much rather people kept to the nice easy to read if() but fine
>>>
>>> is_author_p()?Signed-off-by:Acked-by Alan Cox <alan@redhat.com>
>> Does your ACK stand, even though it still locks up for Bob Ham?
> 
> 
> Its a real fix for a real bug. The 374 needs a bit more stuff which is
> sitting in my tree and I'll push for Sergei to comment tomorrow


OK, thanks.  Do you also ACK

[PATCH 2/2] pata_hpt{37x|3x2n}: fix clock reporting

?

	Jeff


