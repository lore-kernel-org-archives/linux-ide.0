From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Question about PATA Sil680 Bus Reset Code
Date: Tue, 10 Jul 2007 16:58:16 +0400
Message-ID: <46938268.4070209@ru.mvista.com>
References: <8202f4270707090946q6ae5347ascd93a2bff6c2f281@mail.gmail.com>	<46928051.5080907@ru.mvista.com> <20070709230908.08f5c8d8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:13249 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751043AbXGJM4Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 08:56:16 -0400
In-Reply-To: <20070709230908.08f5c8d8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Fajun Chen <fajunchen@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Alan Cox wrote:

>>    I guess it's been blindly copied over form drivers/ide/pci/siimage.c...

    Yet the order of events between IDE and libata drivers is different:
the old driver's resetproc() method is called just after the twiddling the bit 
on/off,  the new driver calls ata_std_softreset() after the PCI config. 
register manipulation.  However, since all it does is set 2 read-only bits, it 
should make no difference...

>>The code indeed does seem meaningless. For the libata it could make sense to 
>>set bit 2 for the hardreset -- but then sil680_error_handler() needs to be 
>>turn into ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, 
>>sil680_bus_reset, ata_std_postreset)...
>>    For the legacy driver, this function needs to be converted to something 
>>sane too...

> I think the evidence based upon years of highly reliable siimage usage is
> that its simply not needed 8)

    I would think so as well but was not sure about the SStatus reg. read at 
the end of it...

MBR, Sergei
