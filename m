From: Doug Maxey <dwm@maxeymade.com>
Subject: Re: Organized summary of the pacthes
Date: Sat, 09 Jul 2005 19:54:06 -0500
Message-ID: <200507100054.j6A0s6Ct025796@falcon30.maxeymade.com>
References: <1119981611.32381.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from falcon30.maxeymade.com ([24.173.215.190]:39320 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S261803AbVGJAyZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jul 2005 20:54:25 -0400
In-reply-to: <1119981611.32381.32.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Albert Lee <albertcc@tw.ibm.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Tejun Heo <htejun@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


On Tue, 28 Jun 2005 19:00:12 BST, Alan Cox wrote:
>On Maw, 2005-06-28 at 16:21, Jeff Garzik wrote:
>> These two patches make me REALLY nervous.  This overrun business needs
>> to be handled in a different way.
>>
>> For DMA, we will want to copy 0-3 odd bytes into a 4-byte buffer, and
>> then make that 4-byte buffer than final DMA segment.

Indeed, all chipsets I have seen require that the dma be aligned on 4
byte boundaries, and the transfer be a multiple of 4 bytes.  Maybe I
have not seen that many, but all I have seen do seem to conform to the
original Intel specs (or what was SFF-8038i).  Normally this is not an
issue all the buffers are powers of 2, 512 bytes or larger.

Also, we do need to honor the 64k boundary, as at least in this case,
the underlying device is indeed PATA.

>
>You may need 16 or 32 byte alignment for some hardware on the host side.

Where would one specify this, at the block layer?  Then bounce the
portions that extend outside this region as a separate transfer to
device (including the odd bytes above)?

Or are you referring to internal buffer creation only?

>
>> However, I am pondering scrapping all the polling code, since on SATA,
>> interrupt-driven mode is much more desirable.
>
>You need both interrupt and polled command issue. ACPI needs to be able
>to issue taskfiles to the IDE drive fairly early during resume. Right
>now this isn't done at all. If polled is there it might also prove a
>useful way to reissue a command when you think the IRQ routing is hosed
>8)

This would be an enhancement, rather than something required currently,
correct?

>
>There is a really nasty case here that the old IDE layer totally screwed
>up: You may need to sequence speed changes into error recovery (BAD CRC)

Likewise?  Dynamic fallback would be great, and should print a big fat
"your cables or drive are failing" message when the fallback was
initiated.

>which is coming from a timeout and irq context. In the sata layer at
>least its from an eh thread.
>

++doug




