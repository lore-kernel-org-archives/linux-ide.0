From: Jonathan Bastien-Filiatrault <joe@dastyle.net>
Subject: Enabling AHCI on ICH7 without BIOS support
Date: Tue, 14 Aug 2007 09:09:45 -0400
Message-ID: <46C1A999.5070109@dastyle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:50650 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbXHNNJq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 09:09:46 -0400
Received: from [172.16.1.150] ([74.59.112.80]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMR00ID1LW94M80@VL-MO-MR001.ip.videotron.ca> for
 linux-ide@vger.kernel.org; Tue, 14 Aug 2007 09:09:45 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,


I am the owner of a Dell Latitude D620 notebook with an ICH7 SATA 
controller, unfortunately, the BIOS does not offer the option of using 
"native mode" instead of "compatibility mode" when it comes to SATA. For 
now, the ata_piix runs happily in compatibility mode. Looking at the 
ICH7 docs, I found that poking register 0x90 in PCI configuration space 
with value 0x40 should enable AHCI. However, there are some issues with 
poking that register with setpci in an early initramfs:


- The kernel does not seem to update the device id from PCI config 
space, which changes with the controller mode (it would seem the PCI 
subsystem keeps a copy)

- Poking PCI registers from userspace is far from ideal


It would be great if the AHCI driver (or otherwise) had a 
"force_ich7_ahci" to properly setup and initialize this device in full 
"native" AHCI mode. This option would be greatly welcome from users like 
me who have a stupid bios (eh, who doesn't).


Thank you,

Jonathan

