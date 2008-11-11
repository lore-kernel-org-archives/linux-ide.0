From: Tejun Heo <tj@kernel.org>
Subject: Re: Port multiplier resets
Date: Tue, 11 Nov 2008 18:06:40 +0900
Message-ID: <49194B20.8000209@kernel.org>
References: <490DC300.40703@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59926 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752180AbYKKJGq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Nov 2008 04:06:46 -0500
In-Reply-To: <490DC300.40703@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: linux-ide@vger.kernel.org

Yan Seiner wrote:
> I'm seeing errors on a new port multiplier install.  The mobo has a
> J-Micron SATA controller: JMicron Technologies, Inc.  JMicron
> 20360/20363 AHCI Controller (rev 03) The port multiplier has a SIL
> 3726 chipset.  AFAICT, this is a supported comnbination.  The kernel
> recognizes the chipset.  The system has an adaptec SCSI controller
> w/ 2 15K SCSI drives, 6 internal SATA drives, and 3 external SATA
> drives using the port multiplier. Because of a broken bios (ARGH!) I
> have to power up the external drives after the system scans the SCSI
> bus.  This seems to cause no problems.  Here's a log of a recent
> boot (scroll down for the error I see after the system is booted):
> 
> Nov  2 05:26:07 selene kernel: [   28.691524] ata8: SATA max UDMA/133 abar m8192@0xfdcfe000 port 0xfdcfe180 irq 16
> Nov  2 05:26:07 selene kernel: [   34.104580] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> Nov  2 05:26:07 selene kernel: [   34.104580] ata8.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
> Nov  2 05:26:07 selene kernel: [   34.104580] ata8.00: hard resetting link
> Nov  2 05:26:07 selene kernel: [   34.425000] ata8.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> Nov  2 05:26:07 selene kernel: [   34.425003] ata8.01: hard resetting link
> Nov  2 05:26:07 selene kernel: [   35.001232] ata8.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> Nov  2 05:26:07 selene kernel: [   35.001234] ata8.02: hard resetting link
> Nov  2 05:26:07 selene kernel: [   35.321389] ata8.02: SATA link down (SStatus 0 SControl 320)
> Nov  2 05:26:07 selene kernel: [   35.321419] ata8.03: hard resetting link
> Nov  2 05:26:07 selene kernel: [   35.869739] ata8.03: SATA link down (SStatus 0 SControl 320)
> Nov  2 05:26:07 selene kernel: [   35.869769] ata8.04: hard resetting link
> Nov  2 05:26:07 selene kernel: [   36.621491] ata8.04: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> Nov  2 05:26:07 selene kernel: [   36.621493] ata8.05: hard resetting link
> Nov  2 05:26:07 selene kernel: [   36.941025] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> Nov  2 05:26:07 selene kernel: [   36.942522] ata8.00: ATA-8: ST31000340AS, SD15, max UDMA/133
> Nov  2 05:26:07 selene kernel: [   36.942525] ata8.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> Nov  2 05:26:07 selene kernel: [   36.944479] ata8.00: configured for UDMA/133
> Nov  2 05:26:07 selene kernel: [   53.613888] ata8.01: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
> Nov  2 05:26:07 selene kernel: [   53.613888] ata8.04: failed to IDENTIFY (I/O error, err_mask=0x100)
> Nov  2 05:26:07 selene kernel: [   53.613888] ata8: failed to recover some devices, retrying in 5 secs
> Nov  2 05:26:07 selene kernel: [   61.420677] ata8.01: hard resetting link
> Nov  2 05:26:07 selene kernel: [   66.420763] ata8.15: qc timeout (cmd 0xe4)
> Nov  2 05:26:07 selene kernel: [   66.420770] ata8.01: failed to read SCR 2 (Emask=0x4)
> Nov  2 05:26:07 selene kernel: [   66.420773] ata8.01: failed to read SCR 2 (Emask=0x40)
> Nov  2 05:26:07 selene kernel: [   66.420775] ata8.01: COMRESET failed (errno=-5)
> Nov  2 05:26:07 selene kernel: [   66.420804] ata8.01: failed to read SCR 0 (Emask=0x40)
> Nov  2 05:26:07 selene kernel: [   66.420806] ata8.01: reset failed, giving up
> Nov  2 05:26:07 selene kernel: [   66.420835] ata8.15: hard resetting link
> Nov  2 05:26:07 selene kernel: [   68.284883] ata8.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> Nov  2 05:26:07 selene kernel: [   68.285116] ata8.00: hard resetting link
> Nov  2 05:26:07 selene kernel: [   68.604947] ata8.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> Nov  2 05:26:07 selene kernel: [   68.604949] ata8.01: hard resetting link
> Nov  2 05:26:07 selene kernel: [   69.329438] ata8.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> Nov  2 05:26:07 selene kernel: [   69.329440] ata8.02: hard resetting link
> Nov  2 05:26:07 selene kernel: [   69.649777] ata8.02: SATA link down (SStatus 0 SControl 320)
> Nov  2 05:26:07 selene kernel: [   69.649807] ata8.03: hard resetting link
> Nov  2 05:26:07 selene kernel: [   69.969439] ata8.03: SATA link down (SStatus 0 SControl 320)
> Nov  2 05:26:07 selene kernel: [   69.969469] ata8.04: hard resetting link
> Nov  2 05:26:07 selene kernel: [   70.813852] ata8.04: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> Nov  2 05:26:07 selene kernel: [   70.813855] ata8.05: hard resetting link
> Nov  2 05:26:07 selene kernel: [   71.377665] ata8.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
> Nov  2 05:26:07 selene kernel: [   71.381475] ata8.00: configured for UDMA/133
> Nov  2 05:26:07 selene kernel: [   71.381475] ata8.01: ATA-8: ST31000340AS, SD15, max UDMA/133
> Nov  2 05:26:07 selene kernel: [   71.381475] ata8.01: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> Nov  2 05:26:07 selene kernel: [   71.381879] ata8.01: configured for UDMA/133
> Nov  2 05:26:07 selene kernel: [   71.381879] ata8.04: ATA-8: ST31000340AS, SD15, max UDMA/133
> Nov  2 05:26:07 selene kernel: [   71.381879] ata8.04: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> Nov  2 05:26:07 selene kernel: [   71.381890] ata8.04: configured for UDMA/133
> Nov  2 05:26:07 selene kernel: [   71.389769] ata8: EH complete

