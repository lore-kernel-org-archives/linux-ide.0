From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA drivers in libata?
Date: Mon, 14 Feb 2005 20:42:02 +0000
Message-ID: <1108405679.23533.20.camel@localhost.localdomain>
References: <420FA1B9.6030100@pobox.com>
	 <1108334326.19353.20.camel@localhost.localdomain>
	 <420FEDE6.20904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from [81.2.110.250] ([81.2.110.250]:981 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261570AbVBNVr1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Feb 2005 16:47:27 -0500
In-Reply-To: <420FEDE6.20904@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Albert Lee <albertcc@tw.ibm.com>

On Llu, 2005-02-14 at 00:16, Jeff Garzik wrote:
> Error handling is -very- stupid simple right now:  if we get an error, 
> report that error in the struct request [based on your ATA -> SCSI sense 
> conversion] back to upper layer.
> 
> It needs to be fleshed out into separate host bus / ATA bus / device 
> errors, and handled accordingly.

Thats a barrier to real PATA IDE I guess then. We see a lot of cable
errors and speed change downs and not all are caused by misdetecting
80wire cables.

The current IDE layer does speed changes synchronously outside the state
machine which makes a nasty mess when your error handling interrupt
state wants to speed change.

Alan

