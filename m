From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Question about PATA Sil680 Bus Reset Code
Date: Mon, 9 Jul 2007 10:46:54 -0600
Message-ID: <8202f4270707090946q6ae5347ascd93a2bff6c2f281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:15605 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbXGIQqz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 12:46:55 -0400
Received: by an-out-0708.google.com with SMTP id d31so191638and
        for <linux-ide@vger.kernel.org>; Mon, 09 Jul 2007 09:46:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi,

Could someone help me interpret the code snippet below:
static int sil680_bus_reset(struct ata_port *ap,unsigned int *classes)
{
        struct pci_dev *pdev = to_pci_dev(ap->host->dev);
        unsigned long addr = sil680_selreg(ap, 0);
        u8 reset;

        pci_read_config_byte(pdev, addr, &reset);
        pci_write_config_byte(pdev, addr, reset | 0x03);   // ?
        udelay(25);
        pci_write_config_byte(pdev, addr, reset);
        return ata_std_softreset(ap, classes);
}

Based on Sil680 data sheet, channel reset bit is bit 2,  why the reset
code above is not "pci_write_config_byte(pdev, addr, reset | 0x04);"?

Thanks in advance!

Fajun
