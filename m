From: Andreas Werner <andreas.werner@men.de>
Subject: [PATCH 2/2] ata/sata_fsl.c: add ATA_FLAG_NO_LOG_PAGE to blacklist
 the controller for log page reads
Date: Fri, 4 Dec 2015 16:53:45 +0100
Message-ID: <e27637dd8d173d9c43cde0e4db16962771d9551b.1449243748.git.andreas.werner@men.de>
References: <cover.1449243748.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1449243748.git.andreas.werner@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

Every attempt to issue a read log page command lockup the controller.
The command is currently sent if the sata device includes the devlsp feature
to read out the timing data.
This attempt to read the data, locks up the controller and the device
is not recognzied correctly (failed to set xfermode) and cannot be accessed.

This was found on Freescale P1013/P1022 and T4240 CPUs
using a ATP IG mSATA 4GB with the devslp feature.

fsl-sata ff718000.sata: Sata FSL Platform/CSB Driver init
[    1.254195] scsi0 : sata_fsl
[    1.256004] ata1: SATA max UDMA/133 irq 74
[    1.370666] fsl-gianfar ethernet.3: enabled errata workarounds, flags: 0x4
[    1.470671] fsl-gianfar ethernet.4: enabled errata workarounds, flags: 0x4
[    1.775584] ata1: Signature Update detected @ 504 msecs
[    1.947594] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.948366] ata1.00: ATA-8: ATP IG mSATA, 20150311, max UDMA/133
[    1.948371] ata1.00: 7732368 sectors, multi 0: LBA
[    1.948843] ata1.00: failed to get Identify Device Data, Emask 0x1
[    1.948857] ata1.00: failed to set xfermode (err_mask=0x40)
[    7.467557] ata1: Signature Update detected @ 504 msecs
[    7.639560] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.651320] ata1.00: failed to get Identify Device Data, Emask 0x1
[    7.651360] ata1.00: failed to set xfermode (err_mask=0x40)
[    7.655628] ata1: limiting SATA link speed to 1.5 Gbps
[    7.659458] ata1.00: limiting speed to UDMA/133:PIO3
[   13.163554] ata1: Signature Update detected @ 504 msecs
[   13.335558] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   13.347298] ata1.00: failed to get Identify Device Data, Emask 0x1
[   13.347334] ata1.00: failed to set xfermode (err_mask=0x40)
[   13.351601] ata1.00: disabled
[   13.353278] ata1: exception Emask 0x50 SAct 0x0 SErr 0x800 action 0x6 frozen t4
[   13.359281] ata1: SError: { HostInt }
[   13.361644] ata1: hard resetting link

Signed-off-by: Andreas Werner <andreas.werner@men.de>
---
 drivers/ata/sata_fsl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 5389579..a723ae9 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -45,7 +45,8 @@ enum {
 	SATA_FSL_MAX_PRD_DIRECT	= 16,	/* Direct PRDT entries */
 
 	SATA_FSL_HOST_FLAGS	= (ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
-				ATA_FLAG_PMP | ATA_FLAG_NCQ | ATA_FLAG_AN),
+				   ATA_FLAG_PMP | ATA_FLAG_NCQ |
+				   ATA_FLAG_AN | ATA_FLAG_NO_LOG_PAGE),
 
 	SATA_FSL_MAX_CMDS	= SATA_FSL_QUEUE_DEPTH,
 	SATA_FSL_CMD_HDR_SIZE	= 16,	/* 4 DWORDS */
-- 
2.6.2
