From: Ian Campbell <ijc@debian.org>
Subject: QNAP TS-419: sata_mv fails to initialise with "can't set global reset"
Date: Sun, 31 May 2015 11:35:34 +0100
Message-ID: <1433068534.5748.276.camel@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi,

After updating to 4.0.4 (from the Debian kernel package) my TS-419 can
no longer see its SATA disks. In dmesg I see:

[    2.599060] SCSI subsystem initialized
[    2.662882] libata version 3.00 loaded.
[    2.664776] sata_mv 0000:01:00.0: version 1.28
[    2.664888] pci 0000:00:01.0: enabling device (0140 -> 0143)
[    2.687579] sata_mv: can't set global reset
[    2.691825] sata_mv 0000:01:00.0: Driver probe function unexpectedly returned 1
[    2.734954] sata_mv f1080000.sata: version 1.28
[    2.735222] sata_mv f1080000.sata: slots 32 ports 2
[    2.773358] scsi host0: sata_mv
[    2.785712] scsi host1: sata_mv
[    2.796204] ata1: SATA max UDMA/133 irq 35
[    2.800359] ata2: SATA max UDMA/133 irq 35
[    3.120986] ata1: SATA link down (SStatus 0 SControl F300)
[    3.444974] ata2: SATA link down (SStatus 0 SControl F300)

The last version I tried which worked was the 3.18.5 package.

This is using kirkwood-ts419-6281.dtb, which given this I think is the
correct one:

[    0.000000] Linux version 4.0.0-2-kirkwood (debian-kernel@lists.debian.org) (gcc version 4.9.2 (Debian 4.9.2-18) ) #1 Debian 4.0.4-1 (2015-05-26)
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=0005397f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: QNAP TS419 family
[...]
[    0.044889] mvebu-soc-id: MVEBU SoC ID=0x6281, Rev=0x2

I can also see both PCI devices which IIRC is the main difference
between the 6281 and 6282.

I don't see anything in the git logs after 4.0 which looks like an
obviously related fix, but I'm currently building 4.1-rc5 to have a
check.

Ian.
