From: Andrew Benton <b3nton@gmail.com>
Subject: ata2: lost interrupt with kernel 2.6.34-rc1
Date: Thu, 11 Mar 2010 16:57:52 +0000
Message-ID: <4B992110.2090300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,
I'm not subscribed to this list, sorry if it's the wrong place to send this.
I've been having problems with 2.6.34-rc1, when the system tries to access a
lot of files (eg, if I recompile the kernel) it freezes for about 10 seconds
or so and then I get a message like this in the sys.log:

ata2: lost interrupt (Status 0x50)
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0 frozen
ata2.01: failed command: WRITE DMA
ata2.01: cmd ca/00:08:4c:37:6f/00:00:00:00:00/fd tag 0 dma 4096 out
          res 40/00:00:00:00:00/00:00:00:00:00/10 Emask 0x4 (timeout)
ata2.01: status: { DRDY }
ata2.00: hard resetting link
ata2.01: hard resetting link
ata2.00: SATA link down (SStatus 0 SControl 300)
ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.01: configured for UDMA/133
ata2.01: device reported invalid CHS sector 0
ata2: EH complete

or this:

ata2: lost interrupt (Status 0x50)
ata2.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0 frozen
ata2.01: failed command: READ DMA EXT
ata2.01: cmd 25/00:08:1b:90:4d/00:00:1a:00:00/f0 tag 0 dma 4096 in
          res 40/00:00:00:00:00/00:00:00:00:00/10 Emask 0x4 (timeout)
ata2.01: status: { DRDY }
ata2.00: hard resetting link
ata2.01: hard resetting link
ata2.00: SATA link down (SStatus 0 SControl 300)
ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.01: configured for UDMA/133
ata2.01: device reported invalid CHS sector 0
ata2: EH complete

It works fine with 2.6.33

lspci | grep ATA gives:

00:1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port SATA IDE Controller #1
00:1f.5 IDE interface: Intel Corporation 82801JI (ICH10 Family) 2 port SATA IDE Controller #2

zgrep ATA /proc/config.gz gives:

# CONFIG_RELOCATABLE is not set
# CONFIG_ATALK is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_PMP is not set
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y
# CONFIG_SATA_SVW is not set
CONFIG_ATA_PIIX=y
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_PATA_ACPI is not set
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5535 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_LEGACY is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set
# CONFIG_PATA_SCH is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set

Andy