The link probably got a PHY event after reset sequence is complete.
Maybe our timinig is too aggressive or the PMP is just quirky but as
long as detection succeeds in the end, it should be okay.

> Once the system is up and running, I get these errors.  They appear
> anywhere from several hours to a few minutes apart.  What exactly
> does this mean?  It doesn't seem to have any impact on the
> performance of the drives.  Typically, these drives are very heavily
> loaded; I've been dumping > 1TB of data to them while rebuilding the
> RAID-5 array, so they're pretty well maxed out.
> 
> Nov  2 05:40:13 selene kernel: [  984.254543] ata8.15: exception Emask 0x10 SAct 0x0 SErr 0x780101 action 0x7
> Nov  2 05:40:13 selene kernel: [  984.254549] ata8.15: irq_stat 0x0c000000
> Nov  2 05:40:13 selene kernel: [  984.254552] ata8: SError: { RecovData UnrecovData 10B8B Dispar BadCRC Handshk }
> Nov  2 05:40:13 selene kernel: [  984.254557] ata8.01: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x0

It indicates that the link experienced ATA bus transmission failure.
Heh... Not only that the controller turned on all possible link error
bits.  Hmmm... The second device has active commands and it's the same
device which caused problem during boot too.  Can you please try the
followings?

1. Swap the second drive with another one and see whether the error
   follows the drive or stays with the slot.

2. Specify libata.force=8.15:1.5Gbps

Thanks.

-- 
tejun
