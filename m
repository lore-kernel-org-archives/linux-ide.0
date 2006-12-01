From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Scary Intel SATA errors..
Date: Fri, 1 Dec 2006 19:42:05 +0000
Message-ID: <20061201194205.4313c508@localhost.localdomain>
References: <20061114150454.GA11900@havoc.gtf.org>
	<Pine.LNX.4.64.0611280853280.30076@woody.osdl.org>
	<456DD08E.4050402@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4750 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1031754AbWLATfS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Dec 2006 14:35:18 -0500
In-Reply-To: <456DD08E.4050402@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On Wed, 29 Nov 2006 13:25:18 -0500
Mark Lord <liml@rtr.ca> wrote:

> Mmmm.. Tejun, here's a clue for what Linus saw on his system:
> 
> Right now I'm implementing support for READ/WRITE LONG commands via libata.
> 
> And the ata_piix driver gets into a non-recoverable state after successfully
> doing a READ LONG command for me, a very similar state to what Linus reported.

Looks like it may in fact be a chip erratum. Turn off PPE unconditionally
and try and repeat it (if you look at ata_piix right now its turned off
for ATAPI only).

Alan
