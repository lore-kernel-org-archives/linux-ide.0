From: Aalderd Bouwman <boac@wanadoo.nl>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 =?iso-8859-1?q?using=09ahci=09module?=
Date: Tue, 20 Jun 2006 17:21:26 +0200
Message-ID: <200606201721.26291.boac@wanadoo.nl>
References: <1149787827.4180.8.camel@anja> <1150745738.4302.1.camel@anja> <20060620023312.GA1250@htj.dyndns.org>
Reply-To: boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp04.wanadoo.nl ([194.134.35.144]:17412 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S1751304AbWFTPVc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 11:21:32 -0400
In-Reply-To: <20060620023312.GA1250@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Oke,

About the driver I mentioned:
I don't know if it use the NCQ functionality.
It was the Windows binary of VIA.
Sorry for the missing information.

About the given patch:
I have applied the patch by hand :-)

Loading driver ahci:

Jun 20 16:28:04 server ACPI: PCI interrupt for device 0000:00:0f.0 disabled
Jun 20 16:28:07 server ahci 0000:00:0f.0: version 1.3
Jun 20 16:28:07 server ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> 
GSI 10 (level, low) -> IRQ 10
Jun 20 16:28:13 server ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 
Gbps 0xf impl SATA mode
Jun 20 16:28:13 server ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio 
slum part 
Jun 20 16:28:13 server ata29: SATA max UDMA/133 cmd 0xE048AD00 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:28:13 server ata30: SATA max UDMA/133 cmd 0xE048AD80 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:28:13 server ata31: SATA max UDMA/133 cmd 0xE048AE00 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:28:13 server ata32: SATA max UDMA/133 cmd 0xE048AE80 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:28:14 server ata29: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 20 16:28:14 server ata29.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 
86:3c01 87:4023 88:407f
Jun 20 16:28:14 server ata29.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 
NCQ (depth 0/32)
Jun 20 16:28:14 server ata29.00: configured for UDMA/133
Jun 20 16:28:14 server scsi28 : ahci
Jun 20 16:28:14 server ata30: SATA link down (SStatus 0 SControl 300)
Jun 20 16:28:14 server scsi29 : ahci
Jun 20 16:28:14 server ata31: SATA link down (SStatus 0 SControl 300)
Jun 20 16:28:14 server scsi30 : ahci
Jun 20 16:28:14 server ata32: SATA link down (SStatus 0 SControl 300)
Jun 20 16:28:14 server scsi31 : ahci
Jun 20 16:28:14 server Vendor: ATA       Model: ST3808110AS       Rev: 3.AA
Jun 20 16:28:14 server Type:   Direct-Access                      ANSI SCSI 
revision: 05
Jun 20 16:28:14 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 20 16:28:14 server sda: Write Protect is off
Jun 20 16:28:14 server sda: Mode Sense: 00 3a 00 00
Jun 20 16:28:14 server SCSI device sda: drive cache: write back
Jun 20 16:28:14 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 20 16:28:14 server sda: Write Protect is off
Jun 20 16:28:14 server sda: Mode Sense: 00 3a 00 00
Jun 20 16:28:14 server SCSI device sda: drive cache: write back
Jun 20 16:28:14 server sda: sda1 sda2 sda3 sda4 < sda5 >
Jun 20 16:28:14 server sd 28:0:0:0: Attached scsi disk sda
Jun 20 16:28:14 server sd 28:0:0:0: Attached scsi generic sg0 type 0

make ext2 filesystem succeeds on /dev/sda1 and also fdisk succeeds :-)

Removing driver:
Jun 20 16:29:54 server ACPI: PCI interrupt for device 0000:00:0f.0 disabled

