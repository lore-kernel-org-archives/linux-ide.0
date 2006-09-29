From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 1/2] libata: _GTF support
Date: Fri, 29 Sep 2006 10:03:00 -0700
Message-ID: <20060929100300.ff76a22d.kristen.c.accardi@intel.com>
References: <20060928182211.076258000@localhost.localdomain>
	<20060928112901.62ee8eba.kristen.c.accardi@intel.com>
	<20060929020707.GA22082@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42250 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1161747AbWI2RDl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Sep 2006 13:03:41 -0400
In-Reply-To: <20060929020707.GA22082@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com, rdunlap@xenotime.net

On Fri, 29 Sep 2006 03:07:07 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Thu, Sep 28, 2006 at 11:29:01AM -0700, Kristen Carlson Accardi wrote:
> 
> I mentioned this to Randy a while back, but I can't remember what sort 
> of resolution we came to. In any case:
> 
> > + * sata_get_dev_handle - finds acpi_handle and PCI device.function
> 
> I'm a bit uncomfortable that we seem to have two quite different ways of 
> accomplishing much the same thing. On the PCI bus, we have a callback 
> that gets triggered whenever a new PCI device is attached. At that 
> point, we look for the associated ACPI object and put a pointer to that 
> in the device structure. Then, whenever we want to make an ACPI call, we 
> can simply refer to that.
> 
> This implementation seems to reimplement much of the same lookup code, 
> but makes it libata specific. Wouldn't it be cleaner to implement it in 
> a similar way to PCI? The only real downside is that you need to add a 
> callback in the ata bus code. drivers/pci/pci-acpi.c/pci_acpi_init is 
> the sort of thing required.
> 
> (Thinking ahead, would that make it easier to maintain links in sysfs 
> between devices and acpi objects?)
> 
> -- 
> Matthew Garrett | mjg59@srcf.ucam.org

This makes sense to me.  I'm happy to put together some patches for 
commenting on if people think this is a good way to go.  It would be
much cleaner in my opinion and we could get rid of a good chunk of code.

Kristen
