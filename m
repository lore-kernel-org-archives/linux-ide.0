From: Mark Lord <liml@rtr.ca>
Subject: Re: ide dma bug?
Date: Mon, 05 Sep 2005 12:00:58 -0400
Message-ID: <431C6BBA.2070105@rtr.ca>
References: <20050904201844.GA12464@pog.tecnopolis.ca> <200509051239.14713.andersin@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:35978 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932223AbVIEQBA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Sep 2005 12:01:00 -0400
In-Reply-To: <200509051239.14713.andersin@freenet.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Burger-Scheidlin <andersin@freenet.de>
Cc: linux-ide@vger.kernel.org

Christoph Burger-Scheidlin wrote:
>
> I had a similar problem with a SiI680 (and since lspci states that Silicon 
> Image was formerly CMD Tech. I thought it might be related). In my case, I 
> got lost interrupts and dma errors when I used both channels of the SiI680 
> simultaneously. I serialized both channels (kernel parameters ide2=serialize 
> ide3=serialize) and the problems went away (I am not sure though how much of 
> a performance impact it has).

Note for others:
Using the ideX=serialize parameter simply causes the IDE driver
to never allow simultaneous activity on the "serialized" channels.

A small performance tradeoff in exchange for reliable operation.
The drives can still seek independently and all that, just without
any overlap in operation.

Cheers
