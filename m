From: Oliver Bausinger <bausi@bausi.org>
Subject: siimage annoyance (was: ata_sil problems (lockup at boottime))
Date: Sun, 5 Dec 2004 15:15:34 +0100
Message-ID: <200412051515.34666.bausi@bausi.org>
References: <41B2499E.1080905@nv-systems.net> <200412050908.33124.bausi@bausi.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from everest.mathematik.uni-tuebingen.de ([134.2.62.220]:12257 "EHLO
	everest.mathematik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S261305AbULEOP5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 5 Dec 2004 09:15:57 -0500
In-Reply-To: <200412050908.33124.bausi@bausi.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Gerald Hopf <gerald.hopf@nv-systems.net>

Replying to myself after more experimentation:

> [The other possible thing to do is to use the siimage driver in
> drivers/ide, but this one stopped working with 2.6.8 and further. The
> siimage driver works quite good with 2.6.7, so this is another proof for no
> hardware problems]
>

Ok, support for the deprected siimage driver has to be explicitly enabled  
unter drivers/ide (CONFIG_BLK_DEV_IDE_SATA). Then it recognizes the chipset 
and seems to work so far.

The only annoyance is that the driver hangs for some seconds probing the 
second port (which is unused):

SiI3112 Serial ATA: IDE controller at PCI slot 0000:00:0a.0
PCI: Found IRQ 5 for device 0000:00:0a.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: 100% native mode on irq 5
    ide2: MMIO-DMA , BIOS settings: hde:DMA, hdf:DMA
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: SAMSUNG SP1614C, ATA DISK drive
ide2 at 0xd0800080-0xd0800087,0xd080008a on irq 5
Probing IDE interface ide3...
hdg: no response (status = 0xfe)

But one can live with that.

Greetings
Bausi
