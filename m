From: "Girish Shirasat" <girish.shirasat@googlemail.com>
Subject: Re: AHCI with ATA/IDE Drives
Date: Mon, 22 Oct 2007 20:56:50 +0100
Message-ID: <a14fb1800710221256seaae502m8092f38ba6183cc8@mail.gmail.com>
References: <a14fb1800710200440hbcb0438sf2b0ee627e6e8209@mail.gmail.com>
	 <471A09B8.2040708@rtr.ca> <471C6EC1.6000703@gmail.com>
	 <20071022112247.63d517a5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:25559 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbXJVT4w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Oct 2007 15:56:52 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1295117fkz
        for <linux-ide@vger.kernel.org>; Mon, 22 Oct 2007 12:56:50 -0700 (PDT)
In-Reply-To: <20071022112247.63d517a5@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>

Hello All,
    Thanks for your replies. If we see the dump, you will observe that
the NAND flash supports the MDMA2 but the driver does not set it but
goes in for PIO4. On looking at the ata_port_info  structure populated
in case of 3100 SATA controller chipset namely the first entry, the
mwdma mask is not initialized causing the driver to skip the same and
go in for PIO modes. When I did add the MDMA mask, everything fell in
place and I was able to access the flash devices.
     Can you please let me know if there is any specific reason as to
why the mdma masks are not added in the ata_port_info initialisations.

Regards,
Girish

On 10/22/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mon, 22 Oct 2007 18:34:57 +0900
> Tejun Heo <htejun@gmail.com> wrote:
>
> > Mark Lord wrote:
> > > Alan / Tejun,
> > >
> > > Another case of MDMA2 not working through a SATA->PATA bridge.
> > > Do we have an easy way yet, for Girish to force non-MDMA2 modes?
> >
> > libata.dma=1 should do the trick for 2.6.24-rcX.  For 2.6.23, there
> > isn't any.  :-(
>
> For CF specifying libata.dma=3 should do the trick even better as it will
> leave DMA enabled on disk and ATAPI
>
