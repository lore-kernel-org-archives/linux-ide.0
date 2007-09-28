From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 16:55:41 +0100
Message-ID: <20070928165541.55f68756@the-village.bc.nu>
References: <1190521193410-git-send-email-htejun@gmail.com>
	<46F9BF3E.5050708@garzik.org>
	<46FD0D9E.7040808@rtr.ca>
	<46FD1F6D.5060805@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50929 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754417AbXI1PuF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 11:50:05 -0400
In-Reply-To: <46FD1F6D.5060805@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> So, there just hasn't been a real need so far.  If interrupt overhead 
> becomes an issue, my first step would be to start programming the 
> interrupt coalescing hardware that comes in modern SATA controllers.

Another factor is queue sizes. You don't get 1024 entry queues on your
typical disk controller and that makes NAPI type stuff less viable, and
sensible IRQ colaescing on the card more sane.

Alan

PS: Jeff - if you want stuff from -mm and it's got cross dependancies,
clashes just ask me for "patch xyz versus libata head" and I'll sort it
out
