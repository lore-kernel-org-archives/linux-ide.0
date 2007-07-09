From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Question about PATA Sil680 Bus Reset Code
Date: Mon, 09 Jul 2007 22:37:05 +0400
Message-ID: <46928051.5080907@ru.mvista.com>
References: <8202f4270707090946q6ae5347ascd93a2bff6c2f281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5267 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754082AbXGISfE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Jul 2007 14:35:04 -0400
In-Reply-To: <8202f4270707090946q6ae5347ascd93a2bff6c2f281@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hello.

Fajun Chen wrote:

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

    I guess it's been blindly copied over form drivers/ide/pci/siimage.c...
The code indeed does seem meaningless. For the libata it could make sense to 
set bit 2 for the hardreset -- but then sil680_error_handler() needs to be 
turn into ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, 
sil680_bus_reset, ata_std_postreset)...
    For the legacy driver, this function needs to be converted to something 
sane too...

> Thanks in advance!

MBR, Sergei
