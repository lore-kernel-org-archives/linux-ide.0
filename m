From: "Andrew Paprocki" <andrew.m.paprocki@gmail.com>
Subject: Re: [PATCH] pata_cs5536: ATA driver for Geode companion chip
Date: Sun, 14 Oct 2007 16:57:18 -0400
Message-ID: <76366b180710141357q7dcc5a25qf7db24d9f747d5df@mail.gmail.com>
References: <yq1y7eahzis.fsf@sermon.lab.mkp.net>
	 <20071011112021.3be68418@the-village.bc.nu>
	 <76366b180710132149i7dabb3dcv21abaafd5814a923@mail.gmail.com>
	 <76366b180710141242w5ff89d9ej9cfdc1a5904639e@mail.gmail.com>
	 <20071014205103.177bd08d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:23820 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798AbXJNU5S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Oct 2007 16:57:18 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1269350rvb
        for <linux-ide@vger.kernel.org>; Sun, 14 Oct 2007 13:57:18 -0700 (PDT)
In-Reply-To: <20071014205103.177bd08d@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, jordan.crouse@amd.com

Long story short -- this has nothing to do with pata_cs5536.

It isn't in that list! I just patched my kernel to print the reason
why it is being blacklisted and this turned up:

ata5.00: ATA-0: , 060729DA, max MWDMA2
ata5.00: 256000 sectors, multi 1: LBA
ata5.00: device is on DMA blacklist, disabling DMA
ata5.00: device matched DMA blacklist, model: WDC AC11000H
ata5.00: configured for PIO4

The strn_pattern_cmp function does not handle blank model names. I
would like to give this Taiwanese manufacturer a bug for not bothering
to put a model name on their device, but I don't think they'll care
too much.. :)

I just submitted a patch to fix strn_pattern_cmp to handle the
strlen(name)==0 case appropriately (ie only match it against "*" or
"").

With that change, it is properly detected as MWDMA2 again:

ata5.00: ATA-0: , 060729DA, max MWDMA2
ata5.00: 256000 sectors, multi 1: LBA
ata5.00: configured for MWDMA2
ata5.00: configured for MWDMA2

Thanks,
-Andrew

On 10/14/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sun, 14 Oct 2007 15:42:19 -0400
> "Andrew Paprocki" <andrew.m.paprocki@gmail.com> wrote:
>
> > Just noticed something.. I'm not sure if this is due to a libata-dev
> > change or me switching to pata_cs5536, but my 128MB DOM on the PATA
> > port is hitting the ata_dma_blacklisted() case and it was not
> > previously. This did not happen under 2.6.22.6 using pata_amd. The
> > system is noticeably slower when forced to use PIO4 (as you would
> > expect).
> >
> > Is this expected in the newer code, or is it a bug?
>
> Sounds like someone added it wrongly to the blacklist. Remove the
> blacklist entry, test again and if DMA is working we need to get that
> fixed ASAP in .2 and 2.6.24.
>
> Alan
