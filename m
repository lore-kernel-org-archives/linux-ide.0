From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: What's in libata-dev.git
Date: Mon, 11 Sep 2006 19:21:11 +0400
Message-ID: <45057EE7.40607@ru.mvista.com>
References: <20060911132250.GA5178@havoc.gtf.org>	 <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org>	 <450568F3.3020005@ru.mvista.com>	 <1157986974.23085.147.camel@localhost.localdomain>	 <45057651.8000404@garzik.org> <1157988513.23085.159.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5429 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S964842AbWIKPTA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Sep 2006 11:19:00 -0400
In-Reply-To: <1157988513.23085.159.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Hello.

Alan Cox wrote:

>>>drivers/ide. You might want to do 256 for SATA Jeff but please don't do
>>>256 for PATA. Reading specs is too hard for some people ;)

>>>Some drives abort the xfer, some just choked.

>>Where in drivers/ide is it limited to 255?

> Being a sensible sanity check it was removed, and that was a small
> mistake. Some 2.4 also has a 256 limit and it broken various transparent
> raid units, older Maxtors(1Gb or so), some IBM drives etc. Got fixed in
> -ac but never in base.

> The failure pattern is pretty ugly too, your box runs and runs and
> eventually you get a linear 256 sector I/O and it all blows up,
> sometimes. The IBM's abort the xfer but the maxtors may or may not get
> it right (its as if half the firmware has the right test).

    So, this seems to have a long history... :-)
    I've also heard several years ago of the drives not getting anything over 
128 sectors right, but those should be really brain-damaged...

> We could perhaps do it by ATA version - 255 for ATA < 3 256 for ATA 3+,

    Wouldn't work, I'm afraid. That IBM drive is UltraATA/33, so no less than 
ATA-4...
    Well, after having referred to the ID data read from it, it's ATA-3 actually.

> lots for LBA48 ? Thats assuming you can show 256 sectors is faster than
> 255. I'd bet for normal I/O its unmeasurably small.

> Alan

WBR, Sergei
