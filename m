From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] ACPI support for IDE drives
Date: Thu, 9 Mar 2006 15:33:23 -0800
Message-ID: <20060309153323.6be4d1a4.rdunlap@xenotime.net>
References: <440C1E07.4050303@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:59329 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752008AbWCIXbf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Mar 2006 18:31:35 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 15:31:34 -0800
In-Reply-To: <440C1E07.4050303@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: axboe@suse.de, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 06 Mar 2006 12:33:27 +0100 Hannes Reinecke wrote:

> Hi all,
> 
> This patch is adds ACPI support for IDE drives. It is basically a rework
> of Randy Dunlaps patch for libata. And as such it has exactly the same
> issues (namely it breaks layering).
> 
> But, however, there are machines out there who do require ACPI support
> even for standard IDE controllers. So we need to implement something
> here; just telling the users "we're not doing it" is hardly gaining us
> anything.
> And I'm told that Ubuntu has something like this for ages; but of course
> this one is far superior :-).
> 
> As usual, comments etc. welcome.

attachments are difficult to review/comment on.  anyway:

For struct GTM_buffer, I changed __u32 to u32 on request from
Jeff G. and Pavel (in the libata patch).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I don't understand this (latter) comment:

+ * ide_acpi_hwif_get_handle - Get ACPI object handle for a given hwif
+ * @hwif: device to locate
+ *
+ * Retrieves the object handle of a given hwif. According to the ACPI
+ * spec is the hwif a child of the PCI device.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff and Pavel also disagreed with using sscanf(dev->bus_id)
to get the PCI bus:dev.func, so I used their suggestions to modify
the libata code to use the following:

	struct pci_dev *pdev = to_pci_dev(dev);

	bus = pdev->bus->number;
	devnum = PCI_SLOT(pdev->devfn);
	func = PCI_FUNC(pdev->devfn);

HTH and thanks for doing this.
---
~Randy
Please use an email client that implements proper (compliant) threading.
(You know who you are.)