Loading driver:
Jun 20 16:30:00 server ahci 0000:00:0f.0: version 1.3
Jun 20 16:30:00 server ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> 
GSI 10 (level, low) -> IRQ 10
Jun 20 16:30:06 server ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 
Gbps 0xf impl SATA mode
Jun 20 16:30:06 server ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio 
slum part 
Jun 20 16:30:06 server ata33: SATA max UDMA/133 cmd 0xE048AD00 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:30:06 server ata34: SATA max UDMA/133 cmd 0xE048AD80 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:30:06 server ata35: SATA max UDMA/133 cmd 0xE048AE00 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:30:06 server ata36: SATA max UDMA/133 cmd 0xE048AE80 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:30:06 server ata33: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 20 16:30:06 server ata33.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 
86:3c01 87:4023 88:407f
Jun 20 16:30:06 server ata33.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 
NCQ (depth 0/32)
Jun 20 16:30:06 server ata33.00: configured for UDMA/133
Jun 20 16:30:06 server scsi32 : ahci
Jun 20 16:30:06 server ata34: SATA link down (SStatus 0 SControl 300)
Jun 20 16:30:06 server scsi33 : ahci
Jun 20 16:30:06 server ata35: SATA link down (SStatus 0 SControl 300)
Jun 20 16:30:06 server scsi34 : ahci
Jun 20 16:30:07 server ata36: SATA link down (SStatus 0 SControl 300)
Jun 20 16:30:07 server scsi35 : ahci
Jun 20 16:30:07 server Vendor: ATA       Model: ST3808110AS       Rev: 3.AA
Jun 20 16:30:07 server Type:   Direct-Access                      ANSI SCSI 
revision: 05
Jun 20 16:30:07 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 20 16:30:07 server sda: Write Protect is off
Jun 20 16:30:07 server sda: Mode Sense: 00 3a 00 00
Jun 20 16:30:07 server SCSI device sda: drive cache: write back
Jun 20 16:30:07 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 20 16:30:07 server sda: Write Protect is off
Jun 20 16:30:07 server sda: Mode Sense: 00 3a 00 00
Jun 20 16:30:07 server SCSI device sda: drive cache: write back
Jun 20 16:30:07 server sda: sda1 sda2 sda3 sda4 < sda5 >
Jun 20 16:30:07 server sd 32:0:0:0: Attached scsi disk sda
Jun 20 16:30:07 server sd 32:0:0:0: Attached scsi generic sg0 type 0
Jun 20 16:30:58 server ACPI: PCI interrupt for device 0000:00:0f.0 disabled

And reloading driver :-)

Jun 20 16:31:04 server ahci 0000:00:0f.0: version 1.3
Jun 20 16:31:04 server ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKB] -> 
GSI 10 (level, low) -> IRQ 10
Jun 20 16:31:09 server ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 
Gbps 0xf impl SATA mode
Jun 20 16:31:09 server ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio 
slum part 
Jun 20 16:31:09 server ata37: SATA max UDMA/133 cmd 0xE0488D00 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:31:09 server ata38: SATA max UDMA/133 cmd 0xE0488D80 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:31:09 server ata39: SATA max UDMA/133 cmd 0xE0488E00 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:31:09 server ata40: SATA max UDMA/133 cmd 0xE0488E80 ctl 0x0 bmdma 
0x0 irq 10
Jun 20 16:31:10 server ata37: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 20 16:31:10 server ata37.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 
86:3c01 87:4023 88:407f
Jun 20 16:31:10 server ata37.00: ATA-7, max UDMA/133, 156301488 sectors: LBA48 
NCQ (depth 0/32)
Jun 20 16:31:10 server ata37.00: configured for UDMA/133
Jun 20 16:31:10 server scsi36 : ahci
Jun 20 16:31:10 server ata38: SATA link down (SStatus 0 SControl 300)
Jun 20 16:31:10 server scsi37 : ahci
Jun 20 16:31:10 server ata39: SATA link down (SStatus 0 SControl 300)
Jun 20 16:31:10 server scsi38 : ahci
Jun 20 16:31:10 server ata40: SATA link down (SStatus 0 SControl 300)
Jun 20 16:31:10 server scsi39 : ahci
Jun 20 16:31:10 server Vendor: ATA       Model: ST3808110AS       Rev: 3.AA
Jun 20 16:31:10 server Type:   Direct-Access                      ANSI SCSI 
revision: 05
Jun 20 16:31:10 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 20 16:31:10 server sda: Write Protect is off
Jun 20 16:31:10 server sda: Mode Sense: 00 3a 00 00
Jun 20 16:31:10 server SCSI device sda: drive cache: write back
Jun 20 16:31:10 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 20 16:31:10 server sda: Write Protect is off
Jun 20 16:31:10 server sda: Mode Sense: 00 3a 00 00
Jun 20 16:31:10 server SCSI device sda: drive cache: write back
Jun 20 16:31:10 server sda: sda1 sda2 sda3 sda4 < sda5 >

