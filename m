From: Mark Lord <liml@rtr.ca>
Subject: Re: Odd behaviour of device in response to idleimmediate with unload
Date: Tue, 04 Nov 2008 12:47:12 -0500
Message-ID: <49108AA0.1080507@rtr.ca>
References: <871vxrzssj.fsf@denkblock.local>	<491026AB.1090704@kernel.org> <20081104123211.A86321FD5A@chi.die-welt.net> <49108120.6000205@rtr.ca> <491083CC.5050508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:43258 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbYKDRqd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 12:46:33 -0500
In-Reply-To: <491083CC.5050508@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evgeni Golov <sargentd@die-welt.net>
Cc: Tejun Heo <tj@kernel.org>, Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> Mark Lord wrote:
>> Evgeni Golov wrote:
>>> Hi,
>>>
>>> On Tue, 04 Nov 2008 19:40:43 +0900 Tejun Heo wrote:
>>>
>>>> Is it a laptop?
>>>
>>> Yes it is, it's a IBM/Lenovo Thinkpad Z61m (9453A11)
>>>
>>>> Does 'hdparm -y' cause the same thing?
>>>
>>> No, neither -y nor -Y cause these messages.
>> ..
>>
>> Well, -y does a simple ATA "IDLE IMMEDIATE" command.
..

EEeek.. actually, no it doesn't.  It issues a STANDBY IMMEDIATE.

I'm releasing hdparm-9.3 in the next few minutes,
with new --idle and --idle-unload flags to issue
the commands in question here.

Cheers
