From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
Date: Thu, 25 Oct 2018 21:38:03 +0200
Message-ID: <f881dd9d-b41f-9993-44fe-71db55fb679d@physik.fu-berlin.de>
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
 <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi!

Sorry for the delay!

On 10/18/18 2:29 PM, Bartlomiej Zolnierkiewicz wrote:
> John, please test if possible..
Driver loads and detects hard drive connected to it:

[  256.110000] zorro zorro3: Buddha IDE controller
[  256.430000] scsi host2: pata_buddha
[  256.580000] scsi host3: pata_buddha
[  256.590000] ata2: PATA max PIO4 cmd 0xeb0000 ctl 0xeb091a irq 2
[  256.600000] ata3: PATA max PIO4 cmd 0xeb0000 ctl 0xeb0b1a irq 2
[  256.790000] ata2.00: ATA-6: ST380011A, 8.01, max UDMA/100
[  256.810000] ata2.00: 156301488 sectors, multi 16: LBA48 
[  256.820000] ata2.00: configured for PIO
[  256.870000] scsi 2:0:0:0: Direct-Access     ATA      ST380011A        8.01 PQ: 0 ANSI: 5
[  257.080000] sd 2:0:0:0: [sdc] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
[  257.170000] sd 2:0:0:0: [sdc] Write Protect is off
[  257.190000] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  257.330000] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  257.960000] sd 2:0:0:0: [sdc] Attached SCSI disk

I was then able to create an MS-DOS partition table on the disk and create
an ext2 filesystem. I copied some files onto the partition which worked
without any problems.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Michael wants to make some changes to the driver though, I think. He has access
to the Amiga 4000, in any case, so he can also test them.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
