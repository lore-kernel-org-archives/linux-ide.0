From: Thomas Rohwer <tr@tng.de>
Subject: Hang during boot in piix_init_pcs (ata_piix.c) with macbook pro
Date: Sun, 11 Nov 2007 15:45:26 +0100
Message-ID: <47371586.9090409@tng.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2-1.tng.de ([213.178.66.95]:51689 "EHLO smtp2.tng.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754667AbXKKPwU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Nov 2007 10:52:20 -0500
Received: from smtp.tng.de (liadriel1.tng.de [213.178.66.91])
	by smtp2.tng.de (Postfix) with ESMTP id 13E148029D
	for <linux-ide@vger.kernel.org>; Sun, 11 Nov 2007 15:45:27 +0100 (CET)
Received: from [172.19.3.2] (unknown [213.178.87.137])
	by smtp.tng.de (Postfix) with ESMTP id 500F817C002
	for <linux-ide@vger.kernel.org>; Sun, 11 Nov 2007 15:45:27 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I am using kernel 2.6.23 with the driver drivers/ata/ata_piix.c on my macbook pro.
About every fourth boot hangs. I tried to narrow down the problem by putting in dome printk
statements and found (at least on 2 hangs so far) that the msleep(150) in piix_init_pcs
does not return:

static void __devinit piix_init_pcs(struct pci_dev *pdev,
                     struct ata_port_info *pinfo,
                     const struct piix_map_db *map_db)
{
     u16 pcs, new_pcs;

     printk("piix_init_pcs 1");
     pci_read_config_word(pdev, ICH5_PCS, &pcs);
     printk("piix_init_pcs 2");

     new_pcs = pcs | map_db->port_enable;

     if (new_pcs != pcs) {
         printk("updating PCS from 0x%x to 0x%x\n", pcs, new_pcs);
         DPRINTK("updating PCS from 0x%x to 0x%x\n", pcs, new_pcs);
         pci_write_config_word(pdev, ICH5_PCS, new_pcs);
         printk("updating PCS done");
         msleep(150);
         printk("updating PCS done wait");
     }
}

The "updating PCS done" is printed but the "updateing PCS done wait" is not printed.
The following is part of the dmesg output of a working boot. The hang always happens with
the SATA controller (i.e. 0000:00:1f.2):

ata_piix 0000:00:1f.1: version 2.12
ata_pci_init_one d
ata_pci_init_one e
ata_pci_init_one f
piix_init_one before ret
ata_pci_init_one a
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 21 (level, low) -> IRQ 18
ata_pci_init_one b
ata_pci_init_one c
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata_pci_init_one d
ata_pci_init_one e
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x000160e0 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x000160e8 irq 15
ata1.00: ATAPI: HL-DT-ST DVDRW  GSA-S10N, AP09, max UDMA/33
ata1.00: configured for UDMA/33
Clocksource tsc unstable (delta = -497173580 ns)
scsi 0:0:0:0: CD-ROM            HL-DT-ST DVDRW  GSA-S10N  AP09 PQ: 0 ANSI: 5
ata_pci_init_one done
piix_init_one a
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
piix_init_one b
piix_init_pcs 1piix_init_pcs 2updating PCS from 0x8101 to 0x8103
updating PCS doneupdating PCS done waitpiix_init_one c
ata_pci_init_one d
ata_pci_init_one e
ata_pci_init_one f
piix_init_one before ret
ata_pci_init_one a
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 18 (level, low) -> IRQ 19
ata_pci_init_one b
ata_pci_init_one c
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata_pci_init_one d
ata_pci_init_one e
scsi2 : ata_piix
scsi3 : ata_piix
ata3: SATA max UDMA/133 cmd 0x000160f8 ctl 0x00016116 bmdma 0x00016020 irq 19
ata4: SATA max UDMA/133 cmd 0x000160f0 ctl 0x00016112 bmdma 0x00016028 irq 19
ata3.00: ATA-8: FUJITSU MHW2120BH, 00810013, max UDMA/100
ata3.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/100
scsi 2:0:0:0: Direct-Access     ATA      FUJITSU MHW2120B 0081 PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA

lspci -n for the devices is:

00:1f.1 0101: 8086:2850 (rev 03)
00:1f.2 0101: 8086:2828 (rev 03)


My next try would be to put in a custom version ich8_map_db with port_enable=1
(and possibly {P0, P2, NA, NA} in the first line of .map) and use this map
for pci id 8086:2828, because I think the notebook has only one sata port anyway.
Is this the correct way to approach the matter?


Please carbon copy me when answering, as I am not subscribed to the list.

Sincerely,

Thomas Rohwer
