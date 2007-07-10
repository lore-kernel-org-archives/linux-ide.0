From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Question about PATA Sil680 Bus Reset Code
Date: Wed, 11 Jul 2007 00:00:29 +0200
Message-ID: <200707110000.30029.bzolnier@gmail.com>
References: <8202f4270707090946q6ae5347ascd93a2bff6c2f281@mail.gmail.com> <20070709230908.08f5c8d8@the-village.bc.nu> <46938268.4070209@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.178]:21109 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761197AbXGJWEs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jul 2007 18:04:48 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1016694ika
        for <linux-ide@vger.kernel.org>; Tue, 10 Jul 2007 15:04:47 -0700 (PDT)
In-Reply-To: <46938268.4070209@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Fajun Chen <fajunchen@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Tuesday 10 July 2007, Sergei Shtylyov wrote:
> Alan Cox wrote:
> 
> >>    I guess it's been blindly copied over form drivers/ide/pci/siimage.c...
> 
>     Yet the order of events between IDE and libata drivers is different:
> the old driver's resetproc() method is called just after the twiddling the bit 
> on/off,  the new driver calls ata_std_softreset() after the PCI config. 
> register manipulation.  However, since all it does is set 2 read-only bits, it 
> should make no difference...
> 
> >>The code indeed does seem meaningless. For the libata it could make sense to 
> >>set bit 2 for the hardreset -- but then sil680_error_handler() needs to be 
> >>turn into ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, 
> >>sil680_bus_reset, ata_std_postreset)...
> >>    For the legacy driver, this function needs to be converted to something 
> >>sane too...
> 
> > I think the evidence based upon years of highly reliable siimage usage is
> > that its simply not needed 8)
> 
>     I would think so as well but was not sure about the SStatus reg. read at 
> the end of it...

Could you send a patch removing a said code?

Thanks,
Bart
