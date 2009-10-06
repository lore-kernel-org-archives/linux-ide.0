From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_via: SError: { UnrecovData Proto TrStaTrns }
Date: Tue, 6 Oct 2009 18:26:46 +0200
Message-ID: <19147.28614.505296.752363@pilspetsen.it.uu.se>
References: <m3my46yo5g.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:38706 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbZJFQ1a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Oct 2009 12:27:30 -0400
In-Reply-To: <m3my46yo5g.fsf@intrepid.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Krzysztof Halasa writes:
 > Hi,
 > 
 > What could that be?
 > VIA VT6421A mini-PCI card and SATA SSD from Transcend. IXP425 (ARM)
 > little-endian CPU. 128 MB RAM - VT6421A can access only the first 64 MB
 > of system RAM, but there is bounce buffering (a la swiotlb) for the
 > rest.
 > 
 > Sometimes it produces:
 > 
 > ata1.00: exception Emask 0x12 SAct 0x0 SErr 0x1000500 action 0x6
 > ata1.00: BMDMA stat 0x5
 > ata1: SError: { UnrecovData Proto TrStaTrns }
 > ata1.00: cmd c8/00:20:b7:18:38/00:00:00:00:00/e0 tag 0 dma 16384 in
 >          res 51/40:20:b7:18:38/00:00:00:00:00/e0 Emask 0x12 (ATA bus error)
 > ata1.00: status: { DRDY ERR }
 > ata1.00: error: { UNC }
 > ata1: hard resetting link
 > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 > ata1.00: configured for UDMA/100
 > ata1: EH complete

I got (in private) a request to help debug a similar issue
a few months ago:

 > the other problem is vt6421a(SATA port contorller) on ixp425
 > platform with 256MB ram. the driver in 2.6.28 is sata_via.c.
 > the controller has two SATA ports.
 > when i connect one harddisk to IXP425 mainboard, Reading & Writing
 > is all right. but when i connected two drives to the mainboard,
 > and transfer a big file(more than 200MB) from one harddisk to another one. 
 > and the problem will happen.
...
 > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
 > ata2.00: cmd c8/00:00:3f:d6:02/00:00:00:00:00/e0 tag 0 dma 131072 in
 >          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x24 (host bus error)
 > ata2.00: status: { DRDY }
 > ata2: hard resetting link
 > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 > ata2.00: configured for UDMA/133
 > ata2: EH complete
...
 > ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
 > ata1.00: cmd c8/00:20:c7:6a:03/00:00:00:00:00/e0 tag 0 dma 16384 in
 >          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x24 (host bus error)
 > ata1.00: status: { DRDY }
 > ata1: hard resetting link
 > ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 > ata1.00: configured for UDMA/133
 > ata1: EH complete

I couldn't do much about it other than ask the person to take
it to linux-ide (which I don't think he did), but it does make
one wonder if there is some issue with the vt6421a when connected
to an ixp4xx.
