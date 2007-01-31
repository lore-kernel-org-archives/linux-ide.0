From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Add suport for Marvell 88SE6121 in ahci
Date: Wed, 31 Jan 2007 15:04:40 +0100
Message-ID: <200701311504.40277.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4HKwFL465w9409c"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.telefonica.net ([213.4.149.66]:27335 "EHLO
	ctsmtpout1.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933275AbXAaOEm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 09:04:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jay Cliburn <jacliburn@bellsouth.net>

--Boundary-00=_4HKwFL465w9409c
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This work for kernel 2.6.20-rc6

First apply this patch:

http://marc.theaimsgroup.com/?l=linux-ide&m=116986924301674&w=2

Then apply the patch attached.

Comments:

The Marvell 88SE6121 has three ports (0,1,2). The PATA port is port 2. (PATA 
port for 6141 is port 4). In M2V Motherboard(Marvell 88SE6121) there is only 
two SATA ports, one of them is external SATA. This two ports work well with 
this patch.

With this part:

<       if (pci_enable_msi(pdev) == 0)
---
>       if ((pdev->vendor != PCI_VENDOR_ID_MARVELL) && (pci_enable_msi(pdev) 
== 0))

you don't need to disable MSI in kernel.
MMCONFIG is disabled at startup in M2V.

dmesg:
........
PCI: Not using MMCONFIG.
........

Jose Alberto

--Boundary-00=_4HKwFL465w9409c
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ahci_6121.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ahci_6121.diff"

441a442
> 	{ PCI_VDEVICE(MARVELL, 0x6121), board_ahci_mv },	/* 6121 */
714c715,718
< 		port_mmio = ahci_port_base(mmio, 4);
---
> 		if (pdev->device == 0x6121)
> 			port_mmio = ahci_port_base(mmio, 2);
> 		else
> 			port_mmio = ahci_port_base(mmio, 4);
1531,1540c1535,1558
< 		dev_printk(KERN_ERR, &pdev->dev,
< 			   "MV_AHCI HACK: port_map %x -> %x, cap_n %u -> %u\n",
< 			   hpriv->port_map,
< 			   hpriv->port_map & 0xf,
< 			   cap_n_ports,
< 			   (cap_n_ports > 4) ? 4 : cap_n_ports);
< 
< 		hpriv->port_map &= 0xf;
< 		if (cap_n_ports > 4)
< 			cap_n_ports = 4;
---
> 		if (pdev->device == 0x6121) {
> 			dev_printk(KERN_ERR, &pdev->dev,
> 				   "MV_AHCI HACK: port_map %x -> %x, cap_n %u -> %u\n",
> 				   hpriv->port_map,
> 				   hpriv->port_map & 0x3,
> 				   cap_n_ports,
> 				   (cap_n_ports > 2) ? 2 : cap_n_ports);
> 
> 			hpriv->port_map &= 0x3;
> 			if (cap_n_ports > 2)
> 				cap_n_ports = 2;
> 		}
> 		else {
> 			dev_printk(KERN_ERR, &pdev->dev,
> 				   "MV_AHCI HACK: port_map %x -> %x, cap_n %u -> %u\n",
> 				   hpriv->port_map,
> 				   hpriv->port_map & 0xf,
> 				   cap_n_ports,
> 				   (cap_n_ports > 4) ? 4 : cap_n_ports);
> 
> 			hpriv->port_map &= 0xf;
> 			if (cap_n_ports > 4)
> 				cap_n_ports = 4;
> 		}
1718c1736
< 	if (pci_enable_msi(pdev) == 0)
---
> 	if ((pdev->vendor != PCI_VENDOR_ID_MARVELL) && (pci_enable_msi(pdev) == 0))

--Boundary-00=_4HKwFL465w9409c
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

ahci 0000:06:00.0: version 2.0
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 28 (level, low) -> IRQ 28
ahci 0000:06:00.0: MV_AHCI HACK: port_map 7 -> 3, cap_n 3 -> 2
PCI: Setting latency timer of device 0000:06:00.0 to 64
ahci 0000:06:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x3 impl IDE mode
ahci 0000:06:00.0: flags: 64bit ncq stag led pmp slum part
ata3: SATA max UDMA/133 cmd 0xFFFFC20000020D00 ctl 0x0 bmdma 0x0 irq 28
ata4: SATA max UDMA/133 cmd 0xFFFFC20000020D80 ctl 0x0 bmdma 0x0 irq 28
scsi2 : ahci
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-6, max UDMA/133, 234441648 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/133
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
scsi 2:0:0:0: Direct-Access     ATA      ST3120827AS      3.42 PQ: 0 ANSI: 5
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdc: 234441648 512-byte hdwr sectors (120034 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc

--Boundary-00=_4HKwFL465w9409c--
