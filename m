From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATA drivers in libata?
Date: Sun, 13 Feb 2005 19:16:38 -0500
Message-ID: <420FEDE6.20904@pobox.com>
References: <420FA1B9.6030100@pobox.com> <1108334326.19353.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65444 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261320AbVBNAQx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Feb 2005 19:16:53 -0500
In-Reply-To: <1108334326.19353.20.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Albert Lee <albertcc@tw.ibm.com>

Alan Cox wrote:
> On Sul, 2005-02-13 at 18:51, Jeff Garzik wrote:
> 
>>libata-dev now has two drivers that support PATA, pata_pdc2027x and 
>>ata_piix, and the core is getting close (DMA blacklist in, C/H/S support 
>>close).
> 
> 
> Do you have DMA change down sorted - CRC error, drop speed and/or switch
> to PIO then later flip back. Thats one real horror to get right and one
> thats badly screwy in the current IDE code (-ac IDE can hang the box for
> ages, base will sometimes crash)

Error handling is -very- stupid simple right now:  if we get an error, 
report that error in the struct request [based on your ATA -> SCSI sense 
conversion] back to upper layer.

It needs to be fleshed out into separate host bus / ATA bus / device 
errors, and handled accordingly.

	Jeff


