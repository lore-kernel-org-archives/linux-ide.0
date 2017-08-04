From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 9/9] ata: ceva: Add SMMU support for SATA IP
Date: Fri,  4 Aug 2017 15:18:18 +0200
Message-ID: <d2e94d9d3b378e5d3579a70fb9782f6088356294.1501852693.git.michal.simek@xilinx.com>
References: <cover.1501852693.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501852693.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1501852693.git.michal.simek@xilinx.com>
References: <cover.1501852693.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Alexander Graf <agraf@suse.de>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

AXI master interface in CEVA AHCI controller requires two unique
Write/Read ID tags per port. This is because, ahci controller uses
different AXI ID[3:0] bits for identifying non-data transfers(like
reading descriptors, updating PRD tables, etc) and data transfers
(like sending/receiving FIS).To make SMMU work with SATA we need to
add correct SMMU stream id for SATA. SMMU stream id for SATA is
determined based on the AXI ID[1:0] as shown below

	SATA SMMU ID =  <TBU number>, 0011, 00, 00, AXI ID[1:0]
	Note: SATA in  ZynqMp uses TBU1 so TBU number = 0x1, so
	      SMMU ID = 001, 0011, 00, 00, AXI ID[1:0]

Since we have four different AXI ID[3:0] (2 for port0 & 2 for port1
as said above) we get four different SMMU stream id's combinations
for SATA. These AXI ID can be configured using PAXIC register.
In this patch we assumed the below AXI ID values

 Read ID/ Write ID for Non-Data Port0 transfers = 0
 Read ID/ Write ID for Data Port0 transfers = 1
 Read ID/ Write ID for Non-Data Port1 transfers = 2
 Read ID/ Write ID for Data Port1 transfers = 3

Based on the above values,SMMU stream ID's for SATA will be 0x4c0 &
0x4c1 for PORT0, 0x4c2 & 0x4c3 for PORT1. These values needed to be
added to iommus dts property. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/ata/ahci_ceva.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index c0742cbe4faa..5ecc9d46cb54 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -38,8 +38,10 @@
 
 /* Vendor Specific Register bit definitions */
 #define PAXIC_ADBW_BW64 0x1
-#define PAXIC_MAWIDD	(1 << 8)
-#define PAXIC_MARIDD	(1 << 16)
+#define PAXIC_MAWID(i)	(((i) * 2) << 4)
+#define PAXIC_MARID(i)	(((i) * 2) << 12)
+#define PAXIC_MARIDD(i)	((((i) * 2) + 1) << 16)
+#define PAXIC_MAWIDD(i)	((((i) * 2) + 1) << 8)
 #define PAXIC_OTL	(0x4 << 20)
 
 /* Register bit definitions for cache control */
@@ -147,9 +149,11 @@ static void ahci_ceva_setup(struct ahci_host_priv *hpriv)
 		/*
 		 * AXI Data bus width to 64
 		 * Set Mem Addr Read, Write ID for data transfers
+		 * Set Mem Addr Read ID, Write ID for non-data transfers
 		 * Transfer limit to 72 DWord
 		 */
-		tmp = PAXIC_ADBW_BW64 | PAXIC_MAWIDD | PAXIC_MARIDD | PAXIC_OTL;
+		tmp = PAXIC_ADBW_BW64 | PAXIC_MAWIDD(i) | PAXIC_MARIDD(i) |
+			PAXIC_MAWID(i) | PAXIC_MARID(i) | PAXIC_OTL;
 		writel(tmp, mmio + AHCI_VEND_PAXIC);
 
 		/* Set AXI cache control register if CCi is enabled */
-- 
1.9.1
