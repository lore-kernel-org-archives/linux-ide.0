From: Ryan Power <rpower@sysreset.com>
Subject: Spinup command fails on WD3200JS
Date: Fri, 13 Jul 2007 00:14:18 -0600
Message-ID: <6.2.0.14.2.20070713000748.031a2660@linux.sysreset.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.sysreset.com ([209.97.229.250]:30833 "EHLO sysreset"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756939AbXGMGaY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 02:30:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi.
I've run into a problem with the lastest kernel (2.6.22.1) and a drive set 
to spinup on set_features.

hdparm reports:
/dev/sdf:

ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.
         Model Number:       WDC WD3200JS-57PDB0
         Serial Number:      X
         Firmware Revision:  21.00M21
...
Commands/features:
         Enabled Supported:
            *    Power-Up In Standby feature set
            *    SET_FEATURES required to spinup after power up
...

I get the following messages when booting:
Jul 12 23:47:22 sysreset kernel: ata6: SATA link up 1.5 Gbps (SStatus 113 
SControl 300)
Jul 12 23:47:22 sysreset kernel: ata6.00: ATA-7: WDC WD3200JS-57PDB0, 
21.00M21, max UDMA/133
Jul 12 23:47:22 sysreset kernel: ata6.00: 625142448 sectors, multi 0: LBA48 
NCQ (depth 1)
Jul 12 23:47:22 sysreset kernel: ata6.00: failed to IDENTIFY (SPINUP 
failed, err_mask=0x1)
Jul 12 23:47:22 sysreset kernel: ata6.00: revalidation failed (errno=-5)
Jul 12 23:47:22 sysreset kernel: ata6: failed to recover some devices, 
retrying in 5 secs
Jul 12 23:47:22 sysreset kernel: ata6: SATA link up 1.5 Gbps (SStatus 113 
SControl 300)
Jul 12 23:47:22 sysreset kernel: ata6.00: failed to IDENTIFY (SPINUP 
failed, err_mask=0x1)
Jul 12 23:47:22 sysreset kernel: ata6.00: revalidation failed (errno=-5)
Jul 12 23:47:22 sysreset kernel: ata6.00: limiting speed to UDMA/133:PIO3
Jul 12 23:47:22 sysreset kernel: ata6: failed to recover some devices, 
retrying in 5 secs
Jul 12 23:47:22 sysreset kernel: ata6: SATA link up 1.5 Gbps (SStatus 113 
SControl 300)
Jul 12 23:47:22 sysreset kernel: ata6.00: failed to IDENTIFY (SPINUP 
failed, err_mask=0x1)
Jul 12 23:47:22 sysreset kernel: ata6.00: revalidation failed (errno=-5)
Jul 12 23:47:22 sysreset kernel: ata6.00: disabled

The interesting thing is that after displaying that, the drive has in fact 
spun up.  I'm not sure why it's getting an error returned, but chaning the 
err_mask line to read "if (err_mask && err_mask != 0x01)" corrects the 
problem and the drive spins up and ID's normally:
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATA-7: WDC WD3200JS-57PDB0, 21.00M21, max UDMA/133
ata6.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 1)
ata6.00: configured for UDMA/133

If you'd like me to do any more testing or need more information from me 
please let me know.
Thank you.

-Ryan Power

