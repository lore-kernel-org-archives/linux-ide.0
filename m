From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [PATCH] ata_port_wait_eh(): Change irqsave into unconditional closing of interrupts
Date: Thu, 26 Sep 2013 17:43:01 +0400
Message-ID: <332301380202981@web24m.yandex.ru>
References: <1491380201679@web5j.yandex.ru> <20130926133153.GA2480@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from forward6.mail.yandex.net ([77.88.60.125]:51441 "EHLO
	forward6.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab3IZNnH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Sep 2013 09:43:07 -0400
In-Reply-To: <20130926133153.GA2480@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

26.09.2013, 17:32, "Tejun Heo" <tj@kernel.org>:
> Hello, Kirill.
>
> On Thu, Sep 26, 2013 at 05:21:19PM +0400, Kirill Tkhai wrote:
>
>> =9AHi,
>>
>> =9Aata_port_wait_eh() uses spin_lock_irqsave() and this can confuse =
in fact
>> =9Athat it is suitable to use in irqs_disabled() context. But we can=
't.
>>
>> =9A(schedule() returns with interrupts enabled so it's possible
>> =9Aata_port_wait_eh() enters with disabled interrupts but returns wi=
th enabled)
>>
>> =9ASo, replace irqsave to unconditional closing of interrupts.
>>
>> =9AI propose to consider to add patch like this. (If you don't have =
a magic
>> =9Awith flags which is not obvious for me :)
>
> Hmmm... yeah, this was Jeff's preference, at least way back, so libat=
a
> has a lot of spin_lock_irqsave()'s where spin_lock_irq() should do.
> At this point, I don't really mind either way but if you wanna change
> it can you please do a full sweep through libata? =9AWhile I don't mi=
nd
> either state too much, I do want them to be mostly consistent one way
> or the other.

I don't exclude this, maybe, I do this in my spare time ;)

Kirill
