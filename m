From: Jeff Garzik <jeff@garzik.org>
Subject: Implementing NVMHCI...
Date: Sat, 11 Apr 2009 13:33:47 -0400
Message-ID: <49E0D47B.9070205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43243 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbZDKRdw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Apr 2009 13:33:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>


Has anybody looked into working on NVMHCI support?  It is a new 
controller + new command set for direct interaction with non-volatile 
memory devices:

	http://download.intel.com/standards/nvmhci/spec.pdf

Although NVMHCI is nice from a hardware design perspective, it is a bit 
problematic for Linux because

	* NVMHCI might be implemented as part of an AHCI controller's
	  register set, much like how Marvell's AHCI clones implement
	  a PATA port: with wholly different per-port registers
	  and DMA data structures, buried inside the standard AHCI
	  per-port interrupt dispatch mechanism.

	  Or, NVMHCI might be implemented as its own PCI device,
	  wholly independent from the AHCI PCI device.

	  The per-port registers and DMA data structure remain the same,
	  whether or not it is embedded within AHCI or not.

	* NVMHCI introduces a brand new command set, completely
	  incompatible with ATA or SCSI.  Presumably it is tuned
	  specifically for non-volatile memory.

	* The sector size can vary wildly from device to device.  There
	  is no 512-byte legacy to deal with, for a brand new
	  command set.  We should handle this OK, but......  who knows
	  until you try.

	  The spec describes the sector size as
	  "512, 1k, 2k, 4k, 8k, etc."   It will be interesting to reach
	  "etc" territory.

Here is my initial idea:

- Move 95% of ahci.c into libahci.c.

   This will make implementation of AHCI-and-more devices like
   NVMHCI (AHCI 1.3) and Marvell much easier, while avoiding
   the cost of NVMHCI or Marvell support, for those users without
   such hardware.

- ahci.c becomes a tiny stub with a pci_device_id match table,
   calling functions in libahci.c.

- I can move my libata-dev.git#mv-ahci-pata work, recently refreshed,
   into mv-ahci.c.

- nvmhci.c implements the NVMHCI controller standard.  Maybe referenced
   from ahci.c, or used standalone.

- nvmhci-blk.c implements a block device for NVMHCI-attached devices,
   using the new NVMHCI command set.

   With a brand new command set, might as well avoid SCSI completely IMO,
   and create a brand new block device.

Open questions are...

1) When will we see hardware?  This is a feature newly introduced in
    AHCI 1.3.  AHCI 1.3 spec is public, but I have not seen any machines
    yet. http://download.intel.com/technology/serialata/pdf/rev1_3.pdf

    My ICH10 box uses AHCI 1.2.  dmesg | grep '^ahci'

> ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
> ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems 


2) Has anyone else started working on this?  All relevant specs are 
public on intel.com.


3) Are there major objections to doing this as a native block device (as 
opposed to faking SCSI, for example...) ?


Thanks,

	Jeff (engaging in some light Saturday reading...)




