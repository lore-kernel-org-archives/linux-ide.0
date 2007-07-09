From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Question about PATA Sil680 Bus Reset Code
Date: Mon, 9 Jul 2007 23:09:08 +0100
Message-ID: <20070709230908.08f5c8d8@the-village.bc.nu>
References: <8202f4270707090946q6ae5347ascd93a2bff6c2f281@mail.gmail.com>
	<46928051.5080907@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34321 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755436AbXGIWDP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 18:03:15 -0400
In-Reply-To: <46928051.5080907@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Fajun Chen <fajunchen@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

>     I guess it's been blindly copied over form drivers/ide/pci/siimage.c...
> The code indeed does seem meaningless. For the libata it could make sense to 
> set bit 2 for the hardreset -- but then sil680_error_handler() needs to be 
> turn into ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, 
> sil680_bus_reset, ata_std_postreset)...
>     For the legacy driver, this function needs to be converted to something 
> sane too...

I think the evidence based upon years of highly reliable siimage usage is
that its simply not needed 8)
