From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What's in libata-dev.git
Date: Mon, 11 Sep 2006 17:26:37 +0100
Message-ID: <1157991998.23085.164.camel@localhost.localdomain>
References: <20060911132250.GA5178@havoc.gtf.org>
	 <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org>
	 <450568F3.3020005@ru.mvista.com>
	 <1157986974.23085.147.camel@localhost.localdomain>
	 <45057651.8000404@garzik.org>
	 <1157988513.23085.159.camel@localhost.localdomain>
	 <20060911153706.GE4955@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8159 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964947AbWIKQE0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Sep 2006 12:04:26 -0400
In-Reply-To: <20060911153706.GE4955@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Ar Llu, 2006-09-11 am 17:37 +0200, ysgrifennodd Jens Axboe:
> On Mon, Sep 11 2006, Alan Cox wrote:
> > sometimes. The IBM's abort the xfer but the maxtors may or may not get
> > it right (its as if half the firmware has the right test).
> 
> So this is a confirmed, broken case? Why has no one complained for 2.4
> and 2.6?

They did and proposed patches.

Alan

