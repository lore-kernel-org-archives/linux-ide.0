From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_sil24 stability and performance
Date: Tue, 18 Mar 2008 16:06:55 -0400
Message-ID: <47E020DF.9030900@rtr.ca>
References: <20080304002215.GA13317@denix.org> <47CCC1C6.5010600@gmail.com> <20080304062942.GA14335@denix.org> <47CE55B3.6070701@gmail.com> <20080306041454.GA7242@denix.org> <47CF7222.7060702@gmail.com> <20080306065513.GE7150@denix.org> <47CF9880.4080900@gmail.com> <20080315214347.GA1511@denix.org> <47DDE0ED.6040304@rtr.ca> <20080318001513.GA2389@denix.org> <47DF4070.3040507@gmail.com> <47E02090.80000@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3806 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755368AbYCSToN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Mar 2008 15:44:13 -0400
In-Reply-To: <47E02090.80000@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Denys Dmytriyenko <denis@denix.org>, Gabor FUNK <FUNK.Gabor@hunetkft.hu>, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>

Mark Lord wrote:
> Tejun Heo wrote:
>> Denys Dmytriyenko wrote:
> ..
>>> Mar 14 23:51:55 [kernel] ata3: failed to read log page 10h (errno=-2)
>>> Mar 14 23:51:55 [kernel] ata3.00: exception Emask 0x1 SAct 0x3f SErr 
>>> 0x0 action 0x0
>>> Mar 14 23:51:55 [kernel] ata3.00: irq_stat 0x00020002, device error 
>>> via SDB FIS
>>
>> This one is different.  The drive reported device error but the driver
>> couldn't get more information about the error (log page 10h contains it).
> ..
> 
> That, is one of the known errata that has yet to be fixed in the driver.
> The READ LOG EXT command cannot be used in the normal fashion after an 
> NCQ error.
..

Whoops.. scratch that.. I thought Denys was trialing sata_mv there,
not sata_sil24 as it turns out.

-ml
