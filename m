From: thomas schorpp <thomas.schorpp@googlemail.com>
Subject: HSM violations from ATA PACKET cmd ABRT errors in initial comms with
 LG GH22 SATA DVDRW
Date: Sun, 27 Dec 2009 21:37:33 +0100
Message-ID: <4B37C58D.2090200@gmail.com>
Reply-To: thomas.schorpp@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:36682 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbZL0Uhl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Dec 2009 15:37:41 -0500
Received: by fg-out-1718.google.com with SMTP id 19so4230574fgg.1
        for <linux-ide@vger.kernel.org>; Sun, 27 Dec 2009 12:37:40 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

LG GH22NS40 NL01 (possibly Renesas chipset)
VIA8237 SATA (produces basically same errors), Promise SATA II 150 20579 HBAs.

Linux 2.6.32.2
hal polling
devkit polling
wodim
growisofs

port_status 0x20280000 (Data Transfer Overrun Error & Target Device Fault)?

Looks like a hardware combination incompatibility.
Most applicable ATA_HORKAGES in sourcecode already tried.

Not found the sense code yet since FEATURE specific according to T13/1410D revision 3b.

Comments?

y
tom

dmesg |grep -A 10 ata

sata_promise 0000:00:0d.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
scsi5 : sata_promise
scsi6 : sata_promise
scsi7 : sata_promise
ata6: SATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe200 irq 17
ata7: SATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe280 irq 17
ata8: PATA max UDMA/133 mmio m4096@0xfbefe000 ata 0xfbefe300 irq 17
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATAPI: HL-DT-ST DVDRAM GH22NS40, NL01, max UDMA/100
ata6.00: configured for UDMA/100
scsi 5:0:0:0: CD-ROM            HL-DT-ST DVDRAM GH22NS40  NL01 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 125x/125x writer dvd-ram cd/rw xa/form2 cdda tray
sr 5:0:0:0: Attached scsi CD-ROM sr0
sr 5:0:0:0: Attached scsi generic sg2 type 5
ata7: SATA link down (SStatus 0 SControl 300)
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata6.00: port_status 0x20280000
sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 40 00
ata6.00: cmd a0/01:00:00:00:fc/00:00:00:00:00/a0 tag 0 dma 131072 in
         res 51/54:03:00:00:fc/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
ata6.00: status: { DRDY ERR }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
ata6: EH complete
...
<period, ~10 times in series>
...
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata6.00: port_status 0x20280000
sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
         res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
ata6.00: status: { DRDY ERR }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
ata6: EH complete
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata6.00: port_status 0x20280000
sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
         res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
ata6.00: status: { DRDY ERR }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
ata6: EH complete
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
ata6.00: port_status 0x20280000
sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
ata6.00: cmd a0/01:00:00:00:10/00:00:00:00:00/a0 tag 0 dma 4096 in
         res 51/54:03:00:00:10/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
ata6.00: status: { DRDY ERR }
ata6: hard resetting link
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: configured for UDMA/100
sr 5:0:0:0: [sr0] Result: hostbyte=0x00 driverbyte=0x08
sr 5:0:0:0: [sr0] Sense Key : 0x5 [current] 
Info fld=0x0
sr 5:0:0:0: [sr0] ASC=0x21 ASCQ=0x0
sr 5:0:0:0: [sr0] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 02 00
end_request: I/O error, dev sr0, sector 0
Buffer I/O error on device sr0, logical block 0
Buffer I/O error on device sr0, logical block 1
ata6: EH complete

