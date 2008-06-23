From: Tejun Heo <tj@kernel.org>
Subject: Re: libata pata_jmicron: kernel 2.6.26-rc6 wait for a long time to
 probe HDD
Date: Mon, 23 Jun 2008 09:42:56 +0900
Message-ID: <485EF190.3020000@kernel.org>
References: <ff05f3d00806192015t30617527uc3b87b81452b9ee9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42576 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbYFWAnE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jun 2008 20:43:04 -0400
In-Reply-To: <ff05f3d00806192015t30617527uc3b87b81452b9ee9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Edward Shao <laface.tw@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

Edward Shao wrote:
> PATA chip : JMB368 IDE controller (1-port PATA Host Controller)
> HDD          : TOSHIBA MK1214GAH
> 
> Use pata_jmicron.ko in linux 2.6.25.4
> 
> [   21.942308] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level,
> low) -> IRQ 16
> [   21.942571] PCI: Setting latency timer of device 0000:05:00.0 to 64
> [   21.942696] scsi2 : pata_jmicron
> [   21.942976] scsi3 : pata_jmicron
> [   21.943192] ata1: PATA max UDMA/100 cmd 0xdc00 ctl 0xd880 bmdma 0xd400 irq 16
> [   21.943301] ata2: PATA max UDMA/100 cmd 0xd800 ctl 0xd480 bmdma 0xd408 irq 16
> [   26.959936] ata1: port is slow to respond, please be patient (Status 0xd0)
> [   31.804198] ata1: SRST failed (errno=-16)
> 
> Fail to detect the HDD.

2.6.25.4 doesn't retry after that?

> Change kernel version to 2.6.26-rc6
> 
> [   18.698228] PCI: Setting latency timer of device 0000:05:00.0 to 64
> [   18.699232] scsi2 : pata_jmicron
> [   18.700232] scsi3 : pata_jmicron
> [   18.701228] ata1: PATA max UDMA/100 cmd 0xdc00 ctl 0xd880 bmdma 0xd400 irq 16
> [   18.701228] ata2: PATA max UDMA/100 cmd 0xd800 ctl 0xd480 bmdma 0xd408 irq 16
> [   23.901273] ata1: link is slow to respond, please be patient (ready=0)
> [   28.745756] ata1: SRST failed (errno=-16)
> [   33.945755] ata1: link is slow to respond, please be patient (ready=0)
> [   38.790754] ata1: SRST failed (errno=-16)
> [   43.990754] ata1: link is slow to respond, please be patient (ready=0)
> [   69.801394] ata1.00: ATA-7: TOSHIBA MK1214GAH, BW004A, max UDMA/100
> [   69.801650] ata1.00: 234441648 sectors, multi 16: LBA48
> [   69.801955] ata1.00: limited to UDMA/33 due to 40-wire cable
> [   69.807903] ata1.00: configured for UDMA/33
> [   69.959727] scsi 2:0:0:0: Direct-Access     ATA      TOSHIBA
> MK1214GA BW00 PQ: 0 ANSI: 5
> [   69.962165] sd 2:0:0:0: [sdb] 234441648 512-byte hardware sectors (120034 MB)
> [   69.962524] sd 2:0:0:0: [sdb] Write Protect is off
> [   69.962585] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [   69.963370] sd 2:0:0:0: [sdb] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [   69.964016] sd 2:0:0:0: [sdb] 234441648 512-byte hardware sectors (120034 MB)
> [   69.964160] sd 2:0:0:0: [sdb] Write Protect is off
> [   69.964160] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [   69.965158] sd 2:0:0:0: [sdb] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [   69.965158]  sdb: sdb1 sdb3
> [   70.309158] sd 2:0:0:0: [sdb] Attached SCSI disk
> [   70.310158] sd 2:0:0:0: Attached scsi generic sg1 type 0
> 
> Can detect HDD but takes a long time.
> Seems after SRST, the disk needs over 30 seconds to clear its BSY status.

This is the first time I see this type of failure.  Two 10 secs aren't
enough?  Strange.

> Try IDE driver jmicron.ko in 2.6.25.4
> 
> [   44.870518] Uniform Multi-Platform E-IDE driver
> [   44.870732] ide: Assuming 33MHz system bus speed for PIO modes;
> override with idebus=xx
> [   60.096513] JMB: IDE controller (0x197b:0x2368 rev 0x00) at  PCI
> slot 0000:05:00.0
> [   60.096873] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level,
> low) -> IRQ 16
> [   60.097202] JMB: 100% native mode on irq 16
> [   60.097429]     ide0: BM-DMA at 0xd400-0xd407, BIOS settings:
> hda:DMA, hdb:DMA
> [   60.097928]     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings:
> hdc:PIO, hdd:PIO
> [   60.098342] Probing IDE interface ide0...
> [   60.362870] hda: TOSHIBA MK1214GAH, ATA DISK drive
> [   60.668892] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> [   60.669015] hda: host side 80-wire cable detection failed, limiting
> max speed to UDMA33
> [   60.669305] hda: UDMA/33 mode selected
> [   60.669618] Probing IDE interface ide1...
> [   61.188796] ide0 at 0xdc00-0xdc07,0xd882 on irq 16
> [   61.189461] hda: max request size: 512KiB
> [   61.736475] hda: 234441648 sectors (120034 MB), CHS=16383/255/63
> [   61.513823] hda: cache flushes supported
> [   61.514189]  hda: hda1 hda3
> 
> It works fine due to IDE driver doesn't do SRST when probing HDD. (I guess. :p)

Probably.

> Not sure host or device issue.
> Is it possible to fix the problem?

Any chance you can try the drive on a different controller?  Also, is it
a laptop?

-- 
tejun
