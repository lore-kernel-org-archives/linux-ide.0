From: Mark Lord <liml@rtr.ca>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 10:20:14 -0400
Message-ID: <46FD0D9E.7040808@rtr.ca>
References: <1190521193410-git-send-email-htejun@gmail.com> <46F9BF3E.5050708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3596 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756805AbXI1OUP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 10:20:15 -0400
In-Reply-To: <46F9BF3E.5050708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
..
> As such, polling is simply an outmoded concept.  It does not make sense 
> on new hardware, and forcing design decisions down that path only lead 
> to a cascade of similar design decisions -- pmp_read polling being just 
> one example of such a result.

A related tangent here, but I wonder if someday we might consider
something like NAPI for libata.  Our I/O rates can far exceed those of the
network stack, and there polling (NAPI) has helped quite a bit.

But our data behaviour is mostly synchronous, whereas network stuff is more
asynchronous.   But still, with multiple drives all using NCQ on a port,
a polled interface option might give higher throughput and lower CPU loading.

Just like with the networking code.

Not that this specifically relates to concerns with the current PMP patches,
but I'm curious where Jeff sees this all going, as he works on both sides.

Cheers
