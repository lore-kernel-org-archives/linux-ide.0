From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH] fix IDE legacy mode resource
Date: Sun, 29 Jul 2007 17:15:44 +0900
Message-ID: <20070729171544.2b352801.yoichi_yuasa@tripeaks.co.jp>
References: <20070728220420.352c316b.yoichi_yuasa@tripeaks.co.jp>
	<46AB8732.6080109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo30.po.2iij.net ([210.128.50.53]:4572 "EHLO mo30.po.2iij.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760078AbXG2IQN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jul 2007 04:16:13 -0400
In-Reply-To: <46AB8732.6080109@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: yoichi_yuasa@tripeaks.co.jp, greg@kroah.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On Sat, 28 Jul 2007 14:13:06 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Yoichi Yuasa wrote:
> > Hi,
> > 
> > I got the following error on MIPS Cobalt.
> > MIPS Cobalt has the 0x10000000 offset between resource and bus region. 
> > 
> > PCI: Unable to reserve I/O region #1:8@f00001f0 for device 0000:00:09.1
> > pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)
> > PCI: Unable to reserve I/O region #3:8@f0000170 for device 0000:00:09.1
> > pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)
> > pata_via 0000:00:09.1: no available native port
> > 
> > At this point, these resources should be the bus regions.
> > 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> I'm not sure I understand what's going on here... could you or someone 
> provide additional explanation as to why this is a fix?

The legacy mode IDE resources set the following order. 

pci_setup_device()
    Legacy mode ATA controllers have fixed addresses.
    IDE resources: 0x1F0-0x1F7, 0x3F6, 0x170-0x177, 0x376
    |
    V
pcibios_fixup_bus()
    MIPS Cobalt PCI bus have the -0x10000000 offset from PCI resources.
    pcibios_fixup_bus() fix PCI bus regions.
    0x1F0 - 0x10000000 = 0xF00001F0
    |
    V
ata_pci_init_one()
    PCI: Unable to reserve I/O region #1:8@f00001f0 for device 0000:00:09.1

In some architectures, PCI bus have the offset from PCI resource.
They are adjusted by pcibios_fixup_bus().

For this reason, pci_setup_device() should set PCI bus regions. 

Yoichi
