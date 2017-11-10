From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH] ahci: imx: Handle increased read failures for IMX53 temperature sensor in low frequency mode.
Date: Fri, 10 Nov 2017 20:51:38 +0000
Message-ID: <1510347098-20472-1-git-send-email-martyn.welch@collabora.co.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55024 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdKJU5F (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Nov 2017 15:57:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Egor Starkov <egor.starkov@ge.com>, Martyn Welch <martyn.welch@collabora.co.uk>

From: Egor Starkov <egor.starkov@ge.com>

Extended testing has shown that the imx ahci driver sometimes requires
more than the 100 attempts currently alotted in the driver to perform a
successful temperature reading when running at minimum (throttled) CPU
frequency.

Debugging suggests that the read cycle canitake 160 attempts (which given
that the driver averages 80 readings from the ADC equates to one failure
on each read).

Increase the attempt limit to 200 in order to greatly reduce the
likelyhood of the driver failing to perform a temperature reading,
especially at low CPU frequency.

Signed-off-by: Egor Starkov <egor.starkov@ge.com>
Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 drivers/ata/ahci_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 787567e..a58bcc0 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -230,7 +230,7 @@ static int read_adc_sum(void *dev, u16 rtune_ctl_reg, void __iomem * mmio)
 {
 	u16 adc_out_reg, read_sum;
 	u32 index, read_attempt;
-	const u32 attempt_limit = 100;
+	const u32 attempt_limit = 200;
 
 	imx_phy_reg_addressing(SATA_PHY_CR_CLOCK_RTUNE_CTL, mmio);
 	imx_phy_reg_write(rtune_ctl_reg, mmio);
-- 
1.8.3.1

