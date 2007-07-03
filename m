From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: how to handle pata_via when controller not in fully-pci-native
 mode (two irqs?)
Date: Tue, 3 Jul 2007 14:38:09 +0100
Message-ID: <20070703143809.5064fa35@the-village.bc.nu>
References: <467C689E.3050800@genesi-usa.com>
	<20070623103349.23cad9b7@the-village.bc.nu>
	<467CE8FA.2040304@genesi-usa.com>
	<20070623105344.3ece6db1@the-village.bc.nu>
	<467CF1E6.8000905@genesi-usa.com>
	<4689FBCB.90608@gmail.com>
	<468A04A0.1020003@genesi-usa.com>
	<20070703131736.5ddc0b89@the-village.bc.nu>
	<468A41CC.6030203@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:55059 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753046AbXGCNcH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 09:32:07 -0400
In-Reply-To: <468A41CC.6030203@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> > The right way to do this IMHO is still to use the PCI quirk side logic.
> > Unfortunately to put your legacy ports at different I/O addresses you
> > need changes which are still pending to the libata-sff code so that it
> > stops using the hardcoded ATA_PRIMARY_FOO bits.
> 
> We can't move the IO ports. They're stuck in the PCI BAR.

If you flag the chip up to report itself as legacy mode it'll assume
0x1F0 etc as the IO mapping address [however the PPC then maps that onto
its I/O maps depends on what the readb/writeb etc macros do].

The value in the PCI BAR is ignored in legacy mode, its not relevant or
valid. Currently libata then uses a hardcoded 0x1F0/7 etc which is wrong
as it should be asking for the pci_resource() values which are correctly
set in the PCI code [and can be tweaked for arch specials if need be]

