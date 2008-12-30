From: Steven DuChene <tevend@yahoo.com>
Subject: SATA hard drive problem when MSI enabled (ahci.c)
Date: Tue, 30 Dec 2008 08:12:46 -0800 (PST)
Message-ID: <612743.49975.qm@web30708.mail.mud.yahoo.com>
Reply-To: tevend@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web30708.mail.mud.yahoo.com ([68.142.200.141]:45509 "HELO
	web30723.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1751515AbYL3QMr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Dec 2008 11:12:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff and others maintaining the ahci.c driver file:
I have a current XFX GeForce 8200 motherboard with an
on-board SATA controller based around the NVidia GeForce
8200 or MCP78S chipset. If I attempt to boot either a
opensuse-11.1 2.6.27.7-9-default kernel or a kernel.org
2.6.28 kernel without passing a "pci=nomsi" the
SATA hard drive hung off of the on-board controller chip is
not detected. I have the motherboard BIOS set to use a SATA
mode of AHCI. If I pass the pci=nomsi to either kernel then
the sata hard disks are found just fine.

I see in looking at the code in the ahci.c file in
drivers/ata that you do detection of some board IDs and for
some boards you set AHCI_HFLAG_NO_MSI. If the code in the
ahci.c file would recognize the motherboards with the MCP78S
chipset then it might be a good idea to set the
AHCI_HFLAG_NO_MSI flag for those boards as well.

If you can tell me how to find that board id that is used
to ident boards in ahci.c I can get that information to you
if that would help others who have the same problem. I think
it must be better to turn off MSI for specific chips or
on an individual PCI bridge rather than do it globally for
the whole system with pci=nomsi 
--
Steven DuChene




      
