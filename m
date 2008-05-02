From: Gene Heskett <gene.heskett@gmail.com>
Subject: Re: dvd writing problem
Date: Fri, 2 May 2008 08:21:44 -0400
Message-ID: <200805020821.44932.gene.heskett@gmail.com>
References: <200805011135.38556.gene.heskett@gmail.com> <20080501224233.c3e11762.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:50822 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636AbYEBMVs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 08:21:48 -0400
Received: by an-out-0708.google.com with SMTP id d40so303467and.103
        for <linux-ide@vger.kernel.org>; Fri, 02 May 2008 05:21:47 -0700 (PDT)
In-Reply-To: <20080501224233.c3e11762.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

On Friday 02 May 2008, Andrew Morton wrote:
>On Thu, 1 May 2008 11:35:38 -0400 Gene Heskett <gene.heskett@gmail.com> wrote:
>> Greetings all;
>>
>> I'm going to describe the problem, and let you tell me where to report it.
>
>linux-ide
>
>> System is Biostar MB, XP-2800 cpu, gig of ram.
>>
>> 1. burn dvd image using k3b, with write verify turned on.
>>
>> 2. when disk is ejected at end of a successful burn, then pulled back in,
>> a read error is reported long before the drive has recognized the disk,
>> the disk is ejected again and k3b bails out of the verify phase.  This
>> does not occur for a cd-r.
>>
>> 3. manually close drive with the disc still in the tray.
>>
>> 4. About 40 secs later, at about the time the drive would have accepted
>> the disc as a valid disc, the system is frozen solidly, no drive leds on
>> and the clock in the corner of the screen is stopped.  I have let it sit
>> that way for as long as 2 minutes before tapping the hardware reset
>> button.
>>
>> 5. Eject the disc while its posting and reboot, to either 2.6.24.5 or
>> 2.6.25, both do exactly the same actions.
>>
>> 6. Once system is up again, re-insert disc, wait for drive to accept it,
>> then do a verify by hand, disc is good, it can be mounted and read just
>> fine.
>>
>> 7. disc is a +RW disc, so it should be re-writable.  Pick a different .iso
>> and start k3b again using it.  K3b goes through the motions, but 2 or 3
>> seconds after the real write starts with perhaps 30 megabytes *supposedly*
>> written, k3b gets a write error and the burn bails out, ejecting the disc
>> as it does.
>>
>> 8. insert disc and loop this sequence back to #3 above until tired of
>> rebooting cuz the box is frozen.  Once rebooted, and the disc inspected,
>> it is obvious the second write never touched the disc as the first write
>> is still there and passes the sh1sum or md5sum test correctly.
>>
>> Sebastian Truex and I have been discussing this for a while now, and I
>> have even replaced the writer drive, a LITEON that I started with, with an
>> HP, even faster drive, without changing a thing above.  It is 100%
>> repeatable.
>>
>> Where do I file the bug report?  There are no interesting entries in the
>> messages log, no oops, nothing.
>
>It's unclear whether that drive is attached via stat, pata, ide, scsi or
>whatever.  The dmesg output would clear that up.

Thanks Andrew. subscription in progress now.

