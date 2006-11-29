From: Mark Lord <liml@rtr.ca>
Subject: Re: Scary Intel SATA errors..
Date: Wed, 29 Nov 2006 13:25:18 -0500
Message-ID: <456DD08E.4050402@rtr.ca>
References: <20061114150454.GA11900@havoc.gtf.org> <Pine.LNX.4.64.0611280853280.30076@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:19979 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S967512AbWK2SZV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Nov 2006 13:25:21 -0500
In-Reply-To: <Pine.LNX.4.64.0611280853280.30076@woody.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

Mmmm.. Tejun, here's a clue for what Linus saw on his system:

Right now I'm implementing support for READ/WRITE LONG commands via libata.

And the ata_piix driver gets into a non-recoverable state after successfully
doing a READ LONG command for me, a very similar state to what Linus reported.

But the ahci driver does NOT have this problem.  I haven't tried others.

The thing about R/W LONG, is that they transfer a single PIO sector of data,
PLUS an extra 4 (or more) words at the end.

Funny thing about ATAPI DVD/RW drives, is that they also transfer odd amounts
of data, non-multiples of 512.

I'm betting that the ata_piix hardware has some kind of internal pipeline that
gets confused *sometimes* when a non-512 multiple passes through.  Rarely, though.

I wonder if there's something on that device that we could bit-bang to reset 
it's internal pipelines?

Cheers
