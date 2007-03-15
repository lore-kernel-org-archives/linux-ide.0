From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: CONFIG_IBM_BAY
Date: Thu, 15 Mar 2007 12:50:37 -0700
Message-ID: <20070315125037.3e82e0c4.kristen.c.accardi@intel.com>
References: <11736588493609-git-send-email-hmh@hmh.eng.br>
	<20070315031015.GA6292@khazad-dum.debian.net>
	<20070315031251.GB6292@khazad-dum.debian.net>
	<200703150206.05811.lenb@kernel.org>
	<20070315133900.GC26862@khazad-dum.debian.net>
	<20070315080644.c73db24a.kristen.c.accardi@intel.com>
	<20070315175505.GB6596@khazad-dum.debian.net>
	<20070315110156.09e80b99.kristen.c.accardi@intel.com>
	<20070315193123.GB14394@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13115 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933570AbXCOTxc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Mar 2007 15:53:32 -0400
In-Reply-To: <20070315193123.GB14394@khazad-dum.debian.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-ide@vger.kernel.org

On Thu, 15 Mar 2007 16:31:24 -0300
Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:

> On Thu, 15 Mar 2007, Kristen Carlson Accardi wrote:
> > I think we should focus our efforts on a generic (non platform specific) 
> > solution that can work across many laptops (i.e. ACPI_BAY).  Let's make
> 
> Agreed, as long as that doesn't mean we have to pollute ACPI_BAY with a
> truckload of crap required to deal with vendor/model-specific idioticities.
> I hope ThinkPads are not like that, but I am not sure, and I'd feel bad
> about adding a lot of quirks to ACPI_BAY because of ThinkPad weirdness :p

So for the dock driver I supplied an interface to allow interested subsystems
to register handlers to be called by the dock driver during dock events.
This allowed me to let individual subsystems do whatever unique things they
needed to do when the dock was either inserted or removed.  For the bay
driver, we could actually provide a mechanism to allow platform specific
drivers to take advantage of the generic stuff, but then have the bay driver
call a registered handler to do some weird specific thing - this way at
least we are sharing the bulk of our code and weird stuff can be contained
somewhere else.

> 
> Otherwise, it would be best to allow model-specific modules to provide extra
> functionality for ACPI_BAY, that way we have generic code, and we can
> contain the braindamage to where it belongs (e.g. in ibm-acpi).
> 
> > so if you do have time to work on this, that would be great.  I am happy 
> > to test on the set of laptops I've got.
> 
> I will see what I can do.  My "first approach" at a requirements list for a
> proper bay module are as follows:
> 
> 1. It will handle all device types (ATAPI, PATA, SATA, batteries);
> 
> 2. It will do the right thing on plug and unplug.  This means telling the
> rest of the kernel to disable the device in the bay, for example.  Right now
> we shutdown one end of the PATA/SATA link on ThinkPads eletrically, and
> leave libata to scream blood murder until it disables its end due to too
> many retries, for example;

Personally - I think tighter integration to libata here would be beneficial.
Once libata acpi support is straightened out, if we can store acpi handles
associated with libata devices, we can perhaps have a mechanism of obtaining
ata_device structs so that we can have a nice way of telling libata to 
delete devices etc.  I am hoping libata-acpi will be straightened out for
2.6.22.
