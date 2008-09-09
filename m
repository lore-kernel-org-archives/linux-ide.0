From: Richard Whitlock <richard.whitlo@btconnect.com>
Subject: UDMA failure with UDMA/100 CF card, pata_pdc2027x, MPC8347
Date: Tue, 09 Sep 2008 14:38:34 +0100
Message-ID: <48C67C5A.8050006@btconnect.com>
Reply-To: richw@netcomuk.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from c2bthomr10.btconnect.com ([213.123.20.128]:23149 "EHLO
	c2bthomr10.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbYIINia (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 09:38:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Having a bit of difficulty with the following:

2.6.27-rc1
pata_pdc2027x.ko

MPC8347
Promise pdc20275


The following console output is produced when I try to load pata_pdc2027x.
Each attempt takes several tens of seconds to fail. Loading the module 
takes 2 to 3 minutes.
Once the module has been loaded, mounting SDA1 takes about 20 seconds, 
but can be accessed successfully (albeit slowly)

Having throttled back to PIO4, it seems to work - but does anyone have 
any ideas why the exceptions in all UDMA modes?


pata_pdc2027x 0000:00:0b.0: version 1.0
pata_pdc2027x 0000:00:0b.0: PLL input clock 16485 kHz
scsi0 : pata_pdc2027x
scsi1 : pata_pdc2027x
ata1: PATA max UDMA/133 mmio m16384@0xc0100000 cmd 0xc01017c0 irq 16
ata2: PATA max UDMA/133 mmio m16384@0xc0100000 cmd 0xc01015c0 irq 16
ata1.00: CFA: LEXAR ATA FLASH CARD, 20070228, max UDMA/100
ata1.00: 7831152 sectors, multi 0: LBA
ata1.00: configured for UDMA/100
scsi 0:0:0:0: Direct-Access     ATA      LEXAR ATA FLASH  2007 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 7831152 512-byte hardware sectors (4010 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 7831152 512-byte hardware sectors (4010 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't 
support DPO or FUA
 sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for UDMA/100
ata1: EH complete
ata1.00: limiting speed to UDMA/66:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for UDMA/66
ata1: EH complete
ata1.00: limiting speed to UDMA/33:PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for UDMA/33
ata1: EH complete
ata1.00: limiting speed to PIO4
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for PIO4
ata1: EH complete
 sda1
sd 0:0:0:0: [sda] Attached SCSI removable disk

