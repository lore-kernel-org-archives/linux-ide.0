From: Grant Grundler <grundler@google.com>
Subject: Re: Implementing NVMHCI...
Date: Sat, 11 Apr 2009 14:49:02 -0700
Message-ID: <da824cf30904111449y5cb7c178ldf5291506ad6b393@mail.gmail.com>
References: <49E0D47B.9070205@garzik.org>
	 <20090411203246.513a0892@lxorguk.ukuu.org.uk>
	 <alpine.LFD.2.00.0904111250370.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:46076 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757448AbZDKVtH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Apr 2009 17:49:07 -0400
In-Reply-To: <alpine.LFD.2.00.0904111250370.4583@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>

On Sat, Apr 11, 2009 at 12:52 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Sat, 11 Apr 2009, Alan Cox wrote:
>>
>> > =C2=A0 =C2=A0 =C2=A0 The spec describes the sector size as
>> > =C2=A0 =C2=A0 =C2=A0 "512, 1k, 2k, 4k, 8k, etc." =C2=A0 It will be=
 interesting to reach
>> > =C2=A0 =C2=A0 =C2=A0 "etc" territory.
>>
>> Over 4K will be fun.
>
> And by "fun", you mean "irrelevant".
>
> If anybody does that, they'll simply not work. And it's not worth it =
even
> trying to handle it.

Why does it matter what the sector size is?
I'm failing to see what the fuss is about.

We've abstract the DMA mapping/SG list handling enough that the
block size should make no more difference than it does for the
MTU size of a network.

And the linux VM does handle bigger than 4k pages (several architecture=
s
have implemented it) - even if x86 only supports 4k as base page size.

Block size just defines the granularity of the device's address space i=
n
the same way the VM base page size defines the Virtual address space.

> That said, I'm pretty certain Windows has the same 4k issue, so we ca=
n
> hope nobody will ever do that kind of idiotically broken hardware. Of
> course, hardware people often do incredibly stupid things, so no
> guarantees.

That's just flame-bait.=C2=A0Not touching that.

thanks,
grant

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
