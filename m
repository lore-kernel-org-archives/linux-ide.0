From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: low performance trying pata_sis
Date: Wed, 06 Dec 2006 11:58:23 +0100
Message-ID: <4576A24F.90200@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37250 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760460AbWLFK60 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Dec 2006 05:58:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux.ide" <linux-ide@vger.kernel.org>

There is a wrong order to initialize the drivers. The IDE-platform
driver was initialized before pata_sis.
So the generic platform driver is driving the IDE controller instead of
pata_sis.
kernel 2.6.19

.config
# CONFIG_BLK_DEV_SIS5513 is not set
CONFIG_ATA=y
CONFIG_PATA_SIS=y

dmesg
...
libata version 2.00 loaded.
...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
hda: SAMSUNG SP1614N, ATA DISK drive
Probing IDE interface ide1...
...
pata_sis 0000:00:02.5: version 0.4.4
ata: 0x1F0 IDE port busy
ata: conflict with ide0
ata: 0x170 IDE port busy
ata: conflict with ide1
pata_sis: probe of 0000:00:02.5 failed with error -16

regards
Uwe Koziolek
