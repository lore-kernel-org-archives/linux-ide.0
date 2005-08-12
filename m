From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 0/3] libata-dev: pdc2027x fixes
Date: Fri, 12 Aug 2005 16:10:08 +0800
Message-ID: <42FC5960.3030703@tw.ibm.com>
References: <42FC4B36.9080805@tw.ibm.com> <42FC51BB.2050401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:40959 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S1750833AbVHLILr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Aug 2005 04:11:47 -0400
In-Reply-To: <42FC51BB.2050401@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>


Jeff,

> Albert Lee wrote:
> 
>> Jeff,
>>
>> pdc2027x driver fix:
>>
>> 1/3 pdc1.diff:
>>     - Convert pdc2027x from PIO to MMIO.
>>
>> 2/3 pdc2.diff:
>>    - use "long" for the counter data type instead of "unsigned long"
>>
>> 3/3 pdc3.diff:
>>    - pdc2027x ATAPI DMA irq lost problem workaround
> 
> 
> Applied all three patches to pdc2027x branch of libata-dev.git.
> 
> I continue to dislike patch #3, but without more info, I fear this 
> workaround may be necessary.
> 

I've visited Promise in February for the pdc2027x irq lost problem.
They said it might be related to hardware FIFO problem, but they also
said it might be ATAPI device problem. I don't know how to fix it, just
have the (buflen% 256) workaround by trial and error. The (buflen % 256)
workaround does not alway work, however.

After checking how the ATAPI DMA is handled in their GPL code last week,
I sent an e-mail to ask them about the workaround, especially the
strange negative LBA check. No reply yet.

The command white list workaround alone seems working fine so far. Read,
burn and rip audio tracks by ATAPI DMA are ok. If any WRITE_10 problem
is hit in the future, maybe we can try the negative LBA check then.

Thanks for the review,

Albert




