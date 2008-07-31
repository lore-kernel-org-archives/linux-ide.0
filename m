From: gshan <gshan@alcatel-lucent.com>
Subject: Re: PIIX4: DMA timeout issue
Date: Thu, 31 Jul 2008 12:30:53 +0800
Message-ID: <48913FFD.5070901@alcatel-lucent.com>
References: <488ED837.2060509@alcatel-lucent.com>	<488F1C6C.9000002@garzik.org>	<48902EB5.8070102@alcatel-lucent.com> <20080730114934.5a593cf4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 215.47.DSNET ([211.144.215.47]:54754 "EHLO
	cnshjsmin03.cn.alcatel-lucent.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750841AbYGaEbb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jul 2008 00:31:31 -0400
In-Reply-To: <20080730114934.5a593cf4@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>


>> Another question is my PIIX4 chip has device ID + vendor ID of=20
>> 0x71108086. But it finally
>> was mapped to following ID of piix_pci_tbl[] array. Device of 0x7110=
 and=20
>> 0x7010 should
>> be quit different, right?
>>    =20
>
> Yes - I find tht one very odd - you might need to debug a bit to see =
what
> is occuring if you think this is the case.
>
> Alan
>  =20
Alan/Jeff, I tried to install ATA driver on PIIX4. After fixing IRQ num=
ber
to 143 for primary and secondary channel. I got following output and
it seems the driver has been loaded sucessfully. However, I couldn't
see any information from /proc/devices. Do you have any ideas?

piix_init: enter
piix_init_one: pci device: =EF=BF=BD[eh
piix_init_one: vendor=3D0x00008086, device=3D0x00007111
piix_init_one: piix_host_priv allocated
piix_init_one: ent->driver_data=3D0
ata_pci_init_one: n_ports=3D2
ata_pci_init_one: pci device enabled
ata_pci_init_one: pci device class=3D0x00010180
ata_pci_init_one: legacy_mode=3D8
ata_pci_init_one: DMA mode has been set
ata_pci_init_legacy_port: port_mask=3D0x0000000b
ata_pci_init_legacy_port: ATA_PRIMARY_CMD=3D0x000001f0,=20
ATA_PRIMARY_CTL=3D0x000003f6
ata_pci_init_legacy_port: ATA_SECONDARY_CMD=3D0x00000170,=20
ATA_SECONDARY_CTL=3D0x00000376
ata_pci_init_legacy_port: BMDMA=3D0xfbf00000
, phys=3D0x00001000, phys_end=3D0x0000100f
ata_pci_init_legacy_port: probe_ent initialized
ata_pci_init_legacy_port: IRQ line of primary channel is 143
ata_pci_init_legacy_port: IRQ line of secondary channel is 143
ata_pci_init_one: Master set
ata1: PATA max UDMA/33 cmd 0xfbeff1f0 ctl 0xfbeff3f6 bmdma 0xfbf00000=20
irq 143
ata2: PATA max UDMA/33 cmd 0xfbeff170 ctl 0xfbeff376 bmdma 0xfbf00008=20
irq 143
scsi0 : ata_piix
scsi1 : ata_piix
ata2.00: ATA-6: HTE721010G9AT00, MCZOA51A, max UDMA/100
ata2.00: 195371568 sectors, multi 0: LBA48
ata2.00: configured for UDMA/33
1:0:0:0: Direct-Access ATA HTE721010G9AT00 MCZO PQ: 0 ANSI: 5

/ $ cat /proc/devices
Character devices:
1 mem
2 pty
3 ttyp
4 /dev/vc/0
4 tty
5 /dev/tty
5 /dev/console
5 /dev/ptmx
7 vcs
10 misc
13 input
90 mtd
128 ptm
136 pts
204 ttyMM
205 ttyVC
206 ttySC
253 telica_sysinfo
254 mlba

Block devices:
1 ramdisk
7 loop
31 mtdblock

Gavin


