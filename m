From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Add ata_piix's own resume function
Date: Sat, 27 May 2006 08:21:59 +0200
Message-ID: <20060527062159.GB23315@suse.de>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de> <44778F2A.7070708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:31513 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750979AbWE0GWF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 02:22:05 -0400
Content-Disposition: inline
In-Reply-To: <44778F2A.7070708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Fri, May 26 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Fri, May 26 2006, zhao, forrest wrote:
> >>For ata_piix resume operation, it first waits for BUSY bit clear,
> >>then calls ata_device_resume().
> >
> >This has the problem that it introduces scsi specific knowledge into
> >ata_piix, something that is both a violation and a problem because we
> >are moving libata away from scsi. I think the best way to currently do
> >this is to introduce a ata_port_ops hook (pre_resume()?) that waits for
> >busy clear and gets called in ata_device_resume is probably the way to
> >go.
> 
> ata_device_resume() is fine as-is.  Modifying it to resurrect the bus is 
> a gross layering violation.  Resume must be done in this order:
> 
> 	controller -> bus -> device
> 
> Thus, the bus must be resurrected and brought to a known HSM state (bus 
> idle), and then ata_device_resume() will work just fine.
> 
> The proper solution is to modify the pci_driver::resume code path, to 
> resurrect not only the HBA but also the ATA bus.  Currently we have 
> ata_pci_device_{suspend,resume}, whose contents is wholly generic to any 
> random PCI device.
> 
> I would suggest creating pata_pci_device_resume(), which calls 
> ata_pci_device_resume(), and then waits for BSY to clear.

I thought about that, and I don't agree. Waiting for the BSY to clear is
not a pci property, at best I'd consider that even worse than defining a
scsi resume function in ata_piix.

-- 
Jens Axboe

