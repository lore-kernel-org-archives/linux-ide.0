From: Ming Zhang <mingz@ele.uri.edu>
Subject: Re: hotplug works, but newly plug not
Date: Wed, 24 May 2006 17:20:06 -0400
Message-ID: <1148505606.26093.179.camel@localhost.localdomain>
References: <1148484316.26093.72.camel@localhost.localdomain>
	 <4474C737.9000600@gmail.com>
	 <1148504987.26093.177.camel@localhost.localdomain>
Reply-To: mingz@ele.uri.edu
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orca.ele.uri.edu ([131.128.51.63]:55751 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S932454AbWEXVVP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 May 2006 17:21:15 -0400
In-Reply-To: <1148504987.26093.177.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide-list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

my fault. forgot to say that the patch does not change the behavior.
nothing happen after plug a disk to empty slot.

ming


On Wed, 2006-05-24 at 17:09 -0400, Ming Zhang wrote:
> On Wed, 2006-05-24 at 13:51 -0700, Tejun Heo wrote:
> > Ming Zhang wrote:
> > > Hi All
> > > 
> > > I use the libata patch from
> > > http://home-tj.org/wiki/index.php/Libata-tj-stable with my supermicro MB
> > > ( ICH7R chip). The AHCI works as desired in most of the time.
> > > 
> > > If I have disk(s) plugged in during boot. Then after boot, I kept unplug
> > > and plug many times and it works fine.
> > > 
> > > but i noticed that if I have the disk(s) unplugged during boot, then
> > > after boot, I plug the disk and nothing shows. if I try to do rescan by
> > > run the rescan lun script, i saw these from dmesg.
> > > 
> > > Anything clue ? Thanks!
> > > 
> > > Ming
> > > 
> > > ---------------------------------------
> > > ata4: soft resetting port
> > > ata4: SATA link down (SStatus 0 SControl 0)
> > > ata4: EH complete
> > > ata3: soft resetting port
> > > ata3: SATA link down (SStatus 0 SControl 0)
> > > ata3: EH complete
> > > ata4: soft resetting port
> > > ata4: SATA link down (SStatus 0 SControl 0)
> > > ata4: EH complete
> > > ata3: soft resetting port
> > > ata3: SATA link down (SStatus 0 SControl 0)
> > > ata3: EH complete
> > > ata4: soft resetting port
> > > ata4: SATA link down (SStatus 0 SControl 0)
> > > ata4: EH complete
> > 
> > Hello,
> > 
> > That never happened to me on AHCI mode but I experienced similar thing 
> > with piix mode.  It might be that your BIOS doesn't turn on PCS enable 
> 
> the BIOS has a option to switch between AHCI and PIIX. So I guess the
> reason is as you said.
> 
> also this is kernel boot log related to this. could u point out the
> place for this pcs in AHCI spec? i just printed AHCI and can not find
> related information about this PCS. the code operate at offset 0x92 but
> i can not find anything about that.
> 
> 
> libata version 1.30 loaded.
> ahci 0000:00:1f.2: version 1.3
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
> ahci 0000:00:1f.2: pcs 0x11->0x1f
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x1 impl SATA
> mode
> ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part
> ata1: SATA max UDMA/133 cmd 0xF881C500 ctl 0x0 bmdma 0x0 irq 19
> ata2: SATA max UDMA/133 cmd 0xF881C580 ctl 0x0 bmdma 0x0 irq 19
> ata3: SATA max UDMA/133 cmd 0xF881C600 ctl 0x0 bmdma 0x0 irq 19
> ata4: SATA max UDMA/133 cmd 0xF881C680 ctl 0x0 bmdma 0x0 irq 19
> scsi0 : ahci
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: cfg 49:2f00 82:74eb 83:7feb 84:4123 85:74e9 86:3c03 87:4123
> 88:007f
> ata1.00: ATA-7, max UDMA/133, 781422768 sectors: LBA48
> ata1.00: configured for UDMA/133
> scsi1 : ahci
> ata2: SATA link down (SStatus 0 SControl 0)
> scsi2 : ahci
> ata3: SATA link down (SStatus 0 SControl 0)
> scsi3 : ahci
> ata4: SATA link down (SStatus 0 SControl 0)
>   Vendor: ATA       Model: HDS724040KLSA80   Rev: KFAO
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda:
> sd 0:0:0:0: Attached scsi disk sda
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> 
> 
> 
> 
> > bits for empty ports and thus the empty ports cannot be used after boot. 
> > Can you try the attached patch?  (only compile-tested, be cautious)
> > 
> > plain text document attachment (patch)
> > diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
> > index 45fd71d..83751dd 100644
> > --- a/drivers/scsi/ahci.c
> > +++ b/drivers/scsi/ahci.c
> > @@ -1306,6 +1306,15 @@ static int ahci_init_one (struct pci_dev
> >  		have_msi = 0;
> >  	}
> >  
> > +	{
> > +		u8 orig_pcs, pcs;
> > +		pci_read_config_byte(pdev, 0x92, &orig_pcs);
> > +		pci_write_config_byte(pdev, 0x92, 0xf);
> > +		pci_read_config_byte(pdev, 0x92, &pcs);
> > +		dev_printk(KERN_INFO, &pdev->dev, "pcs 0x%x->0x%x\n",
> > +			   orig_pcs, pcs);
> > +	}
> > +
> >  	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
> >  	if (probe_ent == NULL) {
> >  		rc = -ENOMEM;
> 

