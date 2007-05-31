From: Mark Lord <lkml@rtr.ca>
Subject: Re: Compact Flash performance...
Date: Thu, 31 May 2007 08:22:56 -0400
Message-ID: <465EBE20.6090803@rtr.ca>
References: <6278d2220705301510y2d81f69eu38fb778d32de05e1@mail.gmail.com>	 <465E3FF0.9010709@rtr.ca> <6278d2220705310222rde9ad28ndfd8feced84a3c6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3557 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756771AbXEaMW6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 May 2007 08:22:58 -0400
In-Reply-To: <6278d2220705310222rde9ad28ndfd8feced84a3c6f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>

Daniel J Blueman wrote:
> Hi Mark,
> 
> Thanks for the reply; here is the raw identification data:
> 
> # hdparm --Istdout /dev/sdb
> 
> /dev/sdb:
> 045a 3fff c837 0010 0000 0000 003f 0000
> 0000 0000 2020 2020 2020 5644 5334 3142
> 5434 4456 3038 474a 0003 3bf5 0034 5634
> 344f 4139 3641 4844 5437 3232 3532 3544
> 4c41 3338 3020 2020 2020 2020 2020 2020

ATA device, with non-removable media
        Model Number:       HDT722525DLA380
        Serial Number:      VDS41BT4DV08GJ
        Firmware Revision:  V44OA96A
...
        device size with M = 1000*1000:      250059 MBytes (250 GB)
...
           *    SATA-I signaling speed (1.5Gb/s)
           *    SATA-II signaling speed (3.0Gb/s)


Ooops.. wrong drive.  That's NOT a CF card.   Try again?

Thanks
