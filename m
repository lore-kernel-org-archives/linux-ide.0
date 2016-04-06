From: Christian Lamparter <chunkeey@googlemail.com>
Subject: [PATCH] ata: sata_dwc_460ex: fix sata_dwc_460ex when using dma transfers
Date: Wed,  6 Apr 2016 17:33:56 +0200
Message-ID: <1459956836-8213-1-git-send-email-chunkeey@googlemail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Christian Lamparter <chunkeey@googlemail.com>, tj@kernel.org, mans@mansr.com, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This patch allows sata_dwc_460ex to work with non-ncq, dma i/o.
Previously, the driver dumped the following warning:

 ------------[ cut here ]------------
WARNING: at c01f3d50 [verbose debug info unavailable]
CPU: 0 PID: 315 Comm: kworker/u2:2 Not tainted 4.4.6 #18
Workqueue: events_unbound async_run_entry_fn
NIP [c01f3d50] ata_sff_qc_issue+0x1d8/0x204
LR [c01f3bbc] ata_sff_qc_issue+0x44/0x204
Call Trace:
[cf6a98c0] [c01f3bbc] ata_sff_qc_issue+0x44/0x204 (unreliable)
[cf6a98e0] [c01f4e38] sata_dwc_qc_issue+0x270/0x298
[cf6a9950] [c01e24f4] ata_qc_issue+0x2f0/0x364

and was unable to access the drive. The issue is that
ata_sff_qc_issue can only handle PIO. This patch replaces
the it with ata_bmdma_qc_issue which handles DMA transfers
and can fallback to PIO when needed.

Cc: stable@vger.kernel.org
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
Note: I have a system with a APM82181 (which is a ppc460ex derivative).
It's the SoC in the WD MyBook Live NAS.

The driver has other issues as well... e.g:

Unable to handle kernel paging request for data at address 0x00000004
Faulting instruction address: 0xc01f2640
Oops: Kernel access of bad area, sig: 11 [#1]
CPU: 0 PID: 1 Comm: swapper Not tainted 4.4.6 #42
NIP [c01f2640] sata_dwc_probe+0x1a8/0x2dc
LR [c01f2640] sata_dwc_probe+0x1a8/0x2dc
Call Trace:
[cf435d60] [c01f2640] sata_dwc_probe+0x1a8/0x2dc (unreliable)
[cf435dc0] [c01c5728] platform_drv_probe+0x34/0x70
(This is due to hsdev->dma being NULL, as it was never allocated
or set).

However, this has been fixed (including fixes to dwc's
DMA) by Mans Rullgard. His repo is available from:
<https://bitbucket.org/mansr/linux-dwc/branch/dwc-sata>

Note2: NCQ seems to freezes the controller. Not sure what's
going on. I can post a separate patch to disable it, if requested.
---
 drivers/ata/sata_dwc_460ex.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e7a47aa..234f50d 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1113,7 +1113,9 @@ static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
 		sata_dwc_exec_command_by_tag(ap, &qc->tf, qc->tag,
 					     SATA_DWC_CMD_ISSUED_PEND);
 	} else {
-		ata_sff_qc_issue(qc);
+		/* Sync ata_port with qc->tag */
+		ap->link.active_tag = qc->tag;
+		return ata_bmdma_qc_issue(qc);
 	}
 	return 0;
 }
-- 
2.8.0.rc3
