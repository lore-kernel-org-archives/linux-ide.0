From: Todd Pfaff <pfaff@rhpcs.mcmaster.ca>
Subject: Re: SuperMicro X8DTL-6F motherboard, Intel ICH10 SATA, SiI3726 SATA
 port multiplier
Date: Mon, 22 Feb 2010 16:02:08 -0500 (EST)
Message-ID: <alpine.LMD.2.00.1002221542010.28521@rhpcserv>
References: <alpine.LMD.2.00.1002201350570.16281@rhpcserv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coriana6.CIS.mcmaster.ca ([130.113.128.17]:59068 "EHLO
	coriana6.cis.mcmaster.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0BVVCq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Feb 2010 16:02:46 -0500
Received: from Gorash7.UTS.McMaster.CA (Gorash7.UTS.mcmaster.ca [130.113.196.61])
	by coriana6.cis.mcmaster.ca (8.13.7/8.13.7) with ESMTP id o1ML2VQV018331
	for <linux-ide@vger.kernel.org>; Mon, 22 Feb 2010 16:02:44 -0500 (EST)
Received: from rhpcserv.rhpcs.mcmaster.ca (rhpcserv.rhpcs.mcmaster.ca [130.113.54.154])
	by Gorash7.UTS.McMaster.CA (8.13.7/8.13.7) with ESMTP id o1ML28ZD022970
	for <linux-ide@vger.kernel.org>; Mon, 22 Feb 2010 16:02:08 -0500
In-Reply-To: <alpine.LMD.2.00.1002201350570.16281@rhpcserv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Despite the appearance of partial success in my syslog messages below (ie.
PMP appeared to sorta kinda be trying to work, almost), I've since read
some more that leads me to believe that Intel ICH10 does not support PMP.
And Intel authoritatively says so here:

   http://www.intel.com/Assets/PDF/datasheet/319973.pdf

     page 538, section 14.4.1.1, Bit 17

     Supports Port Multiplier (PMS) - R/WO.  ICH10 does not support port
     multiplier.
     NOTE: This bit must be set to 0.  Port multiplier is not supported by
     ICH10.

So, I give up.  I edited the wiki page here accordingly since it was
wrong:

   http://ata.wiki.kernel.org/index.php/SATA_hardware_features

Todd

On Sat, 20 Feb 2010, Todd Pfaff wrote:

> Please see below for a description of my problem, which I had written
> about to SuperMicro support.  Further to what I've written there, I
> have modified the ahci driver source to force HOST_CAP_PMP as in the
> diff included below.  Now when this modified driver is loaded, it does
> attempt PMP, and it appears to be working except the all but the first
> drive attached to the port multiplier are not recognized.  I've included
> relevant syslog entries below.
>
> Any advice as to what I can try next?
>
> Thanks,
> Todd
>
>
> diff -c /usr/src/linux/drivers/ata/ahci.c{.orig,}
> *** /usr/src/linux/drivers/ata/ahci.c.orig	2010-01-26 02:33:20.000000000 
> -0500
> --- /usr/src/linux/drivers/ata/ahci.c	2010-02-19 17:43:37.973779697 -0500
> ***************
> *** 761,771 ****
> --- 761,773 ----
>  		cap |= HOST_CAP_NCQ;
>  	}
>
> + 	/*
>  	if ((cap & HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_NO_PMP)) {
>  		dev_printk(KERN_INFO, &pdev->dev,
>  			   "controller can't do PMP, turning off CAP_PMP\n");
>  		cap &= ~HOST_CAP_PMP;
>  	}
> + 	*/
>
>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361 
> &&
>  	    port_map != 1) {
> ***************
> *** 2830,2835 ****
> --- 2832,2839 ----
>  	if (hpriv->cap & HOST_CAP_NCQ)
>  		pi.flags |= ATA_FLAG_NCQ;
>
> + 	dev_printk(KERN_INFO, &pdev->dev, "forcing enable of 
> HOST_CAP_PMP\n");
> + 	hpriv->cap |= HOST_CAP_PMP;
>  	if (hpriv->cap & HOST_CAP_PMP)
>  		pi.flags |= ATA_FLAG_PMP;
>
>
>
>
> /var/log/syslog
> ...
> Feb 19 22:03:56 rhpcbkup klogd: SCSI subsystem initialized
> Feb 19 22:03:56 rhpcbkup klogd: libata version 3.00 loaded.
> Feb 19 22:03:56 rhpcbkup klogd: ahci 0000:00:1f.2: version 3.0
> Feb 19 22:03:56 rhpcbkup klogd: ahci 0000:00:1f.2: PCI INT B -> GSI 19 
> (level, low) -> IRQ 19
> Feb 19 22:03:56 rhpcbkup klogd: ahci 0000:00:1f.2: irq 55 for MSI/MSI-X
> Feb 19 22:03:56 rhpcbkup klogd: ahci 0000:00:1f.2: forcing enable of 
> HOST_CAP_PMP
> Feb 19 22:03:56 rhpcbkup klogd: ahci: SSS flag set, parallel bus scan 
> disabled
> Feb 19 22:03:56 rhpcbkup klogd: ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 
> ports 3 Gbps 0x3f impl SATA mode
> Feb 19 22:03:56 rhpcbkup klogd: ahci 0000:00:1f.2: flags: 64bit ncq sntf stag 
> pm led clo pmp pio slum part ems Feb 19 22:03:56 rhpcbkup klogd: ahci 
> 0000:00:1f.2: setting latency timer to 64
> Feb 19 22:03:56 rhpcbkup klogd: scsi0 : ahci
> Feb 19 22:03:56 rhpcbkup klogd: scsi1 : ahci
> Feb 19 22:03:56 rhpcbkup klogd: scsi2 : ahci
> Feb 19 22:03:56 rhpcbkup klogd: scsi3 : ahci
> Feb 19 22:03:56 rhpcbkup klogd: scsi4 : ahci
> Feb 19 22:03:56 rhpcbkup klogd: scsi5 : ahci
> Feb 19 22:03:56 rhpcbkup klogd: ata1: SATA max UDMA/133 abar m2048@0xfacd2000 
> port 0xfacd2100 irq 55
> Feb 19 22:03:56 rhpcbkup klogd: ata2: SATA max UDMA/133 abar m2048@0xfacd2000 
> port 0xfacd2180 irq 55
> Feb 19 22:03:56 rhpcbkup klogd: ata3: SATA max UDMA/133 abar m2048@0xfacd2000 
> port 0xfacd2200 irq 55
> Feb 19 22:03:56 rhpcbkup klogd: ata4: SATA max UDMA/133 abar m2048@0xfacd2000 
> port 0xfacd2280 irq 55
> Feb 19 22:03:56 rhpcbkup klogd: ata5: SATA max UDMA/133 abar m2048@0xfacd2000 
> port 0xfacd2300 irq 55
> Feb 19 22:03:56 rhpcbkup klogd: ata6: SATA max UDMA/133 abar m2048@0xfacd2000 
> port 0xfacd2380 irq 55
> Feb 19 22:03:56 rhpcbkup klogd: ata1: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata1.00: ATA-7: ST3750640AS, 3.AAE, max 
> UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata1.00: 1465149168 sectors, multi 0: LBA48 
> NCQ (depth 31/32)
> Feb 19 22:03:56 rhpcbkup klogd: ata1.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: scsi 0:0:0:0: Direct-Access     ATA 
> ST3750640AS      3.AA PQ: 0 ANSI: 5
> Feb 19 22:03:56 rhpcbkup klogd: sd 0:0:0:0: [sda] 1465149168 512-byte logical 
> blocks: (750 GB/698 GiB)
> Feb 19 22:03:56 rhpcbkup klogd: sd 0:0:0:0: [sda] Write Protect is off
> Feb 19 22:03:56 rhpcbkup klogd: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> Feb 19 22:03:56 rhpcbkup klogd: sd 0:0:0:0: [sda] Write cache: enabled, read 
> cache: enabled, doesn't support DPO or FUA
> Feb 19 22:03:56 rhpcbkup klogd:  sda: sda1 sda2 sda3
> Feb 19 22:03:56 rhpcbkup klogd: sd 0:0:0:0: [sda] Attached SCSI disk
> Feb 19 22:03:56 rhpcbkup klogd: ata2: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: Port Multiplier 1.1, 0x1095:0x3726 
> r23, 6 ports, feat 0x1/0x9
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: ATA-8: ST31000528AS, CC38, max 
> UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: 1953525168 sectors, multi 0: LBA48 
> NCQ (depth 31/32)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: failed to recover link after 3 
> tries, disabling
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: failed to recover link after 3 
> tries, disabling
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: failed to recover link after 3 
> tries, disabling
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: failed to IDENTIFY (I/O error, 
> err_mask=0x100)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: failed to recover link after 3 
> tries, disabling
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.15: SATA link up 3.0 Gbps (SStatus 123 
> SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: SATA link up 3.0 Gbps (SStatus 123 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: hard resetting link
> Feb 19 22:03:56 rhpcbkup klogd: ata2.05: SATA link up 1.5 Gbps (SStatus 113 
> SControl 320)
> Feb 19 22:03:56 rhpcbkup klogd: ata2.00: configured for UDMA/133
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: exception Emask 0x2 SAct 0x0 SErr 
> 0x0 action 0x6 t4
> Feb 19 22:03:56 rhpcbkup klogd: ata2.01: incorrect PMP, incorrect PMP, 
> incorrect PMP
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: exception Emask 0x2 SAct 0x0 SErr 
> 0x0 action 0x6 t4
> Feb 19 22:03:56 rhpcbkup klogd: ata2.02: incorrect PMP, incorrect PMP, 
> incorrect PMP
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: exception Emask 0x2 SAct 0x0 SErr 
> 0x0 action 0x6 t4
> Feb 19 22:03:56 rhpcbkup klogd: ata2.03: incorrect PMP, incorrect PMP, 
> incorrect PMP
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: exception Emask 0x2 SAct 0x0 SErr 
> 0x0 action 0x6 t4
> Feb 19 22:03:56 rhpcbkup klogd: ata2.04: incorrect PMP, incorrect PMP, 
> incorrect PMP
> Feb 19 22:03:56 rhpcbkup klogd: ata2: EH complete
> Feb 19 22:03:56 rhpcbkup klogd: scsi 1:0:0:0: Direct-Access     ATA 
> ST31000528AS     CC38 PQ: 0 ANSI: 5
> Feb 19 22:03:56 rhpcbkup klogd: sd 1:0:0:0: [sdb] 1953525168 512-byte logical 
> blocks: (1.00 TB/931 GiB)
> Feb 19 22:03:56 rhpcbkup klogd: sd 1:0:0:0: [sdb] Write Protect is off
> Feb 19 22:03:56 rhpcbkup klogd: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> Feb 19 22:03:56 rhpcbkup klogd: sd 1:0:0:0: [sdb] Write cache: enabled, read 
> cache: enabled, doesn't support DPO or FUA
> Feb 19 22:03:56 rhpcbkup klogd:  sdb: unknown partition table
> Feb 19 22:03:56 rhpcbkup klogd: sd 1:0:0:0: [sdb] Attached SCSI disk
> Feb 19 22:03:56 rhpcbkup klogd: ata3: SATA link down (SStatus 0 SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata4: SATA link down (SStatus 0 SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata5: SATA link down (SStatus 0 SControl 300)
> Feb 19 22:03:56 rhpcbkup klogd: ata6: SATA link down (SStatus 0 SControl 300)
>
>
>
> On Fri, 19 Feb 2010, Technical Support wrote:
>
>> You need to ask the chassis/backplane manufacturer which controller
>> is compatible with the Silicon Image SiI3726 chip.
>> 
>> For example, Super Micro also has some LSI chip expander chassis/backplane.
>> Only some controllers are compatible.
>> 
>> JL
>> 
>> -----Original Message-----
>> From: Todd Pfaff [mailto:pfaff@rhpcs.mcmaster.ca]
>> Sent: Friday, February 19, 2010 6:38 AM
>> To: Technical Support
>> Cc: Todd Pfaff
>> Subject: X8DTL-6F motherboard, Intel ICH10 SATA, and port multiplier
>> 
>> Dear SuperMicro Support,
>> 
>> I have a SuperMicro X8DTL-6F motherboard and I'm trying to use the onboard
>> Intel ICH10 SATA ports attached to a SATA port multiplier.
>> 
>> The SATA port multipliers are based on the Silicon Image SiI3726 chip and
>> have five SATA drive ports.
>> 
>> In the motherboard BIOS settings, I've configured SATA as AHCI.
>> 
>> When booting the system, the BIOS only sees the first drive on the port
>> multiplier.  Also, if I have fewer than five drives attached to the port
>> multiplier, the boot hangs during drive detection and never completes.
>> 
>> Next I boot linux, and linux also sees only the first drive on the
>> five-drive port multiplier.  Here are some details seen from linux:
>> 
>> - linux kernel version 2.6.31
>> 
>> - output from lspci
>> 
>> 00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA
>> AHCI Controller
>> 
>> - from /var/log/syslog
>> 
>> Feb 18 20:24:39 rhpcbkup klogd: ahci 0000:00:1f.2: AHCI 0001.0200 32 slots
>> 6 ports 3 Gbps 0x3f impl SATA mode
>> Feb 18 20:24:39 rhpcbkup klogd: ahci 0000:00:1f.2: flags: 64bit ncq sntf
>> stag pm led clo pio slum part ems
>> Feb 18 20:24:39 rhpcbkup klogd: ahci 0000:00:1f.2: setting latency timer
>> to 64
>> 
>> 
>> The second syslog line above that shows "flags" that, if I understand
>> correctly, are discovered by the linux ahci driver when it probes the
>> BIOS.  There should be a "pmp" flag shown above if the ahci driver
>> detects that the SATA controller has port multiplier support using either
>> command-based or FIS-based SATA PM switching.
>> 
>> I've read that this Intel ICH10 SATA controller should have SATA PM
>> support.  So what I'm wondering is whether this should be available
>> on this particular SuperMicro motherboard, and whether there's anything
>> I can do to make this work from the BIOS and linux.
>> 
>> Thanks,
>> --
>> Todd Pfaff <pfaff@mcmaster.ca>
>> http://www.rhpcs.mcmaster.ca/
>> 
>> 
>> 
>
>
