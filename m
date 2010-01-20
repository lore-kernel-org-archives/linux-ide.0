From: Bart Hartgers <bart.hartgers@gmail.com>
Subject: Re: [patch 2/2] sata_via: Delay on vt6420 when starting ATAPI DMA
	write
Date: Wed, 20 Jan 2010 07:33:24 +0100
Message-ID: <7eb6a4d81001192233i5418249ct5a1717045f75167c@mail.gmail.com>
References: <20100116235653.898098245@gmail.com>
	 <20100116235851.884756038@gmail.com> <4B5678E2.2050709@gmail.com>
	 <4B568C63.4050506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:38407 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682Ab0ATGdZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 01:33:25 -0500
In-Reply-To: <4B568C63.4050506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, juergen.metzdorf@telelev-dsl.de, markpschool@hotmail.com, sporadic.crash@gmail.com, apopov@sirma.bg, david@coomber.co.za, jay4mail@gmail.com

Hi,

2010/1/20 Robert Hancock <hancockrwd@gmail.com>:
> On 01/19/2010 09:30 PM, Tejun Heo wrote:
>>
>> Hello,
>>
>> On 01/17/2010 08:56 AM, Bart Hartgers wrote:
>>>
>>> When writing a disc on certain lite-on dvd-writers (also rebadged a=
s
>>> optiarc/LG/...) connected to a vt6420, the ATAPI CDB ends up in the
>>> datastream and on the disc, causing silent corruption. =C2=A0Delayi=
ng
>>> between sending the CDB and starting DMA seems to prevent this.
>>>
>>> I do not know if there are burners that do not suffer from this, bu=
t
>>> the patch should be safe for those as well.
>>>
>>> There are many reports of this issue, but AFAICT no solution was
>>> found before. For example:
>>> http://lkml.indiana.edu/hypermail/linux/kernel/0802.3/0561.html
>>>
>>> Signed-off-by: Bart Hartgers<bart.hartgers@gmail.com>
>>
>> Ah... you found solution for this? =C2=A0That's great. =C2=A0This is=
 one of the
>> three problems that have been lingering for years - the other two
>> being pata_ali ATAPI DMA problem and sata_sil data corruption proble=
m.
>> I'll be ecstatic if this fix works. =C2=A0Just one thing, I don't th=
ink
>> we'll need a warning message there. =C2=A0It's useful during develop=
ment
>> but it doesn't really provide any useful information afterwards.
>
> Another tiny nitpick about the patch, the unlikely() around the
> DMA_TO_DEVICE check probably shouldn't be there - unlikely() is for t=
hings
> that will always be either highly unlikely or a slow path, neither of=
 which
> really apply.
>

Well, the ata_sff_pause actually does a ndelay(400), and with today's
processors that would be a 'slow path', right?

Groeten,
Bart

>>
>> Digging up the mailing list and cc'ing people who have reported this
>> problem. =C2=A0If you still have the affected systems, can you guys =
please
>> test the patch in the following message and see whether it fixes the
>> problem?
>>
>> =C2=A0 http://article.gmane.org/gmane.linux.kernel/939112/raw
>>
>> Thanks a lot. =C2=A0:-)
>>
>
>



--=20
Bart Hartgers - New e-mail: bart.hartgers@gmail.com
