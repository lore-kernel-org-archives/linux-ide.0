From: "Richard Liu" <richliu.tw@gmail.com>
Subject: ST31000340NS (1000G) Capacity equal 33MB issue.
Date: Fri, 15 Feb 2008 02:18:59 +0800
Message-ID: <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com>
References: <d0d565260802141013q61cb5e7fh7dcf04d7729213f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:56113 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbYBNSTB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 13:19:01 -0500
Received: by el-out-1112.google.com with SMTP id v27so459001ele.23
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 10:19:00 -0800 (PST)
In-Reply-To: <d0d565260802141013q61cb5e7fh7dcf04d7729213f7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello all:

     I bought a Seagate ES.2 ST31000340NS (1000GB) and run at Gentoo
Linux kernel 2.6.24.
But Linux kernel report the disk size only 33MB.
I tried Intel ICH5 and Sil3112, but get the same result.

I don't know this issue was caused by libsata or scsi layer .

Could you help me to solved it ?

Here is the relative information.
I think this would be helpful.

==
dmesg
==
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 ata4.00: HPA detected: current 65134, native 1953525167
ata4.00: ATA-6: ST31000340NS, SN04, max UDMA/133
ata4.00: 65134 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/100
scsi 3:0:0:0: Direct-Access     ATA      ST31000340NS     SN04 PQ: 0 ANSI: 5
 sd 3:0:0:0: [sdc] 65134 512-byte hardware sectors (33 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sd 3:0:0:0: [sdc] 65134 512-byte hardware sectors (33 MB)
sd 3:0:0:0: [sdc] Write Protect is off
sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
  sdc: unknown partition table
sd 3:0:0:0: [sdc] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg2 type 0
==
Seatool
==
# ./st -i /dev/sg2
        /dev/sg2
        Vendor = ATA
        Product = ST31000340NS
         Version = SN04
        Serial Number =
        Copyright =
        SCSI Firmware =
        Servo RAM Release =
        Servo ROM Release =
        Servo RAM Date =
        Servo ROM Date =

        Blocksize = 512, Highblock = 65133, Capacity = 33 MB
        -this is a Seagate drive
        -this drive does not support DST
        -Mode Page Settings [current value (default)]:
                -WCE bit = 1 (0)
                 -RCD bit = 0 (0)
                -AWRE bit = 1 (0)
                -ARRE bit = 0 (0)
                -DExcpt bit = 0 (0)
                -Number of cache segments = 0 (0)

==
hdparm
 ==
hdparm -i /dev/sdc

/dev/sdc:

 Model=ST31000340NS                            , FwRev=SN04    ,
SerialNo=            9QJ09BJ4
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
  RawCHS=64/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=?16?
 CurCHS=64/16/63, CurSects=64512, LBA=yes, LBAsects=65134
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2:  ATA/ATAPI-4,5,6

 * signifies the current active mode