Changing the partition-table on the disk (remove logical and creating 2 
logical partitions):

Jun 20 16:31:10 server sd 36:0:0:0: Attached scsi disk sda
Jun 20 16:31:10 server sd 36:0:0:0: Attached scsi generic sg0 type 0
Jun 20 16:32:49 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 20 16:32:49 server sda: Write Protect is off
Jun 20 16:32:49 server sda: Mode Sense: 00 3a 00 00
Jun 20 16:32:49 server SCSI device sda: drive cache: write back
Jun 20 16:32:49 server sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
Jun 20 16:32:51 server SCSI device sda: 156301488 512-byte hdwr sectors (80026 
MB)
Jun 20 16:32:51 server sda: Write Protect is off
Jun 20 16:32:51 server sda: Mode Sense: 00 3a 00 00
Jun 20 16:32:51 server SCSI device sda: drive cache: write back
Jun 20 16:32:51 server sda: sda1 sda2 sda3 sda4 < sda5 sda6 >

Make reiserfs 3.x filesystem and mount /dev/sda5:

Jun 20 16:34:21 server ReiserFS: sda5: found reiserfs format "3.6" with 
standard journal
Jun 20 16:34:24 server ReiserFS: sda5: using ordered data mode
Jun 20 16:34:24 server ReiserFS: sda5: journal params: device sda5, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit age 30, 
max trans age 30
Jun 20 16:34:24 server ReiserFS: sda5: checking transaction log (sda5)
Jun 20 16:34:24 server ReiserFS: sda5: Using r5 hash to sort names

Copy 5gig data and compare it 4 times with success :-)

Unmount and remove driver:
Jun 20 17:06:30 ACPI: PCI interrupt for device 0000:00:0f.0 disabled

As you can see it works.
Now I will check the hotplug functionality and if you have a patch for maybe 
better NCQ usage I want to test him for you.

Aalderd.

On Tuesday 20 June 2006 04:33, Tejun Heo wrote:
> On Mon, Jun 19, 2006 at 09:35:38PM +0200, Aalderd Bouwman wrote:
> > Note the date: jun 8 :)
> >
> > As I said I cannot fdisk because the drive isn't available.
> > So I don't receive spurious message anymore.
> >
> > In all other logs I have posted I don't have the 'spurious message.
>
> I see, so the spurious interrupt isn't related.  Can you try the
> following patch?  It simply disable NCQ on via AHCI.  Does the via
> driver you mentioned do NCQ?  Is the driver open-source?
>
> diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
> index e261b37..8208546 100644
> --- a/drivers/scsi/ahci.c
> +++ b/drivers/scsi/ahci.c
> @@ -164,6 +164,7 @@ enum {
>
>  	/* ap->flags bits */
>  	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
> +	AHCI_FLAG_NO_NCQ		= (1 << 25),
>  };
>
>  struct ahci_cmd_hdr {
> @@ -277,7 +278,7 @@ static const struct ata_port_info ahci_p
>  		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>  				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
>  				  ATA_FLAG_SKIP_D2H_BSY |
> -				  AHCI_FLAG_RESET_NEEDS_CLO,
> +				  AHCI_FLAG_RESET_NEEDS_CLO | AHCI_FLAG_NO_NCQ,
>  		.pio_mask	= 0x1f, /* pio0-4 */
>  		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
>  		.port_ops	= &ahci_ops,
> @@ -1362,7 +1363,8 @@ static int ahci_init_one (struct pci_dev
>  	if (rc)
>  		goto err_out_hpriv;
>
> -	if (hpriv->cap & HOST_CAP_NCQ)
> +	if (!(probe_ent->host_flags & AHCI_FLAG_NO_NCQ) &&
> +	    (hpriv->cap & HOST_CAP_NCQ))
>  		probe_ent->host_flags |= ATA_FLAG_NCQ;
>
>  	ahci_print_info(probe_ent);
