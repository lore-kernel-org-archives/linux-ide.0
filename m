From: Jonathan Bastien-Filiatrault <joe@dastyle.net>
Subject: ICH7: proposition for supporting AHCI along with native IDE
Date: Thu, 16 Aug 2007 13:51:56 -0400
Message-ID: <46C48EBC.9030708@dastyle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:20680 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759102AbXHPRv5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 13:51:57 -0400
Received: from [172.16.1.150] ([74.59.112.80]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMV005LEOAKQD80@VL-MH-MR001.ip.videotron.ca> for
 linux-ide@vger.kernel.org; Thu, 16 Aug 2007 13:51:56 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

Early experimentation on my part seems to show that it is possible to 
put an ICH SATA controller booted in SATA compatibility mode in full 
native AHCI mode. The drawback of having the ICH7 chip in AHCI mode is 
that the PATA ports are not claimed or used by any driver, rendering the 
PATA ports unusable.

Suggestion:

Make a new driver (ata_hci7 ?) which claims the following IDs (all 
vendor 8086/intel):
27c0: Desktop ICH7 SATA, IDE mode
27c1: Desktop ICH7 SATA, AHCI mode
27c4: Mobile ICH7 SATA, IDE mode
27c5: Mobile ICH7 SATA, AHCI mode

Driver initialization would be as follows:

1. Claim the device for itself
2. If the SATA chip is in IDE mode, initialize AHCI mode.
3. Use functions in ahci.ko to enable AHCI functionality (will need some 
EXPORT_SYMBOL_GPL).
4. Use the functions in ata_piix.ko to enable PATA functionality (more 
EXPORT_SYMBOL_GPL).

On driver unload, the driver would put back the controller in IDE mode 
if it was before module load.

Such a driver would provide enhanced performance for users who cannot 
enable AHCI for their machine in the bios. It would also mean that ICH7 
users would be able to use AHCI along with PATA.

Example (and current testing) system:
- Dell Latitude D620

SATA P0: main disk drive
SATA P2: external SATA ?
PATA Secondary master "hdc": DVD-Rom ejectable drive bay.

Please let me know what you think,
Thank you,
Jonathan
