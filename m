From: linux@horizon.com
Subject: Re: Which SATA Combos To Consider?
Date: 21 Feb 2005 09:25:01 -0000
Message-ID: <20050221092501.15349.qmail@science.horizon.com>
Received: from science.horizon.com ([192.35.100.1]:13360 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261930AbVBUJZC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Feb 2005 04:25:02 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, linux@horizon.com

> In terms of hardware, AHCI (from Intel/SiS/ULi/others) and Silicon Image 
> 3124 are the best of the current generation of "FIS-based" SATA-II 
> controllers.  With these controllers, ATA controllers are __finally__ as 
> efficient as SCSI controllers have been for years.
> 
> For SATA-I controllers, I tend to feel that the Promise SATA cards 
> driven by the sata_promise driver are decent.
> 
> The rest of the SATA-I controllers all pretty much look the same, 
> hardware-wise:  Decade-old PATA controller interface with PCI 
> extensions, with further SATA extensions (SATA phy registers).

I had been looking hard at the Abit SU-2S, with the Marvell 88SX6081
on board.  Is this to say that the Marvell chip is also in the latter
category of "slow annoying PATA-like crap"?

Does anyone know an AHCI controller that can be attached to a dual opteron
motherboard?  All of the ones mentioned seem to be built into Intel
chipsets.

Thanks!
