From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: H8/300 target support patch
Date: Tue, 17 Feb 2004 23:55:54 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1077022554.1080.7.camel@gaston>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp>
	 <200402151540.56377.bzolnier@elka.pw.edu.pl>
	 <m265e7dn02.wl%ysato@users.sourceforge.jp>
	 <1076969377.1053.62.camel@gaston>
	 <m2lln2ndnu.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55970 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266152AbUBQM5c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Feb 2004 07:57:32 -0500
In-Reply-To: <m2lln2ndnu.wl%ysato@users.sourceforge.jp>
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-ide@vger.kernel.org


> > Your IDE bus is flipped backward ? The next one who do that should
> > lose all rights to do any kind of HW design... Or is it a big endian
> > platform ? In this case, use normal flipping inw/outw for IOs and
> > non-flipping for stream IOs (insw/outsw)
> 
> This architecture is big endian.

A big endian architecture needs the standard inx/outx macros to
be byteswapped, but _not_ the insw/outsw. That should be all 
done properly from the standard macros in your asm/io.h, you
should _not_ have to byteswap normal transfers.

> It was my misunderstanding that did not use asm/io.h.
> It is the patch which it corrected to use it.
> h8300/h8_ide_iops.h becomes needless.

Ben.


