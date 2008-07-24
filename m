From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 1/1] LIBATA: Allow devices without IRQ specified to fall back
Date: Thu, 24 Jul 2008 19:05:22 +0200
Message-ID: <200807241905.22959.bzolnier@gmail.com>
References: <20080723144227.253944199@fluff.org> <200807241812.32988.bzolnier@gmail.com> <20080724170650.07b542d5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:60935 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbYGXRIe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 13:08:34 -0400
Received: by ug-out-1314.google.com with SMTP id h2so615364ugf.16
        for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2008 10:08:32 -0700 (PDT)
In-Reply-To: <20080724170650.07b542d5@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, vince@simtec.co.uk

On Thursday 24 July 2008, Alan Cox wrote:
> > Please note that the recommended PATA support in kernel.org kernels
> > is IDE subsystem and libata PATA is still considered experimental.
> 
> This is false. Most distributions now use libata, and the old IDE code
> has recently had an enormous amount of patching so is if anything far
> more experimental than libata.

*) I was talking primarily in ALi PATA context:

config PATA_ALI
        tristate "ALi PATA support (Experimental)"
        depends on PCI && EXPERIMENTAL
...

config BLK_DEV_ALI15X3
        tristate "ALI M15x3 chipset support"
        select IDE_TIMINGS
        select BLK_DEV_IDEDMA_PCI
...

*) Distributions are of course free to do make their own decisions.

*) By using this measurement of 'experimental', x86 would probably won
   as the most experimental arch and networking as the most experimental
   subsystem.  I'm proud that you put 'old' IDE code in the same class! :)

> > - add PCI HEADER quirk to claim legacy mode (as suggested by Alan)
> > 
> > - move ALi IRQ handling code to PCI layer and then hook it into
> >   pci_get_legacy_ide_irq()
> 
> The second isn't needed and will happen automatically if the chip is
> properly configured (again see the BIOS writers guide)

The second is of course optional for properly configured chips but it is
not much of work and better be safe than sorry (also which 'BIOS writers
guide' exactly are you referring to?).

Thanks,
Bart
