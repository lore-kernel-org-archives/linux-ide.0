From: Andy Lutomirski <luto@amacapital.net>
Subject: Unhappy ahci controller on Dell XPS 13 9350
Date: Tue, 12 Jan 2016 22:51:15 -0800
Message-ID: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi-

My XPS 13 9350 laptop has an nvme drive.  It has on-chip ahci
capability, but the M.2 port isn't using it due to the aforementioned
nvme drive using the same signal pins.

It is very unhappy:

[    0.230455] libata version 3.00 loaded.
[    1.039360] ahci 0000:00:17.0: version 3.0
[    1.039386] ahci 0000:00:17.0: forcing PORTS_IMPL to 0xff
[    1.539388] ahci 0000:00:17.0: failed to stop engine (-5)
[    2.039392] ahci 0000:00:17.0: failed to stop engine (-5)
[    2.539402] ahci 0000:00:17.0: failed to stop engine (-5)
[    2.539437] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6
Gbps 0xff impl SATA mode
[    2.539440] ahci 0000:00:17.0: flags: 64bit ncq pm led clo only pio
slum part deso sadm sds apst
[    2.540855] scsi host0: ahci
[    2.541455] scsi host1: ahci
[    2.541972] scsi host2: ahci
[    2.542504] scsi host3: ahci
[    2.543027] scsi host4: ahci
[    2.543550] scsi host5: ahci
[    2.544035] scsi host6: ahci
[    2.544565] scsi host7: ahci
[    2.544641] ata1: SATA max UDMA/133 abar m2048@0xdc333000 port
0xdc333100 irq 122
[    2.544645] ata2: SATA max UDMA/133 abar m2048@0xdc333000 port
0xdc333180 irq 122
[    2.544648] ata3: SATA max UDMA/133 abar m2048@0xdc333000 port
0xdc333200 irq 122
[    2.544652] ata4: SATA max UDMA/133 abar m2048@0xdc333000 port
0xdc333280 irq 122
[    2.544656] ata5: SATA max UDMA/133 abar m2048@0xdc333000 port
0xdc333300 irq 122
[    2.544659] ata6: SATA max UDMA/133 abar m2048@0xdc333000 port
0xdc333380 irq 122
[    2.544662] ata7: SATA max UDMA/133 abar m2048@0xdc333000 port
0xdc333400 irq 122
[    2.544666] ata8: SATA max UDMA/133 abar m2048@0xdc333000 port
0xdc333480 irq 122
[    3.552450] ata8: failed to resume link (SControl 0)
[    3.552471] ata8: SATA link down (SStatus 0 SControl 0)
[    3.552491] ata7: failed to resume link (SControl 0)
[    3.552508] ata7: SATA link down (SStatus 0 SControl 0)
[    3.552528] ata6: failed to resume link (SControl 0)
[    3.552548] ata6: SATA link down (SStatus 0 SControl 0)
[    3.552567] ata5: failed to resume link (SControl 0)
[    3.552585] ata5: SATA link down (SStatus 0 SControl 0)
[    3.552602] ata4: failed to resume link (SControl 0)
[    3.552616] ata4: SATA link down (SStatus 0 SControl 0)
[    4.051472] ata2: failed to resume link (SControl FFFFFFFF)
[    4.051493] ata2: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[    4.052349] ata1: failed to resume link (SControl FFFFFFFF)
[    4.052370] ata1: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[    4.052394] ata3: failed to resume link (SControl FFFFFFFF)
[    4.052414] ata3: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[    4.556598] Write protecting the kernel read-only data: 14336k
[   12.410784] EXT4-fs (dm-1): mounted filesystem with ordered data
mode. Opts: (null)
[   13.471239] EXT4-fs (nvme0n1p2): mounted filesystem with ordered
data mode. Opts: (null)

It has Alpine Ridge, but I don't think there's such thing as SATA over
USB Type C.  I'd guess that that what's going on is that the ahci
controller genuinely has zero ports enabled and the workaround for
port_map == 0 is firing incorrectly.

This is Linux 4.4.

--Andy
