From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] sata_fsl: remove check for CONFIG_MPC8315_DS
Date: Wed, 21 May 2014 21:35:37 +0200
Message-ID: <1400700937.30334.2.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

A check for CONFIG_MPC8315_DS was added in v2.6.24. But the related
Kconfig symbol was never added to the tree. So the code behind this
check has effectively been dead for over six years. Remove it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 drivers/ata/sata_fsl.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index fb0b40a191c2..3f316d61a9d8 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -774,20 +774,6 @@ static int sata_fsl_port_start(struct ata_port *ap)
 	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
 	VPRINTK("CHBA  = 0x%x\n", ioread32(hcr_base + CHBA));
 
-#ifdef CONFIG_MPC8315_DS
-	/*
-	 * Workaround for 8315DS board 3gbps link-up issue,
-	 * currently limit SATA port to GEN1 speed
-	 */
-	sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
-	temp &= ~(0xF << 4);
-	temp |= (0x1 << 4);
-	sata_fsl_scr_write(&ap->link, SCR_CONTROL, temp);
-
-	sata_fsl_scr_read(&ap->link, SCR_CONTROL, &temp);
-	dev_warn(dev, "scr_control, speed limited to %x\n", temp);
-#endif
-
 	return 0;
 }
 
-- 
1.9.0
