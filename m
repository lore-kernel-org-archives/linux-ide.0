From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Question about PATA Sil680 Bus Reset Code
Date: Mon, 09 Jul 2007 12:58:20 -0400
Message-ID: <4692692C.2070908@garzik.org>
References: <8202f4270707090946q6ae5347ascd93a2bff6c2f281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49536 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740AbXGIQ6Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Jul 2007 12:58:25 -0400
In-Reply-To: <8202f4270707090946q6ae5347ascd93a2bff6c2f281@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>

Fajun Chen wrote:
> Hi,
> 
> Could someone help me interpret the code snippet below:
> static int sil680_bus_reset(struct ata_port *ap,unsigned int *classes)
> {
>        struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>        unsigned long addr = sil680_selreg(ap, 0);
>        u8 reset;
> 
>        pci_read_config_byte(pdev, addr, &reset);
>        pci_write_config_byte(pdev, addr, reset | 0x03);   // ?
>        udelay(25);
>        pci_write_config_byte(pdev, addr, reset);
>        return ata_std_softreset(ap, classes);
> }
> 
> Based on Sil680 data sheet, channel reset bit is bit 2,  why the reset
> code above is not "pci_write_config_byte(pdev, addr, reset | 0x04);"?

Definitely looks like a bug to me.

Channel reset is bit 2 in SiI 311x SATA family as well.

	Jeff



