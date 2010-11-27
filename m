From: Mark Lord <kernel@teksavvy.com>
Subject: Re: sata_sil24: external raid storage mistaken as port multiplier
Date: Fri, 26 Nov 2010 21:57:10 -0500
Message-ID: <4CF07386.7080304@teksavvy.com>
References: <1290461073.12443.21.camel@Tobias-Karnat>	 <1290514125.28293.2.camel@Tobias-Karnat> <1290572588.24847.20.camel@Tobias-Karnat> <4CEFEC17.6060503@kernel.org> <4CF014F8.9000700@teksavvy.com> <4CF01583.5050307@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:4955 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752031Ab0K0C5P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Nov 2010 21:57:15 -0500
In-Reply-To: <4CF01583.5050307@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Tobias Karnat <tobias.karnat@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 10-11-26 03:16 PM, Tejun Heo wrote:
> Hello,
>
> On 11/26/2010 09:13 PM, Mark Lord wrote:
>>> That said, yeah, it probably would be a good idea to add a
>>> libata.force param.
>>
>> How about some form of auto-detection instead?
>
> That's a device which reports that it's a PMP but fails to behave
> itself as one.  The sucky thing is that depending on the current mode
> and firmware revision, the same hardware can actually bahave as a
> pretty decent PMP.

Yuck!  :)

I suppose *if* we knew the exact fwrev that requires the workaround,
then we could make it automatic for that, and still have the boot flag
for cases we don't know about.

Tobias?  Got the IDENTIFY info from that device?
Something like "hdparm --istdout /dev/sdX"  ?
