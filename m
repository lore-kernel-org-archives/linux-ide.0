From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA drivers in libata?
Date: Sun, 13 Feb 2005 22:38:47 +0000
Message-ID: <1108334326.19353.20.camel@localhost.localdomain>
References: <420FA1B9.6030100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from [81.2.110.250] ([81.2.110.250]:59341 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261318AbVBMXoO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Feb 2005 18:44:14 -0500
In-Reply-To: <420FA1B9.6030100@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Albert Lee <albertcc@tw.ibm.com>

On Sul, 2005-02-13 at 18:51, Jeff Garzik wrote:
> libata-dev now has two drivers that support PATA, pata_pdc2027x and 
> ata_piix, and the core is getting close (DMA blacklist in, C/H/S support 
> close).

Do you have DMA change down sorted - CRC error, drop speed and/or switch
to PIO then later flip back. Thats one real horror to get right and one
thats badly screwy in the current IDE code (-ac IDE can hang the box for
ages, base will sometimes crash)

> * With ATA passthru (in libata-dev currently), libata supports SMART and 
> the HDIO_CMD/HDIO_TASK generalized ioctls.  Should I care about 
> supporting other ioctls?

I'd rather the libata driver just had the sane ioctls

> * pci_enable_device() issues?

Nothing really special there, pci_disable_device can be funny thats all.

> * power management differences?

AFAIK only the "I have a cache but no flush command" issue

I'm all for burying the old IDE layer

