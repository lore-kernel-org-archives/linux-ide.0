From: Martin Murray <mmurray@deepthought.org>
Subject: Re: ata_piix hang in 2.6.13-rc5
Date: Mon, 8 Aug 2005 14:03:12 -0400
Message-ID: <20050808180311.GA5878@deepthought.org>
References: <200508081020.48945.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from carbon.deepthought.org ([66.180.175.50]:54198 "EHLO
	carbon.deepthought.org") by vger.kernel.org with ESMTP
	id S932164AbVHHSDO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Aug 2005 14:03:14 -0400
Content-Disposition: inline
In-Reply-To: <200508081020.48945.jesse.barnes@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

For what its worth, I'm seeing the same thing on a 2.6.13-rc5 machine
with sata_nv on an x86_64 machine. I can get around it by using noapic.
I initially assumed it was some ACPI or IRQ issue, but my box hangs at
the exact same place, right after announcing the first device.

Try booting with noapic.

-Martin

* Jesse Barnes <jesse.barnes@intel.com> [050808 13:21]:
> I recently tried to upgrade an ICH5 based box I have to see if a PCI 
> resource allocation bug went away, but was stymied by the fact that 
> recent kernels (2.6.12 from Fedora and 2.6.13-rc5) hang when ata_piix 
> probes for drives.  The last messages I get are these:
> 
> Loading ata_piix.ko module
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
> ata1: SATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC000 irq 177
> ata2: SATA max UDMA/133 cmd 0xC400 ctl 0xC082 bmdma 0xC008 irq 177
> ata1: SATA port has no device.
> scsi0: ata_piix
> ata2: dev 0 ata, max UDMA/133, 312581808 sectors, lba48
> <hang>
> 
> Is this a known problem?  Is there anything in particular I should try?
> 
> Thanks,
> Jesse
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
