From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What's in libata-dev.git
Date: Mon, 11 Sep 2006 16:02:54 +0100
Message-ID: <1157986974.23085.147.camel@localhost.localdomain>
References: <20060911132250.GA5178@havoc.gtf.org>
	 <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org>
	 <450568F3.3020005@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30187 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751265AbWIKOkM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Sep 2006 10:40:12 -0400
In-Reply-To: <450568F3.3020005@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Ar Llu, 2006-09-11 am 17:47 +0400, ysgrifennodd Sergei Shtylyov:
>     It's not likely I'll be able to try it. But I'm absolutely sure that drive 
> aborted the read commands with the sector count of 0 (i.e. 256 actually). The 
> exact model was IBM DHEA-34331.

Several people reported this problem when we tried 256 years ago in
drivers/ide. You might want to do 256 for SATA Jeff but please don't do
256 for PATA. Reading specs is too hard for some people ;)

Some drives abort the xfer, some just choked.

