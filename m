From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/2] libata: implement to get tf's from _GTF and execute
 them
Date: Tue, 8 Aug 2006 22:18:03 -0700
Message-ID: <20060808221803.162e14e7.rdunlap@xenotime.net>
References: <1153899372.4957.61.camel@forrest26.sh.intel.com>
	<44D96744.4030604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:8581 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965053AbWHIFPY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Aug 2006 01:15:24 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 8 Aug 2006 22:15:19 -0700
In-Reply-To: <44D96744.4030604@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "zhao, forrest" <forrest.zhao@intel.com>, htejun@gmail.com, linux-ide@vger.kernel.org

On Wed, 09 Aug 2006 00:40:36 -0400 Jeff Garzik wrote:

> zhao, forrest wrote:
> > 1 update the Makefile, Kconfig, kernel-parameters.txt, and add
> > definition of noacpi
> > 2 implement core SATA-ACPI functions
> > 3 implement the functions for getting tf's from _GTF and executing them
> > 4 invoke ata_acpi_exec_tfs in appropriate places
> > 
> > 
> > Signed-off-by: Zhao Forrest <forrest.zhao@intel.com>
> 
> It sounds like Randy Dunlap already provided most of the necessary feedback.
> 
> My comments will likely echo some of his.
> 
> 
> > diff --git a/drivers/scsi/libata-acpi.c b/drivers/scsi/libata-acpi.c
> > new file mode 100644
> > index 0000000..cf7eeb1
> > --- /dev/null
> > +++ b/drivers/scsi/libata-acpi.c
> > @@ -0,0 +1,654 @@
> > +/*
> > + * libata-acpi.c
> > + * Provides ACPI support for PATA/SATA.
> > + *
> > + * Copyright (C) 2005 Intel Corp.
> > + * Copyright (C) 2005 Randy Dunlap
> 
> optional: consider updating copyright for 2006?
> 
> 
> > +#include <linux/ata.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <acpi/acpi.h>
> > +#include "scsi.h"
> > +#include <linux/libata.h>
> > +#include <linux/pci.h>
> > +#include "libata.h"
> > +
> > +#include <acpi/acpi_bus.h>
> > +#include <acpi/acnames.h>
> > +#include <acpi/acnamesp.h>
> > +#include <acpi/acparser.h>
> > +#include <acpi/acexcep.h>
> > +#include <acpi/acmacros.h>
> > +#include <acpi/actypes.h>
> > +
> > +#define SATA_ROOT_PORT(x)	(((x) >> 16) & 0xffff)
> > +#define SATA_PORT_NUMBER(x)	((x) & 0xffff)	/* or NO_PORT_MULT */
> > +#define NO_PORT_MULT		0xffff
> > +#define SATA_ADR_RSVD		0xffffffff
> > +
> > +#define REGS_PER_GTF		7
> > +struct taskfile_array {
> > +	u8	tfa[REGS_PER_GTF];	/* regs. 0x1f1 - 0x1f7 */
> > +};
> > +
> > +struct GTM_buffer {
> > +	__u32	PIO_speed0;
> > +	__u32	DMA_speed0;
> > +	__u32	PIO_speed1;
> > +	__u32	DMA_speed1;
> > +	__u32	GTM_flags;
> > +};
> > +
> > +#define DEBUGGING	1
> > +/* note: adds function name and KERN_DEBUG */
> > +#ifdef DEBUGGING
> > +#define DEBPRINT(fmt, args...)	\
> > +		printk(KERN_DEBUG "%s: " fmt, __FUNCTION__, ## args)
> > +#else
> > +#define DEBPRINT(fmt, args...)	do {} while (0)
> > +#endif	/* DEBUGGING */
> 
> should use normal libata debug/message printing
> 
> 
> > +/**
> > + * sata_get_dev_handle - finds acpi_handle and PCI device.function
> > + * @dev: device to locate
> > + * @handle: returned acpi_handle for @dev
> > + * @pcidevfn: return PCI device.func for @dev
> > + *
> > + * This function is somewhat SATA-specific.  Or at least the
> > + * IDE and SCSI versions of this function are different,
> > + * so it's not entirely generic code.
> > + *
> > + * Returns 0 on success, <0 on error.
> > + */
> > +static int sata_get_dev_handle(struct device *dev, acpi_handle *handle,
> > +					acpi_integer *pcidevfn)
> > +{
> > +	struct pci_dev	*pci_dev;
> > +	acpi_integer	addr;
> > +
> > +	pci_dev = to_pci_dev(dev);	/* NOTE: PCI-specific */
> > +	/* Please refer to the ACPI spec for the syntax of _ADR. */
> > +	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
> > +	*pcidevfn = addr;
> > +	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
> > +	printk(KERN_DEBUG "%s: SATA dev addr=0x%llx, handle=0x%p\n",
> > +		__FUNCTION__, (unsigned long long)addr, *handle);
> 
> should not unconditionally print out debug info.  KERN_DEBUG messages 
> still fill the dmesg(1) ring buffer.
> 
> 
> > +	if (!*handle)
> > +		return -ENODEV;
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pata_get_dev_handle - finds acpi_handle and PCI device.function
> > + * @dev: device to locate
> > + * @handle: returned acpi_handle for @dev
> > + * @pcidevfn: return PCI device.func for @dev
> > + *
> > + * The PATA and SATA versions of this function are different.
> > + *
> > + * Returns 0 on success, <0 on error.
> > + */
> > +static int pata_get_dev_handle(struct device *dev, acpi_handle *handle,
> > +					acpi_integer *pcidevfn)
> > +{
> > +	unsigned int domain, bus, devnum, func;
> > +	acpi_integer addr;
> > +	acpi_handle dev_handle, parent_handle;
> > +	int scanned;
> > +	struct acpi_buffer buffer = {.length = ACPI_ALLOCATE_BUFFER,
> > +					.pointer = NULL};
> > +	acpi_status status;
> > +	struct acpi_device_info	*dinfo = NULL;
> > +	int ret = -ENODEV;
> > +
> > +	printk(KERN_DEBUG "%s: ENTER: dev->bus_id='%s'\n",
> > +		__FUNCTION__,  dev->bus_id);
> 
> ditto
> 
> 
> > +	if ((scanned = sscanf(dev->bus_id, "%x:%x:%x.%x",
> > +			&domain, &bus, &devnum, &func)) != 4) {
> > +		printk("sscanf ret. %d\n", scanned);
> > +		goto err;
> > +	}
> > +
> > +	dev_handle = DEVICE_ACPI_HANDLE(dev);
> > +	parent_handle = DEVICE_ACPI_HANDLE(dev->parent);
> > +
> > +	status = acpi_get_object_info(parent_handle, &buffer);
> > +	if (ACPI_FAILURE(status)) {
> > +		printk("get_object_info for parent failed\n");
> > +		goto err;
> > +	}
> > +	dinfo = buffer.pointer;
> > +	if (dinfo && (dinfo->valid & ACPI_VALID_ADR) &&
> > +	    dinfo->address == bus) {
> > +		/* ACPI spec for _ADR for PCI bus: */
> > +		addr = (acpi_integer)(devnum << 16 | func);
> > +		*pcidevfn = addr;
> > +		*handle = dev_handle;
> > +	} else {
> > +		printk("get_object_info for parent has wrong "
> > +			" bus: %llu, should be %d\n",
> > +			dinfo ? (unsigned long long)dinfo->address : -1ULL,
> > +			bus);
> 
> printk needs improvement.  Add KERN_ERR, and ata_msg_err() test.
> 
> 
> > +		goto err;
> > +	}
> > +
> > +	printk(KERN_DEBUG "%s: dev_handle: 0x%p, parent_handle: 0x%p\n",
> > +		__FUNCTION__, dev_handle, parent_handle);
> > +	printk(KERN_DEBUG
> > +		"%s: for dev=0x%x.%x, addr=0x%llx, parent=0x%p, *handle=0x%p\n",
> > +		__FUNCTION__, devnum, func, (unsigned long long)addr,
> > +		dev->parent, *handle);
> 
> should not unconditionally print debug info in a production system

Agreed.  Lots of these are purely debugging info and should not
be here long-term.

---
~Randy
