From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Re: [PATCH] sata_mv: enable active LED blink mode for SoC
Date: Mon, 08 Sep 2008 16:18:16 +0100
Message-ID: <48C54238.9050106@onelan.co.uk>
References: <12207863853449-git-send-email-saeed@marvell.com> <48C52B53.3030302@rtr.ca> <200809081616.03266.elendil@planet.nl> <200809081625.31131.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay6.mail.uk.clara.net ([80.168.70.186]:58551 "EHLO
	relay6.mail.uk.clara.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbYIHQ0N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Sep 2008 12:26:13 -0400
In-Reply-To: <200809081625.31131.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Mark Lord <liml@rtr.ca>, Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org, linux-arm@vger.kernel.org, jeff@garzik.org, grundler@google.com, buytenh@marvell.com, nico@marvell.com, tbm@cyrius.com

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

Setting queue_depth to 1 is not disabling NCQ; it's NCQ enabled, no more
than one command outstanding at a time. A queue depth of 0 disables NCQ
completely.

While I don't have the relevant hardware, this sounds like a hardware
limitation, not a regression. I suspect that the LED is active whenever
a command is outstanding; with NCQ allowed to queue more than 1 command
at a time, Linux is keeping the drive fed with commands so that there
are always outstanding commands, and thus the light never goes inactive
during disk activity.

As a result, you never see the LED intensity vary, as the drive never
idles waiting for a new command, but is constantly processing commands
as fast as it can. Allowing the drive to idle would get you the
"flickering" you want, at the expense of the performance gain NCQ provides.
-- 
I'm sure Saeed or Mark will correct me if I'm completely wrong,

Simon Farnsworth

