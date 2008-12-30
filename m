From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA hard drive problem when MSI enabled (ahci.c)
Date: Tue, 30 Dec 2008 12:04:04 -0600
Message-ID: <495A6294.4020501@shaw.ca>
References: <612743.49975.qm@web30708.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51245 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbYL3SEP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2008 13:04:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHiwu-0004dG-GM
	for linux-ide@vger.kernel.org; Tue, 30 Dec 2008 18:04:12 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2008 18:04:12 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 30 Dec 2008 18:04:12 +0000
In-Reply-To: <612743.49975.qm@web30708.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

Steven DuChene wrote:
> Jeff and others maintaining the ahci.c driver file:
> I have a current XFX GeForce 8200 motherboard with an
> on-board SATA controller based around the NVidia GeForce
> 8200 or MCP78S chipset. If I attempt to boot either a
> opensuse-11.1 2.6.27.7-9-default kernel or a kernel.org
> 2.6.28 kernel without passing a "pci=nomsi" the
> SATA hard drive hung off of the on-board controller chip is
> not detected. I have the motherboard BIOS set to use a SATA
> mode of AHCI. If I pass the pci=nomsi to either kernel then
> the sata hard disks are found just fine.
> 
> I see in looking at the code in the ahci.c file in
> drivers/ata that you do detection of some board IDs and for
> some boards you set AHCI_HFLAG_NO_MSI. If the code in the
> ahci.c file would recognize the motherboards with the MCP78S
> chipset then it might be a good idea to set the
> AHCI_HFLAG_NO_MSI flag for those boards as well.
> 
> If you can tell me how to find that board id that is used
> to ident boards in ahci.c I can get that information to you
> if that would help others who have the same problem. I think
> it must be better to turn off MSI for specific chips or
> on an individual PCI bridge rather than do it globally for
> the whole system with pci=nomsi 
> --
> Steven DuChene

Hmm.. Can you post lspci -vvn output?

CCing some NVIDIA people. Is there anything known about MSI being broken 
on MCP78S AHCI controller? Currently the only known NVIDIA AHCI problems 
with MSI are with MCP65 revisions A1 and A2. I'm not actually sure what 
chipset listed in the driver would match with MCP78S, that particular 
one isn't listed..

