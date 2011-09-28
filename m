From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V9 3/5] MX53 Enable the AHCI SATA on MX53 ARD board
Date: Wed, 28 Sep 2011 15:41:55 +0800
Message-ID: <1317195717-21174-4-git-send-email-richard.zhu@linaro.org>
References: <1317195717-21174-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317195717-21174-1-git-send-email-richard.zhu@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, eric.miao@linaro.org, linux-ide@vger.kernel.org, Richard Zhu <richard.zhu@linaro.org>, eric@eukrea.com, avorontsov@ru.mvista.com, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 arch/arm/mach-mx5/board-mx53_ard.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 76a67c4..ef2039e 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -234,6 +234,7 @@ static void __init mx53_ard_board_init(void)
 	imx53_add_imx_i2c(1, &mx53_ard_i2c2_data);
 	imx53_add_imx_i2c(2, &mx53_ard_i2c3_data);
 	imx_add_gpio_keys(&ard_button_data);
+	imx53_add_ahci_imx();
 }
 
 static void __init mx53_ard_timer_init(void)
-- 
1.7.1
