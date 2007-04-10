From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Tue, 10 Apr 2007 15:49:08 +0300 (EEST)
Message-ID: <38769.194.237.142.7.1176209348.squirrel@ncircle.nullnet.fi>
References: <200704091018.l39AI9tg020015@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:51875 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbXDJMtU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Apr 2007 08:49:20 -0400
In-Reply-To: <200704091018.l39AI9tg020015@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, phil@ipom.com


Hi,

I just ran a test with the 2.6.21-rc6-git1 + your patches below
and got the following errors (bottom of the mail). Do you have
any idea what they might be trying to tell ?

My configuration contains Promise Sata300TX4-pci card:

00:0e.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA
300 TX4) (rev 02)
        Subsystem: Promise Technology, Inc. PDC40718 (SATA 300 TX4)
        Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 16
        I/O ports at ec00 [size=128]
        I/O ports at e000 [size=256]
        Memory at fe900000 (32-bit, non-prefetchable) [size=4K]
        Memory at fe800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fe600000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2

Asus A7V880 / AMD Athlon XP 2.8MHz
Antec truepower II 550W power supply
2 * Seagate 7200.7 disks 200GB (no errors with these two)
2 * Seagate 7200.10 disks 500GB (these ones generate all the errors)
    (jumpered into 3.0Gbs mode)


> I've seen reports of issues like these with second-generation
> Promise SATA chips and SATAII (3Gbps) drives, but this is the
> first time I've seen any issues with a first-generation chip.
>
> 1. Please try 2.6.21-rc6 plus the following two patches:
>    http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-separate-sata-pata-ops-2.6.21-rc6
>    http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-error_intr-2.6.21-rc6
>
>    This probably won't eliminate the errors, but should improve
>    the level of detail in the error messages.
>
> 2. Try with a better power supply and verify that cooling is OK.
>    Also verify that the SATA data and power cables are firmly attached.
>
>    We've seen several reports of mysterious issues that eventually
>    were traced to insufficient power supplies or poorly seated
>    PCI cards (but in your case the chip is integrated on the mobo).

On my system, cooling is OK. The power supply however has been
changed twice because previous Antec supplies have died under stress :(

Regards,
Tomi Orava

-----------------------------------------------------------------------
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (port_status 0x20080000)
ata2.00: cmd c8/00:68:27:ea:7c/00:00:00:00:00/e7 tag 0 cdb 0x0 data 53248 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x6 (timeout)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (port_status 0x20080000)
ata2.00: cmd c8/00:a8:5f:95:87/00:00:00:00:00/e7 tag 0 cdb 0x0 data 86016 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x6 (timeout)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (port_status 0x20080000)
ata2.00: cmd c8/00:00:3f:6f:b3/00:00:00:00:00/e7 tag 0 cdb 0x0 data 131072 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x6 (timeout)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata2.00: limiting speed to UDMA/100:PIO4
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: (port_status 0x20080000)
ata2.00: cmd 25/00:00:2f:2b:b3/00:02:07:00:00/e0 tag 0 cdb 0x0 data 262144 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x6 (timeout)
ata2: soft resetting port
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: configured for UDMA/100
ata2: EH complete
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
-----------------------------------------------------------

-- 


