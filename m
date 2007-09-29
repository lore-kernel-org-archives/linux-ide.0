From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Sat, 29 Sep 2007 21:56:23 +0100
Message-ID: <20070929215623.030abd66@the-village.bc.nu>
References: <1190521193410-git-send-email-htejun@gmail.com>
	<46F9BF3E.5050708@garzik.org>
	<46FA1B4E.8090103@gmail.com>
	<46FD079F.3010007@garzik.org>
	<46FD0D50.8030602@gmail.com>
	<20070928155703.490d7575@the-village.bc.nu>
	<46FD1BAD.8020506@garzik.org>
	<20070928164312.208b8c56@the-village.bc.nu>
	<46FD2071.2070608@garzik.org>
	<46FD5D55.4070706@rtr.ca>
	<46FDC6A8.3000306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55104 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752748AbXI2Uvj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Sep 2007 16:51:39 -0400
In-Reply-To: <46FDC6A8.3000306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

ty today, with 3+ month kernel release cycles (ugh!!).
> 
> I'm very much interested in hearing suggestions and comments.

I think PMP should go in for 2.6.24 and then get revised over time to not
poll and to go via qc_issue. Which seems to be the consensus of everyone
but you on this one.

In general I have no big problems with the way its going - need to get
stuff through -mm into libata faster but thats something I need to sort
out with you specifically and I can accept your view its more my problem.

But PMP is a definite candidate for in ASAP

Alan
