From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Impact of no_lba48{_dma} = 1 ?
Date: Wed, 7 Feb 2007 11:58:26 +0000
Message-ID: <20070207115826.2e3609e3@localhost.localdomain>
References: <45C9A23E.3030201@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42676 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161220AbXBGLpb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 06:45:31 -0500
In-Reply-To: <45C9A23E.3030201@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org

> And wrote a evry simple IDE driver for it. BAsicly the HDD internbal
> registers are just memory mapped. No DMA is supported by the hardware.
> But I think it would be capable of 48bit LBA mode (which just means setting
> the HOB bit in the device control register of the HDD correctly?)

And not caching stuff wrongly

> 
> Now I wonder what the impact of setting
> 
> 	hwif->no_lba48 = 1;		/* 1 = cannot do LBA48 */
> 	hwif->no_lba48_dma = 1;		/* 1 = cannot do LBA48 DMA */

no_lba48_dma turns off the use of DMA for 48bit commands, the kernel
tries to issue DMA commands where possible but if it cannot issues LBA48
PIO commands (eg for the end part of a disk)

no_lba48 disables LBA48 so you won't be able to access the further parts
of the disk or some newer features.

> would be.
> 
> IIUC then no_lba48 would limit the useable size to 130GB?
> Will every HDD work with no_lba48 set to 1? Even those which actually
> support 48bit LBA?

No guarantees, but you ought to be able to use the first part of the disk
ok.
 
> How about performance impact of
> 
> 		if (hwif->no_lba48 || hwif->no_lba48_dma)
> 			hwif->rqsize = 256;
> 		else
> 			hwif->rqsize = 65536;
> 
> in ide-probe.c ?

Only relevant for DMA really

