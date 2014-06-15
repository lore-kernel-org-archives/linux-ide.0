From: ygosset <ygosset@free.fr>
Subject: Device ICH7 for ahci driver
Date: Sun, 15 Jun 2014 17:05:13 +0200
Message-ID: <539DB629.6020207@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:44853 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbaFOPFQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Jun 2014 11:05:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


Hello

I have the mainboard G41M-E43 from MSI.

The Sata controller comes from the ICH7 chip, with the speed of UDMA 133.

Here is identifiers by the Pci bus:

"lspci -nn | grep SATA
00:1f.2 IDE interface [0101]: Intel Corporation NM10/ICH7 Family SATA
Controller [IDE mode] [8086:27c0] (rev 01)"

So, I have connected Sata drives on it and this is no at the full speed.
It was fine before, because I don't need speed into this computer.

Today, I'm looking for performance, and I can't change the speed to
SERIAL ATA II:
- I have no option into the latest bios of the motherboard to specify
AHCI mode
- I have tried "setpci -d 8086:27c0 90.b=40" or "setpci -s 00:1f.2
90.b=40" in the grub configuration with no effect .

I'm looking for help.

I've find your email because I have read the file
linux-source-3.2.0/drivers/ata/ahci.c .

Is it a new device for this driver ?

Have you a workaround like 'setpci ...' to change the speed of the Sata
controller ?

Thanks a lot!

Regards, Yvan.
--
ygosset@free.fr
GnuPG sur hkp://pool.sks-keyservers.net
