From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug#419482: Kernel 2.6.18 - ALI15X3 driver too optmistic about
 UDMA
Date: Sat, 8 Sep 2007 15:21:59 +0100
Message-ID: <20070908152159.2f76850e@the-village.bc.nu>
References: <20070415232959.GE25207@einval.com>
	<20070416012635.GA29219@deprecation.cyrius.com>
	<20070418212536.GC30335@einval.com>
	<20070906222759.GI29259@einval.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39548 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752754AbXIHONn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 10:13:43 -0400
In-Reply-To: <20070906222759.GI29259@einval.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steve McIntyre <steve@einval.com>
Cc: linux-ide@vger.kernel.org, 419482@bugs.debian.org

>         if (m5229_revision <= 0x20) {
>                 return 0;
>         } else if ((m5229_revision < 0xC2) &&

So 0xC1 takes this path

> Looking back at the equivalent code in 2.4.27 (the previous kernel
> this machine ran), that's rather different:
> 
>         if (m5229_revision < 0xC1) {    /* According to ALi */
>                 return 0;
>         } else if ((m5229_revision < 0xC2) &&

And 0xC1 takes the same path.

> So it would seem there has been a regression here - the assumption now
> is that versions between 0x20 and 0xC1 can use UDMA fine unless there
> is a WDC drive attached, but the old code wouldn't try UDMA at all on
> chips older than rev C1.

There are no versions between 0x21 and 0xC0.

> I have the machine out and ready to experiment with if any more
> details are needed to help solve this problem.

Interesting report as we've had essentially no corruption reports
equivalent to this on common architectures for a long time and the
hardware is in a huge number of PC systems. Also UDMA transfers are CRC
protected by hardware at each end.

That makes me wonder if you have a platform or endian bug, or indeed your
firmware isn't setting up all the chipset as required by the ALi chipset
and BIOS documentation (which unfortunately is NDA)

Alan
