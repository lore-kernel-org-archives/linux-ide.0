From: Chris Webb <chris.webb@elastichosts.com>
Subject: IO_PAGE_FAULT from SATA card during boot
Date: Sat, 29 Jan 2011 11:24:56 +0000
Message-ID: <20110129112456.GA13204@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.arachsys.com ([91.203.57.7]:43969 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab1A2L5x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Jan 2011 06:57:53 -0500
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1Pj8vI-0003gQ-Gk
	for linux-ide@vger.kernel.org; Sat, 29 Jan 2011 11:24:56 +0000
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have several Supermicro H8DGT-HF motherboards (BIOS version 1.1) with Star
Tech PEXSAT32 PCI Express SATA cards attached, and am seeing an
IO_PAGE_FAULT during boot corresponding to this card:

  IO_PAGE_FAULT device=03:00.1 domain=0x0000 address=0x00000000000403c0 flags=0x0050]

The card later times out when the kernel tries to access the drives:

  ata6.00: qc timeout (cmd 0xec)
  ata12.00: qc timeout (cmd 0xa1)
  ata12.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
  ata12.00: qc timeout (cmd 0xa1)
  ata12.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata12: limiting SATA link speed to 1.5 Gbps
  ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  ata6.00: qc timeout (cmd 0xec)
  ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata6: limiting SATA link speed to 1.5 Gbps
  ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
  ata12.00: qc timeout (cmd 0xa1)
  ata12.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  ata6.00: qc timeout (cmd 0xec)
  ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
  ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 310)

I first saw this with a 2.6.32.25 kernel, but get identical behaviour with
the latest 2.6.37. The kernel config I'm using with 2.6.37 is here:

  http://cdw.me.uk/tmp/sata-fault.config

with a full dmesg and dmidecode output here:

  http://cdw.me.uk/tmp/sata-fault.dmesg
  http://cdw.me.uk/tmp/sata-fault.dmi

Because I initially believed this might be a problem with the ACPI table on the
IOMMU driver, as similar issues have come up with other boards (and very
similar symptoms) recently, I've added amd_iommu_dump to the kernel command
line, so there's dump info in that dmesg. However, Joerg Roedel, the IOMMU
driver maintainer, tells me that the IOMMU ACPI table is fine in this case and
the problem is a different one:

Joerg Roedel <Joerg.Roedel@amd.com> writes:

> The flags indicate that the device tried to read an address which is
> only mapped writable for the device.
> It is at least no BIOS issue, both devices (3:00.0 and 3:00.1) are
> listed in the ACPI table as indicated by these messages:
>                                                         
>         AMD-Vi:   DEV_SELECT                     devid: 03:00.0 flags: 00
>         AMD-Vi:   DEV_SELECT                     devid: 03:00.1 flags: 00
> 
> This looks like a bug in the driver for your SATA add-on card. It
> probably requests a DMA buffer with the wrong direction parameter.

I think both the onboard cards (which work) and the PCI Express card (which
doesn't) use the ahci driver in this case. Any advice would be very gratefully
received!

Best wishes,

Chris.
