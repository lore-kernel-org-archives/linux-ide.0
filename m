From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Organized summary of the pacthes
Date: Tue, 28 Jun 2005 19:00:12 +0100
Message-ID: <1119981611.32381.32.camel@localhost.localdomain>
References: <42C12A10.8030308@tw.ibm.com>  <42C16AFC.7010908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:34524 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262178AbVF1SD7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jun 2005 14:03:59 -0400
In-Reply-To: <42C16AFC.7010908@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, doug_maxey@us.ibm.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Tejun Heo <htejun@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Maw, 2005-06-28 at 16:21, Jeff Garzik wrote:
> These two patches make me REALLY nervous.  This overrun business needs 
> to be handled in a different way.
> 
> For DMA, we will want to copy 0-3 odd bytes into a 4-byte buffer, and 
> then make that 4-byte buffer than final DMA segment.

You may need 16 or 32 byte alignment for some hardware on the host side.

> However, I am pondering scrapping all the polling code, since on SATA, 
> interrupt-driven mode is much more desirable.

You need both interrupt and polled command issue. ACPI needs to be able
to issue taskfiles to the IDE drive fairly early during resume. Right
now this isn't done at all. If polled is there it might also prove a
useful way to reissue a command when you think the IRQ routing is hosed
8)

There is a really nasty case here that the old IDE layer totally screwed
up: You may need to sequence speed changes into error recovery (BAD CRC)
which is coming from a timeout and irq context. In the sata layer at
least its from an eh thread.

Alan

