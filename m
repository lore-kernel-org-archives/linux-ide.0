From: Mark Lord <liml@rtr.ca>
Subject: Re: Fwd: [PATCH #upstream-fixes 1/4] libata: fix device iteration
 bugs
Date: Tue, 11 Nov 2008 20:18:57 -0500
Message-ID: <491A2F01.8090006@rtr.ca>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost>	<1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com>	<4917DA12.8070307@kernel.org>	<07a2f909b249db90ad6bfdddfdd17765@localhost>	<49180B2E.6020604@kernel.org>	<49184E1A.3010508@rtr.ca>	<4918F1BC.2070602@kernel.org>	<4919038B.8020407@rtr.ca>	<49194E1C.9030800@ru.mvista.com>	<49199666.9060103@rtr.ca> <20081111143459.65c14879@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46752 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbYKLBSL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 20:18:11 -0500
In-Reply-To: <20081111143459.65c14879@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Tejun Heo <tj@kernel.org>, Michael Guntsche <mike@it-loops.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Alan Cox wrote:
>> Heck, the Linux support for Triton DMA made us the first
>> widely available O/S with UDMA support for that (or any) chipset!
>> Predating even Redmond by a good six months or more!
> 
> Triton 1 didn't have UDMA - are you thinking of the later chipsets ?
..

Ooops.. poor memory here for terminology.

Triton was the first Intel IDE controller with PCI bus-master DMA,
and Linux was the first O/S to take advantage of it:  82371FB.
