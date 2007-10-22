From: Jeff Garzik <jeff@garzik.org>
Subject: Re: AHCI with ATA/IDE Drives
Date: Mon, 22 Oct 2007 16:09:27 -0400
Message-ID: <471D0377.10008@garzik.org>
References: <a14fb1800710200440hbcb0438sf2b0ee627e6e8209@mail.gmail.com> <471A09B8.2040708@rtr.ca> <471C6EC1.6000703@gmail.com> <20071022112247.63d517a5@the-village.bc.nu> <a14fb1800710221256seaae502m8092f38ba6183cc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53370 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233AbXJVUJd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 16:09:33 -0400
In-Reply-To: <a14fb1800710221256seaae502m8092f38ba6183cc8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Girish Shirasat <girish.shirasat@googlemail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

Girish Shirasat wrote:
> Hello All,
>     Thanks for your replies. If we see the dump, you will observe that
> the NAND flash supports the MDMA2 but the driver does not set it but
> goes in for PIO4. On looking at the ata_port_info  structure populated
> in case of 3100 SATA controller chipset namely the first entry, the
> mwdma mask is not initialized causing the driver to skip the same and
> go in for PIO modes. When I did add the MDMA mask, everything fell in
> place and I was able to access the flash devices.
>      Can you please let me know if there is any specific reason as to
> why the mdma masks are not added in the ata_port_info initialisations.

We are talking about AHCI, right?

Just an oversight IIRC.  ISTR the original logic was somewhat of a 
guess, since ahci.c was originally written in the early SATA days -- and 
also admittedly when I understood less about SATA.  I was worried about 
controller snooping, and also did not think it would be needed to 
support MWDMA, when UDMA was supported.

Obviously those were flawed trains of thought, in hindsight.

	Jeff



