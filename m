From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What's in libata-dev.git
Date: Mon, 11 Sep 2006 16:28:33 +0100
Message-ID: <1157988513.23085.159.camel@localhost.localdomain>
References: <20060911132250.GA5178@havoc.gtf.org>
	 <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org>
	 <450568F3.3020005@ru.mvista.com>
	 <1157986974.23085.147.camel@localhost.localdomain>
	 <45057651.8000404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48307 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932231AbWIKPF2
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Sep 2006 11:05:28 -0400
In-Reply-To: <45057651.8000404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Ar Llu, 2006-09-11 am 10:44 -0400, ysgrifennodd Jeff Garzik:
> > drivers/ide. You might want to do 256 for SATA Jeff but please don't do
> > 256 for PATA. Reading specs is too hard for some people ;)
> > 
> > Some drives abort the xfer, some just choked.
> 
> Where in drivers/ide is it limited to 255?

Being a sensible sanity check it was removed, and that was a small
mistake. Some 2.4 also has a 256 limit and it broken various transparent
raid units, older Maxtors(1Gb or so), some IBM drives etc. Got fixed in
-ac but never in base.

The failure pattern is pretty ugly too, your box runs and runs and
eventually you get a linear 256 sector I/O and it all blows up,
sometimes. The IBM's abort the xfer but the maxtors may or may not get
it right (its as if half the firmware has the right test).

We could perhaps do it by ATA version - 255 for ATA < 3 256 for ATA 3+,
lots for LBA48 ? Thats assuming you can show 256 sectors is faster than
255. I'd bet for normal I/O its unmeasurably small.

Alan

