From: Declan Moriarty <declan.moriarty@iol.ie>
Subject: Re: IDE Problem with old Gateway laptop (1998 solo 2300)
Date: Wed, 31 Oct 2007 11:42:45 +0000
Message-ID: <1193830965.2347.66.camel@turtle-25895.iol.ie>
References: <884696.96067.qm@web54404.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.mail.iol.ie ([193.95.141.54]:36686 "EHLO
	mail2.mail.iol.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbXJaLmt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:42:49 -0400
In-Reply-To: <884696.96067.qm@web54404.mail.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad Codrea <vladc6@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide <linux-ide@vger.kernel.org>


> The above output seems to indicate that the kernel is still relying on
> drivers/ide instead of libata. To change this, I'd suggest setting
> "CONFIG_IDE=n" and "CONFIG_ATA=y" in your .config before compiling the
> kernel. Also, make sure everything that starts with CONFIG_ATA,
> CONFIG_PATA, CONFIG_SATA, and CONFIG_SCSI is set to "y".

OK, managed this at the second attempt.
Checked the .config with grep . I even thought of converting hda to sda
in fstab & grub. First time I failed to compile in ext3, so I got
'couldn't mount root' stuff. This time I'm using the system above the
1024 cylinder limit, so I'd expect that 'couldn't mount root' again if
it couldn't read it. Apparently the 1024 cylinder thing was a red
herring.

We wait at exactly the same place. Typing onscreen works. I'll spare you
all the initcalls, and just mention the relevant ones

pci_init returned this
	Limiting Direct PCI/PCI transfers

loopback_init
scsi_tgt_init
init_sd
init_sg
ahci_init
k2_sata_init
piix_init
	scsi0: ata_piix
	scsi1: ata_piix
	ata1: PATA max udma/33 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001fcd0
irq 14
	ata2: PATA max udma/33 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001fcd8
irq 15
	ATA1.00: ATA-3 HITATCHI_DK226A-32 00T0A0A0 max MWDMA2
	ATA1.00: 6332256 sectors multi 16: LBA
	ATA1.00: configured for MWDMA2
	scsi 0:0:0:0 Direct Access ATA Hitatchi_DK226A-3 00T0 PQ: 0 ANSI 5
	sd 0:0:0:0 [sda] 6332256 512-byte hardware sectors (3242MB)
	sd 0:0:0:0 [sda] Write Protect is off
	sd 0:0:0:0 [sda] Write cache: disabled, read cache: enabled doesn't
support DPO or FUA
	sda: sda1 sda2 sda3 ssda4
	sd 0:0:0:0 [sda] Attached scsi disk
	sd 0:0:0:0 [sda] Attached scsi generic sg0 type 0
(piix_init returned 0 ran for 383 msec. The following ones ran for 0
msec)

pdc_ata_init
qs_ata_init
sil_init
sil24_init
svia_init
vsc_sata_init
sis_init
pdc_sata_init
nv_init
uli_init
mv_init
inic_init
adma_ata_init
ali_init
amd_init
artop_init
atiixp_init
cmd640_init
cs5520_init
cs5530_init
cs5535_init
cy82c693_init
efar_init
hpt36x_init
hpt37x_init
hpt3x2n_init
hpt3x3_init
it821x_init
it8213_init
jmicron_init
netcell_init
ns87410_init
opti_init
optidma_init
marvell_init
mpiix_init
piix_init
oldpiix_init 
pdc2027x_init
pdc202xx_init
qdi_init
radisys_init
rz1000_init
sc1200_init
serverworks_init
sil680_init
via_init
sl82c105_init
winbond_init
sis_init
triflex_init
ata_generic_init
legacy_init
mon_init
..
pcspeaker_init (ran for 375 msec)
io_apic_bug_finalize
pci_sysfs_init
scsi_complete_async_scans
tcp_congestion_default
	kjournald starting Commit interval 5 seconds
	VFS: Mounted root (ext3 filesystem) readonly
	Freeing unused kernel memory: 168k freed
(keyboard still echoed onscreen, disk parked)

Adding init=/bin/bash is no better.

Just to nail the possibility, I also did a chroot into the system I
built (here on an Athlon which is on that laptop) and ran the init
program. I got one very surprised and confused init, but it ran until I
killed it. 

I'm hoping just for a diagnosis - "X is wrong" I gather the ide stuff is
old, but ok
Please 'reply to all' as I'm not on the list.

