From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Tue, 3 Jan 2006 20:03:47 +0100
Message-ID: <20060103190346.GY2772@suse.de>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com> <87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp> <20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com> <20060103172649.GV2772@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:48426 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750908AbWACTCM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2006 14:02:12 -0500
Content-Disposition: inline
In-Reply-To: <20060103172649.GV2772@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com

On Tue, Jan 03 2006, Jens Axboe wrote:
> On Tue, Jan 03 2006, Randy Dunlap wrote:
> > On 30 Dec 2005 17:36:44 +0900
> > Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp> wrote:
> > 
> > > I tested kernel 2.6.15-rc7 with your patch applied on my ThinkPad X41.
> > > While booting, it locks up after printing
> > > 
> > >     ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
> > >     ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
> > >     ata1(0): applying bridge limits
> > >     ata1: dev 0 configured for UDMA/100
> > > 
> > > If I select CONFIG_SCSI_SATA_AHCI, then the kernel emits an oops and
> > > panics during boot.
> > 
> > Hi,
> > 
> > Can you capture the kernel oops & panic messages?
> 
> I think I triggered the same oops on my T43, I'll try applying your sata
> acpi patches and see if it reproduces.

It's crashing here:

                acpi_os_free((void *)gtf_address);

in ata_acpi_exec_tfs(), looks like it's trying to free an uninitialized
gtf_address. Setting to 0 and doing:

        if (gtf_address)
                acpi_os_free((void *)gtf_address);

fixes it. Probably due to a nasty warning that it spews on boot:

ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18C0 irq 14
ata1: dev 0 cfg 49:2f00 82:346b 83:7d09 84:6003 85:3469 86:3c09 87:6003
88:203f
ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
ata_acpi_exec_tfs: call get_GTF, ix=0
ata_acpi_exec_tfs: call set_taskfiles, ix=0
do_drive_set_taskfiles: unexpected GTF length (-271707516)
scsi0 : ata_piix
  Vendor: ATA       Model: ST980825A         Rev: 3.04
  Type:   Direct-Access                      ANSI SCSI revision: 05

note the 'unexpected GTF length' message. Doing a suspend/resume cycle
doesn't trigger that error:

[...]
eth1: Coming out of suspend...
ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 23
ata1: dev 0 configured for UDMA/100
ata_acpi_exec_tfs: call get_GTF, ix=0
ata_acpi_exec_tfs: call set_taskfiles, ix=0
Restarting tasks... done
[...]

-- 
Jens Axboe

