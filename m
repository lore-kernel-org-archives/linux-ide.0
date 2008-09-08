From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: enable active LED blink mode for SoC
Date: Mon, 08 Sep 2008 14:47:32 -0400
Message-ID: <48C57344.4060901@rtr.ca>
References: <12207863853449-git-send-email-saeed@marvell.com> <48C52B53.3030302@rtr.ca> <200809081616.03266.elendil@planet.nl> <200809081625.31131.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:55389 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbYIHSre (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 14:47:34 -0400
In-Reply-To: <200809081625.31131.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org, linux-arm@vger.kernel.org, jeff@garzik.org, grundler@google.com, buytenh@marvell.com, nico@marvell.com, tbm@cyrius.com

Frans Pop wrote:
> On Monday 08 September 2008, Frans Pop wrote:
>> On Monday 08 September 2008, Mark Lord wrote:
>>> Frans Pop wrote:
>>>> So, IMO it is an improvement, but it is definitely not a fix for
>>>> the regression.
>>> With a new copy of hdparm, use "hdparm -Q1 /dev/sd?"
>>> Does that fix your "regression" ?
>> $ sudo hdparm -Q1 /dev/sda
>>
>> /dev/sda:
>>  setting queue_depth to 1
>>  queue_depth   =  1
>>
>> Yes, that does result in the original behavior of the led.
>> (Using version 8.9 of hdparm.)
> 
> But that's not new information: we'd already determined some time ago that 
> disabling NCQ "fixed" the problem, both if it is done at runtime and when 
> it is disabled in the driver:
> http://www.spinics.net/lists/linux-ide/msg25642.html
> http://www.spinics.net/lists/linux-ide/msg25645.html
..

Still, that's proof that there is NO REGRESSION here,
so please stop using that term.

Older kernels had a working LED without NCQ,
and so do newer ones.  No regression.

In the meanwhile, it appears that Saeed is working to determine
for sure that this is a hardware limitation, as it appears to be.

Cheers
