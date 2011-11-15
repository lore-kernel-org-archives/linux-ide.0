From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] libata-pmp: add schedule timeout to support some PMP
 cards
Date: Tue, 15 Nov 2011 11:04:14 -0500
Message-ID: <4EC28D7E.7010703@teksavvy.com>
References: <1320033440-1106-1-git-send-email-r66093@freescale.com> <20111103160759.GI4417@google.com> <8A2FC72B45BB5A4C9F801431E06AE48F11617501@039-SN1MPN1-005.039d.mgd.msft.net> <20111110152036.GB27258@google.com> <8A2FC72B45BB5A4C9F801431E06AE48F1161C24D@039-SN1MPN1-005.039d.mgd.msft.net> <20111115145111.GK30922@google.com> <4EC2844B.9050904@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:20871 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756453Ab1KOQEQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Nov 2011 11:04:16 -0500
In-Reply-To: <4EC2844B.9050904@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Huang Changming-R66093 <r66093@freescale.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 11-11-15 10:24 AM, Mark Lord wrote:
> On 11-11-15 09:51 AM, Tejun Heo wrote:
>> Hello,
>>
>> On Tue, Nov 15, 2011 at 08:43:02AM +0000, Huang Changming-R66093 wrote:
>>> The PMP card we are talking about is JMB393:
>>> Port Multiplier 1.2, 0x197b:0x0325 r0, 15 ports, feat 0x5/0xf.
>>>
>>> This issue is observed on Freescale's Sata controller, including p1020e and mpc837xe.
>>
>> Can you please try different combinations?  ie. freescale sata + other
>> PMP and jmb393 + other sata controllers.  We need to know more before
>> adding workarounds to upstream.  Also, would you mind if I cc jmicron
>> ppl?
> 
> 
> I'm late tuning in here, but I have a JMB393 doorstop here
> and would love to have it actually work with Linux.
> It fails with all of my sata_sil, sata_sil24 and AHCI (including JMB) controllers.
> 
> What's the patch that I need to test ?

Found it, tried it, still have a Linux doorstop.
Works fine under that other O/S though.

Cheers
