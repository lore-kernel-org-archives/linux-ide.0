From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_via: SError: { UnrecovData Proto TrStaTrns }
Date: Mon, 5 Oct 2009 16:37:38 +0200
Message-ID: <19146.1202.511428.691521@pilspetsen.it.uu.se>
References: <m3my46yo5g.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:44325 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbZJEOjC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Oct 2009 10:39:02 -0400
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
 > 
 > Any ideas?

Try again with a known good SATA disk instead of the SSD.

What is the make and model of that mini-PCI card?
