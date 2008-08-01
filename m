From: gshan <gshan@alcatel-lucent.com>
Subject: Re: PIIX4: DMA timeout issue
Date: Fri, 01 Aug 2008 16:38:44 +0800
Message-ID: <4892CB94.8090703@alcatel-lucent.com>
References: <488ED837.2060509@alcatel-lucent.com>	<488F1C6C.9000002@garzik.org>	<48902EB5.8070102@alcatel-lucent.com> <20080730114934.5a593cf4@lxorguk.ukuu.org.uk> <48913FFD.5070901@alcatel-lucent.com> <4892BEBA.2000602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 215.47.DSNET ([211.144.215.47]:49639 "EHLO
	cnshjsmin03.cn.alcatel-lucent.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752045AbYHAIjn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Aug 2008 04:39:43 -0400
In-Reply-To: <4892BEBA.2000602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>


>> Alan/Jeff, I tried to install ATA driver on PIIX4. After fixing IRQ =
number
>> to 143 for primary and secondary channel. I got following output and
>> it seems the driver has been loaded sucessfully. However, I couldn't
>> see any information from /proc/devices. Do you have any ideas?
>>    =20
>
> You need the SCSI disk driver - sd_mod.ko.
>
>  =20
Thanks a lot. It seems it starts to work now.

piix_init: enter
piix_init_one: pci device: =EF=BF=BD\
                             @
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
 1:0:0:0: Direct-Access     ATA      HTE721010G9AT00  MCZO PQ: 0 ANSI: =
5
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
SCSI device sda: 195371568 512-byte hdwr sectors (100030 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't=20
support DPO or FUA
 sda: sda1 sda4 < sda5 sda6 sda7 sda8 >
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0

Gavin
