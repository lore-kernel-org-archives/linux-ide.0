From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Fix simplex adapters with libata
Date: Fri, 09 Mar 2007 07:39:08 -0500
Message-ID: <45F1556C.3000505@garzik.org>
References: <20070308091211.GA7257@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55581 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964935AbXCIMjL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:39:11 -0500
In-Reply-To: <20070308091211.GA7257@vana.vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <petr@vandrovec.name>
Cc: linux-ide@vger.kernel.org

Petr Vandrovec wrote:
> Hello Jeff,
> 
> [please cc me, I'm not subscribed to linux-ide]
> 
> Recently I got my hands on nVidia's MCP61 PM-AM board, and
> it contains IDE chip configured by BIOS with only primary
> channel enabled.  This confuses code which probes for
> device DMA capabilities - it gets 0x60 (happy duplex
> device) from primary channel BMDMA, but 0xFF (nobody here)
> from secondary channel BMDMA.  Due to this code then believes
> that chip is simplex.  I do not address this problem in
> my patch, as I'm not sure how to handle this.  Probably
> ata_pci_init_one should have bitmap of enabled/possible
> interfaces instead of their count, but it looks like
> quite intrusive change, and maybe we do not care - for device
> with only one channel simplex and regular DMA engines are
> same.
> 
> But making device simplex pointed out that support for
> DMA on simplex devices is currently broken - ata_dev_xfermask
> tests whether device is simplex and if it is whether DMA
> engine was assigned to this port.  If not then it strips
> out DMA bits from device.  Problem is that code which assigns
> DMA engine to port in ata_set_mode first detect device
> mode and assigns DMA engine to channel only if some DMA
> capable device was found.
> 
> And as xfermask stripped out DMA bits, host->simplex_claimed
> is always NULL with current implementation.
> 
> By allowing DMA either if simplex_claimed is NULL or if it
> points to current port DMA can be finally used - it gets
> assigned to first port which contains any DMA capable
> device.
> 
> Patch is for current Linus git tree (post 2.6.21-rc3).
> 				Thanks,
> 					Petr Vandrovec
> 
> Before:
> pata_amd 0000:00:06.0: version 0.2.8
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> ata5: PATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f000 irq 14
> ata6: PATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f008 irq 15
> scsi4 : pata_amd
> ata5.00: ATAPI, max UDMA/66
> ata5.00: simplex DMA is claimed by other device, disabling DMA
> ata5.00: configured for PIO4
> scsi5 : pata_amd
> ata6: port disabled. ignoring.
> ata6: reset failed, giving up
> scsi 4:0:0:0: CD-ROM            ATAPI    DVD W  DH16W1P   LG12 PQ: 0 ANSI: 5
> 
> After:
> pata_amd 0000:00:06.0: version 0.2.8
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> ata5: PATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f000 irq 14
> ata6: PATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f008 irq 15
> scsi4 : pata_amd
> ata5.00: ATAPI, max UDMA/66
> ata5.00: configured for UDMA/33
> scsi5 : pata_amd
> ata6: port disabled. ignoring.
> ata6: reset failed, giving up
> scsi 4:0:0:0: CD-ROM            ATAPI    DVD W  DH16W1P   LG12 PQ: 0 ANSI: 5
> 
> Signed-off-by: Petr Vandrovec <petr@vandrovec.name>

applied to #upstream-fixes


