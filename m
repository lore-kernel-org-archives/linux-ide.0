From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Patch? 2.6.10-rc3-bk17] ata_pci_remove_one used freed memory
Date: Sat, 05 Feb 2005 23:24:49 -0500
Message-ID: <42059C11.4020501@pobox.com>
References: <200412250820.iBP8K3421640@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57007 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S266080AbVBFEZH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Feb 2005 23:25:07 -0500
In-Reply-To: <200412250820.iBP8K3421640@freya.yggdrasil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-ide@vger.kernel.org

Adam J. Richter wrote:
> 	Attempting to unload a serial ATA driver module gave me a kernel
> memory fault.  I think this problem occurs in all configurations, but
> I should mention that my configuration may be slightly unusual in that
> I configured my BIOS not to do IDE emulation with SATA disks, and I don't
> actually have any disks plugged in.
> 
> 	The problem was that ata_pci_remove_one would call
> scsi_host_put(ap->host), which would free the memory used to hold
> host_set->ports, but host_set->ports was used later in ata_pci_remove_one.
> 
> 	So, the following patch reorders some of the steps in
> ata_pci_remove_one and seems to eliminate the problem, at least to
> the extent that I can unload and reload the module, although I do not
> have a SATA disk handy for testing (I'm expecting one to arrive later
> today).
> 
> 	The patch actually makes the code four lines shorter, although
> two of those lines come from putting an assignement and variable
> declaration in the same line.  Since the patch is a little hard to
> read, here is a description of the edit steps.
> 
> 	1. Moved pci_release_regions() to toward the end of the routine
> to facilitate merging the loops before and after it.  Also, I think that
> calls that are good candidates for consolidating into the bus-level code
> in the future (instead of individual drivers) are best put at the beginning
> or end of the driver routines so that it is clearer if there would be
> problems doing such consolidation.
> 
> 	2. Moved the cacluation of ioaddr into the only if-branch that
> uses it.
> 
> 	3. Moved the call to scsi_host_put to after the code that
> checks ATA_FLAG_NO_LEGACY.

Applied to libata-dev, but #3 looks wrong:  you always release the 
kernel subsystem before releasing the hardware resources.

I won't push it upstream until I ponder this some more (and/or an 
increment patch for this issue appears).

	Jeff