Selected excerpts from dmesg:
[    1.831308] SCSI subsystem initialized
[    1.850587] Driver 'sd' needs updating - please use bus_type methods
[    1.862371] No dock devices found.
[    1.896574] libata version 3.00 loaded.
[    1.899221] pata_amd 0000:00:09.0: version 0.3.10
[    1.899373] PCI: Setting latency timer of device 0000:00:09.0 to 64
[    1.904441] scsi0 : pata_amd
[    1.909440] scsi1 : pata_amd
[    1.910248] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
[    1.910251] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
[    2.112099] ata1.00: ATA-7: MAXTOR STM3500630A, 3.AAE, max UDMA/100
[    2.112103] ata1.00: 976773168 sectors, multi 16: LBA48
[    2.112117] ata1: nv_mode_filter: 0x3f39f&0x3f01f->0x3f01f, BIOS=0x3f000 (0xc600c5c6) ACPI=0x3f01f (20:600:0x13)
[    2.187027] ata1.00: configured for UDMA/100
[    2.510566] ata2.00: ATAPI: HP DVD Writer 1040d, EH24, max UDMA/66
[    2.555081] ata2.01: ATA-7: MAXTOR STM3320620A, 3.AAE, max UDMA/100
[    2.555085] ata2.01: 625142448 sectors, multi 16: LBA48
[    2.555095] ata2: nv_mode_filter: 0x1f39f&0x1f01f->0x1f01f, BIOS=0x1f000 (0xc600c5c6) ACPI=0x1f01f (30:20:0x1f)
[    2.555100] ata2: nv_mode_filter: 0x3f39f&0x3f01f->0x3f01f, BIOS=0x3f000 (0xc600c5c6) ACPI=0x3f01f (30:20:0x1f)
[    2.671219] usb 2-2: new full speed USB device using ohci_hcd and address 2
[    2.728458] ata2.00: configured for UDMA/66
[    2.763180] ata2.01: configured for UDMA/100
[    2.763281] scsi 0:0:0:0: Direct-Access     ATA      MAXTOR STM350063 3.AA PQ: 0 ANSI: 5
[    2.763364] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[    2.763380] sd 0:0:0:0: [sda] Write Protect is off
[    2.763383] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.763403] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.763457] sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
[    2.763470] sd 0:0:0:0: [sda] Write Protect is off
[    2.763473] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.763492] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.763496]  sda: sda1 sda2 sda3
[    2.784593] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.047607] scsi 1:0:0:0: CD-ROM            HP       DVD Writer 1040d EH24 PQ: 0 ANSI: 5
[    3.047716] scsi 1:0:1:0: Direct-Access     ATA      MAXTOR STM332062 3.AA PQ: 0 ANSI: 5
[    3.047777] sd 1:0:1:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
[    3.047790] sd 1:0:1:0: [sdb] Write Protect is off
[    3.047793] sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[    3.047812] sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.047851] sd 1:0:1:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
[    3.047863] sd 1:0:1:0: [sdb] Write Protect is off
[    3.047866] sd 1:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[    3.047886] sd 1:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.047889]  sdb: sdb1 sdb2 sdb3
[    3.069279] sd 1:0:1:0: [sdb] Attached SCSI disk
[...]
[    8.098650] scsi2 : sata_sil
[    8.102674] scsi3 : sata_sil
[    8.102703] ata3: SATA max UDMA/100 mmio m512@0xe5004000 tf 0xe5004080 irq 16
[    8.102707] ata4: SATA max UDMA/100 mmio m512@0xe5004000 tf 0xe50040c0 irq 16
[    8.405355] ata3: SATA link down (SStatus 0 SControl 310)
[    8.859300] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    8.862863] ata4.00: ATA-7: Hitachi HDT725040VLA360, V5COA7EA, max UDMA/133
[    8.862866] ata4.00: 781422768 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    8.868851] ata4.00: configured for UDMA/100
[    8.868960] scsi 3:0:0:0: Direct-Access     ATA      Hitachi HDT72504 V5CO PQ: 0 ANSI: 5
[    8.869035] sd 3:0:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
[    8.869051] sd 3:0:0:0: [sdc] Write Protect is off
[    8.869054] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    8.869074] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.869130] sd 3:0:0:0: [sdc] 781422768 512-byte hardware sectors (400088 MB)
[    8.869142] sd 3:0:0:0: [sdc] Write Protect is off
[    8.869145] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    8.869164] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.869168]  sdc: sdc1
[    8.878716] sd 3:0:0:0: [sdc] Attached SCSI disk
[...]
[   16.115714] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   16.115737] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[   16.115758] sd 1:0:1:0: Attached scsi generic sg2 type 0
[   16.115780] sd 3:0:0:0: Attached scsi generic sg3 type 0
[   16.127912] Driver 'sr' needs updating - please use bus_type methods
[   16.133300] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   16.133307] Uniform CD-ROM driver Revision: 3.20
[   16.133377] sr 1:0:0:0: Attached scsi CD-ROM sr0

>Thanks.



-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
No skis take rocks like rental skis!
