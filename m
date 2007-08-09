From: Sebastian Witt <hasw@hasw.net>
Subject: sata_promise: Warning/Errors with SATA300 TX4 and SAMSUNG HD501LJ
Date: Thu, 09 Aug 2007 23:19:09 +0200
Message-ID: <46BB84CD.8080006@hasw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755490AbXHIVTW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Aug 2007 17:19:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello,

I'm using a Promise SATA300 TX4 with SAMSUNG HD501LJ harddisks on kernel 2.6.21. 
On high disk load sometimes warning/error messages are printed out:

...
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata4.00: cmd c8/00:08:8f:7f:85/00:00:00:00:00/ef tag 0 cdb 0x0 data 4096 in
          res 50/00:00:96:7f:85/00:00:11:00:00/ef Emask 0x1 (device error)
ata4.00: configured for UDMA/133
ata4: EH complete
...

They are not happening very often (three in the last few days) and also
no other problems occured (filesystem/data ok).

dmesg:
...
scsi0 : sata_promise
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_promise
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133
scsi2 : sata_promise
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
scsi3 : sata_promise
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 1:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO 
or FUA
sd 1:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO 
or FUA
  sda: sda1
sd 1:0:0:0: [sda] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg0 type 0
scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO 
or FUA
sd 2:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO 
or FUA
  sdb: sdb1
sd 2:0:0:0: [sdb] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg1 type 0
scsi 3:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO 
or FUA
sd 3:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO 
or FUA
  sdc: sdc1
sd 3:0:0:0: [sdc] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg2 type 0
....
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata4.00: cmd 25/00:28:d7:51:a5/00:00:11:00:00/e0 tag 0 cdb 0x0 data 20480 in
          res 50/00:00:fe:51:a5/00:00:11:00:00/e0 Emask 0x1 (device error)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO 
or FUA
ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata4.00: cmd c8/00:08:8f:7f:85/00:00:00:00:00/ef tag 0 cdb 0x0 data 4096 in
          res 50/00:00:96:7f:85/00:00:11:00:00/ef Emask 0x1 (device error)
ata4.00: configured for UDMA/133
ata4: EH complete
sd 3:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO 
or FUA
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata3.00: cmd 25/00:80:2f:fd:c2/00:00:1a:00:00/e0 tag 0 cdb 0x0 data 65536 in
          res 50/00:00:ae:fd:c2/00:00:1a:00:00/e0 Emask 0x1 (device error)
ata3.00: configured for UDMA/133
ata3: EH complete
sd 2:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO 
or FUA


Some ideas? Not optimal/not good/bad/very bad?

Regards,
Sebastian
