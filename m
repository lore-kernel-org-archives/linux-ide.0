From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Scary Intel SATA errors..
Date: Wed, 29 Nov 2006 18:42:07 +0000
Message-ID: <20061129184207.68a57ea9@localhost.localdomain>
References: <20061114150454.GA11900@havoc.gtf.org>
	<Pine.LNX.4.64.0611280853280.30076@woody.osdl.org>
	<456DD08E.4050402@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63467 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S967523AbWK2SgA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Nov 2006 13:36:00 -0500
In-Reply-To: <456DD08E.4050402@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

On Wed, 29 Nov 2006 13:25:18 -0500
Mark Lord <liml@rtr.ca> wrote:

> I'm betting that the ata_piix hardware has some kind of internal pipeline that
> gets confused *sometimes* when a non-512 multiple passes through.  Rarely, though.

It will do this if the FIFO setup is misconfigured.
 
> I wonder if there's something on that device that we could bit-bang to reset 
> it's internal pipelines?

That would cripple performance and just ask for more bizarre bugs.
Firstly I think it makes sense to verify/play with the fifo and prefetch
setup then verify the problem case and see what Intel think.

Alan
