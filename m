From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Add ata_piix's own resume function
Date: Fri, 26 May 2006 19:28:42 -0400
Message-ID: <44778F2A.7070708@garzik.org>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <20060526230534.GA3640@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53471 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932348AbWEZX2s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 May 2006 19:28:48 -0400
In-Reply-To: <20060526230534.GA3640@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jens Axboe wrote:
> On Fri, May 26 2006, zhao, forrest wrote:
>> For ata_piix resume operation, it first waits for BUSY bit clear,
>> then calls ata_device_resume().
> 
> This has the problem that it introduces scsi specific knowledge into
> ata_piix, something that is both a violation and a problem because we
> are moving libata away from scsi. I think the best way to currently do
> this is to introduce a ata_port_ops hook (pre_resume()?) that waits for
> busy clear and gets called in ata_device_resume is probably the way to
> go.

ata_device_resume() is fine as-is.  Modifying it to resurrect the bus is 
a gross layering violation.  Resume must be done in this order:

	controller -> bus -> device

Thus, the bus must be resurrected and brought to a known HSM state (bus 
idle), and then ata_device_resume() will work just fine.

The proper solution is to modify the pci_driver::resume code path, to 
resurrect not only the HBA but also the ATA bus.  Currently we have 
ata_pci_device_{suspend,resume}, whose contents is wholly generic to any 
random PCI device.

I would suggest creating pata_pci_device_resume(), which calls 
ata_pci_device_resume(), and then waits for BSY to clear.

Similarly, create sata_pci_device_resume(), which calls 
ata_pci_device_resume() then calls sata_phy_resume().  Additionally, for 
select SATA controllers (sata_mv, others?), it may be wise to wait for 
BSY to clear after the SATA phy has been awakened.

You are quite right that ata_piix is an inappropriate place to do all this.

	Jeff



