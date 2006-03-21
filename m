From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Tue, 21 Mar 2006 08:51:32 -0500
Message-ID: <442004E4.7010002@rtr.ca>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca> <20060321121354.GB24977@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:56749 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030381AbWCUNv2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 08:51:28 -0500
In-Reply-To: <20060321121354.GB24977@favonius>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sander@humilis.net
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Sander wrote:
> Mark Lord wrote (ao):
>> This patch addresses a number of weird behaviours observed
>> for the sata_mv driver, by fixing an "off by one" bug in processing
>> of the EDMA response queue.
>>
>> Basically, sata_mv was looking in the wrong place for
>> command results, and this produced a lot of unpredictable behaviour.
> 
> 2.6.16 with this patch and your former patch applied, crashes during
> stressing a raid5 connected to a MV88SX6081.
> 
> 2.6.16-rc6 crashes too.
> 
> 2.6.16-rc6-mm2 is rock solid wrt sata_mv.
> 
> I get no output of the crash on netconsole. Would it help if I get the
> output of the crash (if any)? In that case I'll connect a screen and see
> what it produces.

Yes, most helpful, please.
Even a digital camera snapshot of the oops would be handy to see.

Thanks!
