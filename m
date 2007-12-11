From: trash can <thetrashcan@earthlink.net>
Subject: Re: Iomega ZIP-100 drive unsupported with jmicron JMB361 chip?
Date: Tue, 11 Dec 2007 10:38:05 -0500
Message-ID: <475EAEDD.9090905@earthlink.net>
References: <fa.yONLBG7CMuz80f4dUP5r/5k7emw@ifi.uio.no> <475DD7FF.4030906@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755145AbXLKPkG@vger.kernel.org>
In-Reply-To: <475DD7FF.4030906@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org, ide <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Robert Hancock wrote:
> That is rather curious. There's no sign of any libata error handling
> going on.. Maybe the drive is actually returning that error code in the
> ATAPI CDB, or at least we think it is?
> 
> You are sure that this drive still works with older kernels using
> drivers/ide, and that the hardware didn't break at some point, I assume?
> 
Thanks for your time. I get a kernel panic with the controller mode in BIOS
set to AHCI with Fedora Core 6. Once returned to IDE (setting used since
computer was built) I booted up. Added information: In Fedora 7 I can not
burn DVDs or CDROM using K3b with the Zip drive connected. Some
preformatting (I assume) is done rendering the CD/DVD useless then got an
I/O error. In Fedora 8 I am able to burn a CDROM using K3b but DVDs behave
as with Fedora 7. All is well when the Zip is totaly removed. This Zip
drive also worked under Microsoft 2000 { which was removed over a year
ago ;-) }. Fedora Core 6, Fedora 7, and Fedora 8 are all installed on
this machine. This drive did not work with a Ubuntu 7.10 Live CD on this
machine. I intend to try this Zip drive on another motherboard with the
above live CD.

- --RoyBoy626

Fedora Core 6 information (computer booted December 11th with Zip
disk inserted):
# uname -r
2.6.22.5-49.fc6

# blkid
/dev/hdb4: SEC_TYPE="msdos" LABEL="ZIP-100" UUID="XXXX-YYYY" TYPE="vfat"

from dmesg:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
JMB361: IDE controller at PCI slot 0000:03:00.1
PCI: Enabling device 0000:03:00.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:03:00.1[B] -> GSI 17 (level, low) -> IRQ 17
JMB361: chipset revision 2
JMB361: 100% native mode on irq 17
PCI: Setting latency timer of device 0000:03:00.1 to 64
    ide0: BM-DMA at 0xc400-0xc407, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xc408-0xc40f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: LITE-ON DVDRW SOHW-1693S, ATAPI CD/DVD-ROM drive
hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hda: host side 80-wire cable detection failed, limiting max speed to UDMA33
hda: selected mode 0x42
hdb: selected mode 0x21
ide0 at 0xcc00-0xcc07,0xc882 on irq 17
Probing IDE interface ide1...
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
hdb: 98304kB, 196608 blocks, 512 sector size
hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
 hdb: hdb4

Manual mount: mount -t vfat /dev/hdb4 /mnt/zip
/var/log/messages response: Dec 11 10:12:43  kernel:  hdb: hdb4

]# df /mnt/zip
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hdb4                98078     11782     86296  13% /mnt/zip

All is well in Fedora Core 6.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHXq7dz1/aqdDsM3URAvV0AKDzd4PnK9/Bt7jao0OIsPrIAHxMVACfbzkY
feZlOXUDXZ9bmiArwsp+O78=
=1jws
-----END PGP SIGNATURE-----
