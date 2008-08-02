From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Re: Seagate HDD Frequent Head Unload - hdparm/dmidecode/smartctl output
Date: Sat, 2 Aug 2008 16:01:17 +0300
Message-ID: <3db1ec7f0808020601h20b2282ch51e6d93a484ac61c@mail.gmail.com>
References: <488B27CE.5060106@i-nz.net> <488D751C.5080302@suse.de>
	 <488D8B97.1040805@i-nz.net> <488D8ED1.2040400@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.245]:15716 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbYHBNBS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Aug 2008 09:01:18 -0400
Received: by an-out-0708.google.com with SMTP id d40so223197and.103
        for <linux-ide@vger.kernel.org>; Sat, 02 Aug 2008 06:01:18 -0700 (PDT)
In-Reply-To: <488D8ED1.2040400@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <teheo@suse.de>
Cc: linux-ide@vger.kernel.org

Hi again,

It appears that the storage-fixup rule [1] doesn't work. Verbose
output below[2]. Also I saw that you use hdparm -i and sg_inq so
output from those for the HDD too. I badly failed to understand this
brainf*** called bash :-), so may be you can advice what's going
wrong? Thanks in advance.


[1]

# Reported drive model: ST9120822AS
rule dell-Vostro-1400
dmi system-manufacturer        Dell Inc.
dmi system-product-name        Vostro 1400
ata model            ST9*AS
act hdparm -B 254 $DEV

[2]

[/home/ivanz]$ storage-fixup -v -d
storage-fixup: I 2 storage devices
storage-fixup: C ata:model:0 ST9120822AS
storage-fixup: C ata:rev:0 3.CDD
storage-fixup: C ata:serial:0 5LZ6PF8E
storage-fixup: C scsi:vendor:0 ATA
storage-fixup: C scsi:model:0 ST9120822AS
storage-fixup: C scsi:rev:0 3.CD
storage-fixup: C scsi:serial:0 5LZ6PF8E
storage-fixup: C ata:model:1 TSSTcorp DVD+/-RW TS-L632H
storage-fixup: C ata:rev:1 D200
storage-fixup: C ata:serial:1
storage-fixup: C scsi:vendor:1 TSSTcorp
storage-fixup: C scsi:model:1 DVD+-RW TS-L632H
storage-fixup: C scsi:rev:1 D200
storage-fixup: C scsi:serial:1
storage-fixup: C dmi:system-manufacturer:0 Dell Inc.
storage-fixup: N 22 tp-t60 dmi system-manufacturer=LENOVO
storage-fixup: N 30 hp-dv6500 dmi system-manufacturer=Hewlett-Packard
storage-fixup: Y 38 dell-e1505 dmi system-manufacturer=Dell Inc.
storage-fixup: C dmi:system-product-name:0 Vostro 1400
storage-fixup: N 39 dell-e1505 dmi system-product-name=MM061
storage-fixup: Y 45 dell-Vostro-1400 dmi system-manufacturer=Dell Inc.
storage-fixup: N 46 dell-Vostro-1400 dmi system-product-name=Vostro 1400

[3]

[/home/ivanz]$ sg_inq /dev/sda
standard INQUIRY:
  PQual=0  Device_type=0  RMB=0  version=0x05  [SPC-3]
  [AERC=0]  [TrmTsk=0]  NormACA=0  HiSUP=0  Resp_data_format=2
  SCCS=0  ACC=0  TPGS=0  3PC=0  Protect=0  BQue=0
  EncServ=0  MultiP=0  [MChngr=0]  [ACKREQQ=0]  Addr16=0
  [RelAdr=0]  WBus16=0  Sync=0  Linked=0  [TranDis=0]  CmdQue=0
  [SPI: Clocking=0x0  QAS=0  IUS=0]
    length=96 (0x60)   Peripheral device type: disk
 Vendor identification: ATA
 Product identification: ST9120822AS
 Product revision level: 3.CD
 Unit serial number:             5LZ6PF8E


[4]

[/home/ivanz]$ hdparm -i /dev/sda

/dev/sda:

 Model=ST9120822AS                             , FwRev=3.CDD   ,
SerialNo=            5LZ6PF8E
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=?8?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=234441648
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=yes: unknown setting WriteCache=enabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1,2,3,4,5,6,7

 * signifies the current active mode
