From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH] shutdown processing
Date: Thu, 16 Feb 2006 10:40:07 -0800
Message-ID: <20060216104007.67cf613f.randy_d_dunlap@linux.intel.com>
References: <20060215114605.1568c8cc.randy_d_dunlap@linux.intel.com>
	<43F43EB9.40406@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <43F43EB9.40406@s5r6.in-berlin.de>
Sender: linux-scsi-owner@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 16 Feb 2006 09:58:33 +0100
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> Randy Dunlap wrote:
> > From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> > 
> > Add ability for SCSI drivers to invoke a shutdown method.
> > This allows drivers to make drives safe for shutdown/poweroff,
> > for example.  Some drives need this to prevent possible problems.
> > 
> > Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Why are you calling these from SCSI? Wouldn't ahci_pci_driver.remove() 
> and piix_pci_driver.remove() be a proper place to perform what you are 
> doing in ata_device_shutdown?

Mostly to have the scsi_device pointers available.
I'll try your suggestion.

> [...]
> >  EXPORT_SYMBOL_GPL(ata_device_suspend);
> >  EXPORT_SYMBOL_GPL(ata_device_resume);
> > +EXPORT_SYMBOL_GPL(ata_device_shutdown);
> >  EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
> >  EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
> > +EXPORT_SYMBOL_GPL(ata_scsi_device_shutdown);
> [...]
> 
> Side note: If you would prepare the host template in libata, you 
> wouldn't need to export these and other symbols. As was AFAIR discussed 
> by other people before, libata could certainly hide scsi_host_template 
> from ATA drivers entirely.

OK.  Thanks for your review and comments.

---
~Randy
