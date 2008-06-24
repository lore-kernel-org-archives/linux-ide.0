From: Brad Campbell <brad@wasp.net.au>
Subject: Re: FW: ICH10R PMP support
Date: Tue, 24 Jun 2008 13:40:43 +0400
Message-ID: <4860C11B.7060302@wasp.net.au>
References: <023701c8d4dd$d737fa10$85a7ee30$@com> <485F6830.1040000@pobox.com> <485F7356.5050605@kernel.org> <48609C8F.90805@pobox.com> <48609E01.1050802@kernel.org> <48609F20.4060608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:37696 "EHLO wasp.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbYFXJkt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jun 2008 05:40:49 -0400
In-Reply-To: <48609F20.4060608@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, Milo Medin <medin@m2znetworks.com>, linux-ide@vger.kernel.org, Grant Grundler <grundler@google.com>

Mark Lord wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
>>> Tejun Heo wrote:
>>>> Mark Lord wrote:
>>> ..
>>>>> The 7042 is the best of the Marvell chips, for Linux.
>>>> How high does it go bandwidth-wise?
>>> ..
>>>
>>> The limiting factor will be the bus width of the card
>>> and the slot into which it is plugged, I suspect.
> ..
> 
> Note that this has yet to be confirmed in practice,
> though I don't know if anyone has really tried hard yet.

I recently read a very nice review of the 7042 on a Sonnet card in a Mac and they were pulling over 
700MB/s using SIL port multipliers in a 4 lane slot. They managed over 1GB/s with 20 drives across 2 
of the cards! I've heard some unkind things about the SIL cards bandwidth, but these Marvell jobbies 
look very nice.

http://www.amug.org/amug-web/html/amug/reviews/articles/sonnet/mac-pro/

I've half a mind to order a couple of these and some PM's to play with. Shame the only PM's I can 
seem to find that do what I want are $85 each from addonics (I need 5 of them)

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
