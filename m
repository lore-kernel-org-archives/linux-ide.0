From: "James Spooner" <james@endace.com>
Subject: 2.4.27-rc3-libata1 kunmap() problem
Date: Wed, 21 Jul 2004 11:00:05 +1200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <054e01c46ead$4c78f6d0$5440a8c0@zeus>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from et.endace.com ([219.88.101.154]:24528 "EHLO et.endace.com")
	by vger.kernel.org with ESMTP id S266202AbUGTXA1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Jul 2004 19:00:27 -0400
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi Jeff

I've downloaded and applied your patchset to support the Intel
PIIX/ICH5 on a Supermicro P4SCT mainboard with the 6300ESB south
bridge.

libata-core.c:2166

kunmap(sg[qc->cursg].page);  causes highmem.c to call BUG() after
page->virtual == 0.

I added this printk()...

        printk(KERN_WARNING "not unmapping %x %x %x %x\n",
sg[qc->cursg].page,
                                qc, qc->cursg,
                                ((struct page
*)sg[qc->cursg].page)->virtual);

        //kunmap(sg[qc->cursg].page);

dmesg reports:

ata1: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD800 irq 18
ata2: SATA max UDMA/133 cmd 0xD000 ctl 0xD402 bmdma 0xD808 irq 18
not unmapping ce468574 ce468530 1 0
ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003
88:407f
ata1: dev 0 ATA, max UDMA/133, 72303840 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata2: SATA port has no device.
scsi2 : ata_piix
scsi3 : ata_piix
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 35.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
 sda: sda1


There should be a Maxtor 120GB on the second ata port.

Cheers

James Spooner

--

James Spooner, BCMS                     email: james@endace.com
VHDL Firmware Development               voice:   +64 7 834 6721
Endace Technology                         fax:   +64 7 858 5095
Hamilton, New Zealand                  mobile:   +64 2 144 7638

