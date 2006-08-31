From: Mark Lord <liml@rtr.ca>
Subject: Re: Cache Coherency in PIO Read/Write
Date: Thu, 31 Aug 2006 14:48:53 -0400
Message-ID: <44F72F15.40900@rtr.ca>
References: <4D87F853B8020F4888896B1507DC0F09A2C433@mail2.netezza.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:27521 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932441AbWHaSsz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Aug 2006 14:48:55 -0400
In-Reply-To: <4D87F853B8020F4888896B1507DC0F09A2C433@mail2.netezza.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Odell <modell@netezza.com>
Cc: linux-ide@vger.kernel.org

Mark Odell wrote:
> For PIO mode transfers, you should not have cache coherency issues since
> the CPU core is doing the read from/write to hardware.

One might think so, but cache lines are tagged with virtual addresses,
so using different virtual addresses (kernel vs. userspace) for the 
same data can result in problems like this.

There was a recent thread (this past winter, I believe) devoted to
trying to resolve this issue in 2.6.xx, but I don't remember the final outcome.

Cheers
