From: "Wolstenholme, Daniel E" <daniel.e.wolstenholme@intel.com>
Subject: RE: [PATCH] Add MSI support to sata_vsc driver
Date: Thu, 24 Aug 2006 13:55:43 -0700
Message-ID: <87840E8EE8A8D240A13F8AA92CAB07D9024C14C3@azsmsx402>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3449 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422652AbWHXUzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2006 16:55:47 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jeremy Higdon <jeremy@sgi.com>, linux-ide@vger.kernel.org

I noticed that several other drivers are calling "pci_intx(pdev, 0)"
when they enable MSI, but not all of them.  Is this something I should
also be doing?

Also, towards the end of the init_one function here, I noticed the
following:
	/* FIXME: check ata_device_add return value */
	ata_device_add(probe_ent);

In the sata_mv.c driver, this return value is checked, and if it's 0,
the driver exits with an error, and disables either msi or calls
pci_intx(pdev, 0) depending on if msi was set.  I checked the return
value of ata_device_add after disconnecting all my SATA drives, and I
still get a return value of 4 (4-port card), so it seems like this isn't
useful on this hardware.  Is ata_device_add supposed to return the
number of actual drives connected, or just the number of physical ports?

Thanks!
Dan

-----Original Message-----
From: Jeff Garzik [mailto:jeff@garzik.org] 
Sent: Wednesday, August 23, 2006 11:56 PM
To: Wolstenholme, Daniel E
Cc: Jeremy Higdon; linux-ide@vger.kernel.org
Subject: Re: [PATCH] Add MSI support to sata_vsc driver

two issues remain:

1) matching pci_disable_msi() is missing

2) as I mentioned previously, do not explicitly initialize irq_flags to 
zero, they are already zero via memset(3).  Only initialize irq_flags 
for the case where pci_enable_msi() fails.
