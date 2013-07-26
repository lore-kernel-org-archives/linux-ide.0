From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 1/5] sata, highbank: fix ordering of SGPIO signals
Date: Fri, 26 Jul 2013 10:11:54 -0500
Message-ID: <1374851518-4802-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, tj@kernel.org, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob.herring@calxeda.com
Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
List-Id: linux-ide@vger.kernel.org

The ACTIVITY and ERROR signals were reversed in the original commit.
Fix that.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
 drivers/ata/sata_highbank.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index d047d92..e9a4f46 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -86,11 +86,11 @@ struct ecx_plat_data {
 
 #define SGPIO_SIGNALS			3
 #define ECX_ACTIVITY_BITS		0x300000
-#define ECX_ACTIVITY_SHIFT		2
+#define ECX_ACTIVITY_SHIFT		0
 #define ECX_LOCATE_BITS			0x80000
 #define ECX_LOCATE_SHIFT		1
 #define ECX_FAULT_BITS			0x400000
-#define ECX_FAULT_SHIFT			0
+#define ECX_FAULT_SHIFT			2
 static inline int sgpio_bit_shift(struct ecx_plat_data *pdata, u32 port,
 				u32 shift)
 {
-- 
1.8.1.2
