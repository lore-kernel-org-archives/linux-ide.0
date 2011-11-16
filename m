From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH] libata-pmp: add schedule timeout to support some PMP
 cards
Date: Wed, 16 Nov 2011 09:20:29 -0500
Message-ID: <4EC3C6AD.9070706@teksavvy.com>
References: <1320033440-1106-1-git-send-email-r66093@freescale.com> <20111103160759.GI4417@google.com> <8A2FC72B45BB5A4C9F801431E06AE48F11617501@039-SN1MPN1-005.039d.mgd.msft.net> <20111110152036.GB27258@google.com> <8A2FC72B45BB5A4C9F801431E06AE48F1161C24D@039-SN1MPN1-005.039d.mgd.msft.net> <20111115145111.GK30922@google.com> <4EC2844B.9050904@teksavvy.com> <4EC28D7E.7010703@teksavvy.com> <8A2FC72B45BB5A4C9F801431E06AE48F1161DF3C@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:13164 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757829Ab1KPOUv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2011 09:20:51 -0500
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F1161DF3C@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 11-11-16 04:00 AM, Huang Changming-R66093 wrote:
>> -----Original Message-----
>> From: Mark Lord [mailto:kernel@teksavvy.com]
=2E.
>>> What's the patch that I need to test ?
>>
>> Found it, tried it, still have a Linux doorstop.
>> Works fine under that other O/S though.
>>
> That=E2=80=99s a bad news. I think we need one workaround to fix it.
> I tested the other two PMP cards, they work well on Freescale's board=
:
> Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9 (Silico=
n Image)
> Port Multiplier 1.2, 0x197b:0x0321 r0, 5 ports, feat 0x5/0xf (JMB391)


No worries -- I'm just trying to get my JMB PMP to work on x86.
Your patch may still be good and necessary for Freescale; dunno.

Cheers
