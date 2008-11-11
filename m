From: Mark Lord <liml@rtr.ca>
Subject: Re: Fwd: [PATCH #upstream-fixes 1/4] libata: fix device iteration
 bugs
Date: Tue, 11 Nov 2008 09:27:50 -0500
Message-ID: <49199666.9060103@rtr.ca>
References: <6ca8fe89c868f95831328d31c27f9cdb@localhost> <1DE9BF42-39BB-4220-BDF0-62F14C854E77@it-loops.com> <4917DA12.8070307@kernel.org> <07a2f909b249db90ad6bfdddfdd17765@localhost> <49180B2E.6020604@kernel.org> <49184E1A.3010508@rtr.ca> <4918F1BC.2070602@kernel.org> <4919038B.8020407@rtr.ca> <49194E1C.9030800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:60140 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbYKKO1H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 09:27:07 -0500
In-Reply-To: <49194E1C.9030800@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Tejun Heo <tj@kernel.org>, Michael Guntsche <mike@it-loops.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Sergei Shtylyov wrote:
> Hello.
> 
> Mark Lord wrote:
..
>> Mmm.. but he's using "really old ata_piix" hardware, as in what Intel
>> once called the "Triton" (or Triton II) chipset.
> 
>   The "original Triton" IDE is supported by pata_oldpiix.
> 
>>   Which I wrote support
>> for in drivers/ide, way back when.. and we never had this problem.
> 
>   The support for the "original Triton" is drivers/ide/ is still broken 
> after all these years. The driver assumes that the slave IDE timing 
> register always present -- which the origina 82371FB didn't have. :-(
..

Hey, don't complain to me -- I didn't break that!
Heck, the Linux support for Triton DMA made us the first
widely available O/S with UDMA support for that (or any) chipset!
Predating even Redmond by a good six months or more!

But back then, we still relied upon the BIOS to manage timings
(since it had to set them up to boot anyway).  The b0rked timing
in drivers/ide came from a subsequent "maintainer".  :)

Cheers
