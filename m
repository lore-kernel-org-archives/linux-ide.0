From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: adding Pegasus IDE quirk for pata_via
Date: Thu, 05 Apr 2007 09:52:18 +1000
Message-ID: <1175730738.30879.103.camel@localhost.localdomain>
References: <20070404111635.GA1855@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:32992 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857AbXDDXw3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2007 19:52:29 -0400
In-Reply-To: <20070404111635.GA1855@aepfle.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Wed, 2007-04-04 at 13:16 +0200, Olaf Hering wrote:
> The pegaos board needs an irq quirk in pata_via.
> Where is the quirk list for libata? I dont see one in pata_via.c
> 
> drivers/ide/pci/via82cxxx.c:init_hwif_via82cxxx()
> 
>     440 #ifdef CONFIG_PPC_CHRP
>     441         if(machine_is(chrp) && _chrp_type == _CHRP_Pegasos) {
>     442                 hwif->irq = hwif->channel ? 15 : 14;
>     443         }
>     444 #endif
> 
> 
> This is in the firmware node. Will a fixup of the 'interrupts' property
> work or does everything poke directly at the PCI registers?
> Should fixup_device_tree_chrp() take care of the 'interrupts' property?

Nothing standard will work. A PCI device isn't supposed to have more
than one interrupt per function and this one needs 2. It's the VIA
chipset being out of specs as usual.

Ben.


