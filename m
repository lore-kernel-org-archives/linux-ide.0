From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Regression with 0b9e2988ab22 ("ahci: use pci_alloc_irq_vectors")
Date: Fri, 21 Oct 2016 16:09:48 +0300
Message-ID: <9d293889-3215-403b-bdf9-c24b684f18f0@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi

SATA stopped working on Intel SoCs that have single SATA port after 
v4.9-rc1:

[    8.705008] ata1.00: qc timeout (cmd 0x27)
[    8.709164] ata1.00: failed to read native max address (err_mask=0x4)
[    8.715557] ata1.00: HPA support seems broken, skipping HPA handling
[    9.029754] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   14.337028] ata1.00: qc timeout (cmd 0xef)
[   14.341185] ata1.00: failed to enable AA (error_mask=0x4)
[   14.346557] ata1: limiting SATA link speed to 3.0 Gbps
[   14.666922] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   14.684359] ata1.00: ATA-9: INTEL SSDSC2BW240A4, DC32, max UDMA/133
[   14.690650] ata1.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   19.969116] ata1.00: qc timeout (cmd 0x47)
[   19.973307] ata1.00: READ LOG DMA EXT failed, trying unqueued
[   19.979026] ata1.00: failed to set xfermode (err_mask=0x40)
[   19.984559] ata1.00: disabled
[   19.987527] ata1: hard resetting link
[   20.306943] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   20.313163] ata1: EH complete

I bisected this into commit 0b9e2988ab22 ("ahci: use 
pci_alloc_irq_vectors").

I did some debugging on a few machines (Skylake, Broxton, Kaby Lake and 
Bay Trail based) in our lab.

Before 0b9e2988ab22:
- All of those machines are using MSI for AHCI
- Number of SATA ports 1-4
- pci_msi_vec_count() returns 1 for all machines

After 0b9e2988ab22:
- SATA stopped working on machines with single port:
   * pci_alloc_irq_vectors() returns 1
   * Allocates the same MSI irq number as before but handler name
     is (null)
- With >1 ports AHCI defaults now to IO-APIC but continues working
   * pci_alloc_irq_vectors() returns -EINVAL from
     __pci_enable_msi_range() due if (nvec < minvec) test.

-- 
Jarkko
