From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PATA drivers in libata?
Date: Thu, 17 Feb 2005 12:13:43 +1100
Message-ID: <1108602823.5382.11.camel@gaston>
References: <420FA1B9.6030100@pobox.com>
	 <1108334326.19353.20.camel@localhost.localdomain>
	 <420FEDE6.20904@pobox.com>
	 <1108405679.23533.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from gate.crashing.org ([63.228.1.57]:6813 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262185AbVBQBOM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2005 20:14:12 -0500
In-Reply-To: <1108405679.23533.20.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Albert Lee <albertcc@tw.ibm.com>

On Mon, 2005-02-14 at 20:42 +0000, Alan Cox wrote:
> On Llu, 2005-02-14 at 00:16, Jeff Garzik wrote:
> > Error handling is -very- stupid simple right now:  if we get an error, 
> > report that error in the struct request [based on your ATA -> SCSI sense 
> > conversion] back to upper layer.
> > 
> > It needs to be fleshed out into separate host bus / ATA bus / device 
> > errors, and handled accordingly.
> 
> Thats a barrier to real PATA IDE I guess then. We see a lot of cable
> errors and speed change downs and not all are caused by misdetecting
> 80wire cables.
> 
> The current IDE layer does speed changes synchronously outside the state
> machine which makes a nasty mess when your error handling interrupt
> state wants to speed change.

It's not _too_ bad ... you can just put the current request "on
hold" (and block the queue) until the thread finishes with the speed
change, but I tend to think nowadays that the state machine approach
might be better in the long run (even if a bit more complex to implement
in the first place).

Ben.


