From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
Date: 20 Jan 2014 18:35:43 -0500
Message-ID: <20140120233543.15159.qmail@science.horizon.com>
References: <CAJtEV7ZsM2YHHETRGNwXnGi7uq0mJen73i-Yp3EXoDrnni=o=g@mail.gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:35506 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753578AbaATXfr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jan 2014 18:35:47 -0500
In-Reply-To: <CAJtEV7ZsM2YHHETRGNwXnGi7uq0mJen73i-Yp3EXoDrnni=o=g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: acooks@gmail.com, linux@horizon.com
Cc: iommu@lists.linux-foundation.org, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org

I'm looking over the bug reports, and I'm trying to understand why you
need two mechanisms.  You have one table (pci_dev_dma_source_map)
that maps one devfn to a secondary one, and a second table
(pci_dev_dma_multi_source_map) that gives a 2-bit bitmap of function
numbers.

But as I understand it, all the Marvell devices listed there always have
a devfn of 00.0, so you could just move them to the first table with a
mapping to 00.1.

If they also have device/function 00.1 using a requester ID of 00.0
you could add a second entry.

The only time you'd need a bitmap would be if the device ended up on
function 2 or higher and still used functions 0 and 1 in request IDs.


Now, unfortunately this does not cover the phantom functions case, but
that could be done with separate code.


The other question is when to do the lookup.  I don't know how often
IOMMU mapping is done, and if linear search through a list of PCI devices
would be a performance problem.  It would be nicer to have a standard
PCI fixup done once which sets a flag in the pci_dev to either note the
actual secondary devfn, or set a flag to trigger the secondary lookup
only on the devices that need it.

There's certainly room in the pci_dev for a second 8-bit devfn field,
Let me work up a patch based on that...
