From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [RFC] libata IORDY handling
Date: Sun, 28 Jan 2007 21:22:59 +0300
Message-ID: <45BCEA03.8070901@ru.mvista.com>
References: <200701282024.17518.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:16209 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752476AbXA1SXI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Jan 2007 13:23:08 -0500
In-Reply-To: <200701282024.17518.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, htejun@gmail.com

Hello.

Sergei Shtylyov wrote:

> Fix PIO mode 1 overclocked taskfile transfers -- probably a typo carried over
> from drivers/ide/pci/siimage.c where I've found it by documentation check...

>  drivers/ata/pata_sil680.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/ata/pata_sil680.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/pata_sil680.c
> +++ linux-2.6/drivers/ata/pata_sil680.c
> @@ -135,7 +135,7 @@ static void sil680_error_handler(struct 
>  static void sil680_set_piomode(struct ata_port *ap, struct ata_device *adev)

    It's sad to say but there's another bug in this function (even a 
regression from drivers/ide/pci/siimage.c) -- the 16-bit IORDY is not enabled 
when setting PIO mode (there's code that twiddles IORDY enable but that's 
actually only for *taskfile* accesses, 16-bit IORDY is controlled by the same 
PCI  config. registers 80h/84h that enable DMA/UDMA transfer on SiI 680).
    I looked into fixing this but had a feeling that the thing wasn't right 
from the very start, including ata_pio_need_iordy().  In my understanding of 
the ANSI T13 stadrads, when one issues Set Features subcommand Set Transfer 
Mode with sector count register of 0x8 thru 0xC this means that IORDY *must* 
be enabled. That's what the ATA/ATAPI-6 says, for example:

         Table 45 - Transfer mode values
Mode                             Bits (7:3) Bits (2:0)
PIO default mode                 00000b     000b
PIO default mode, disable IORDY  00000b     001b
PIO *flow control* transfer mode 00001b     mode

    Comments?

MBR, Sergei
