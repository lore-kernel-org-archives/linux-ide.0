From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: H8/300 target support patch
Date: Tue, 17 Feb 2004 09:09:38 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1076969377.1053.62.camel@gaston>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp>
	 <200402151540.56377.bzolnier@elka.pw.edu.pl>
	 <m265e7dn02.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:29601 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265908AbUBPWKI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2004 17:10:08 -0500
In-Reply-To: <m265e7dn02.wl%ysato@users.sourceforge.jp>
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org


> > 
> > why you don't use outsw() and insw() from include/asm-h8300/io.h?
> 
> Because bus turns over, insw/outsw is not usable.

Please explain.

Your IDE bus is flipped backward ? The next one who do that should
lose all rights to do any kind of HW design... Or is it a big endian
platform ? In this case, use normal flipping inw/outw for IOs and
non-flipping for stream IOs (insw/outsw)

Your functions are "streaming" versions, they should be called
with the proper name "insw/outsw". Calling the streaming versions
from the IO ones is wrong.


