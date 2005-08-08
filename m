From: Jesse Barnes <jesse.barnes@intel.com>
Subject: ata_piix hang in 2.6.13-rc5
Date: Mon, 8 Aug 2005 10:20:48 -0700
Message-ID: <200508081020.48945.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr24.intel.com ([143.183.121.16]:17385 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932122AbVHHRVC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Aug 2005 13:21:02 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

I recently tried to upgrade an ICH5 based box I have to see if a PCI 
resource allocation bug went away, but was stymied by the fact that 
recent kernels (2.6.12 from Fedora and 2.6.13-rc5) hang when ata_piix 
probes for drives.  The last messages I get are these:

Loading ata_piix.ko module
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 177
ata1: SATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC000 irq 177
ata2: SATA max UDMA/133 cmd 0xC400 ctl 0xC082 bmdma 0xC008 irq 177
ata1: SATA port has no device.
scsi0: ata_piix
ata2: dev 0 ata, max UDMA/133, 312581808 sectors, lba48
<hang>

Is this a known problem?  Is there anything in particular I should try?

Thanks,
Jesse

