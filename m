From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Adaptec Hercules 2 (Marvell AIC-8130) SATA chipset support
Date: Wed, 02 Feb 2005 00:32:56 -0500
Message-ID: <42006608.5000200@pobox.com>
References: <BAY21-F2602989D03802536F52405DF7E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60813 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261438AbVBBFdL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Feb 2005 00:33:11 -0500
In-Reply-To: <BAY21-F2602989D03802536F52405DF7E0@phx.gbl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christensen Tom <paveraware@hotmail.com>
Cc: linux-ide@vger.kernel.org

Christensen Tom wrote:
> I have a server with the above SATA chipset, it has 4 SATA ports, and of 
> course I can't get linux to recognize it.  I believe from a conversation 
> with Supermicro (the makers of the motherboard) that it is one of the 
> Marvell SATA chipsets most likely 88SX6041.  However, Adaptec wrote 
> their own firmware and rereleased it as the AIC-8130...
> 
> They released a binary driver but it only works in 2.4 kernels, and then 
> only in a couple vendor specific kernels that have exploits and 
> shouldn't be used.  Any chance that the Marvell driver that is being 
> worked on will work with this chipset/firmware?
> 
> If it's possible that the 88SX6041 driver might work, or if it might be 
> like the AAR1200 series adaptec cards that are based on the Silicon 
> Image chipset, but needed a patch to get working I would be more than 
> happy to test and even try to do some dev work on it.

It's easy to modify the sata_sil.c to include the PCI IDs (lspci -n).

The Marvell chipset driver should be coming along sometime, but it 
hasn't moved in a while.

	Jeff



