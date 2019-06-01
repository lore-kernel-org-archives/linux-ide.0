From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 3/4] drivers: crypto: picoxcell_crypto: use MODULE_DECLARE_OF_TABLE()
Date: Sat,  1 Jun 2019 15:52:58 +0200
Message-ID: <1559397179-5833-4-git-send-email-info@metux.net>
References: <1559397179-5833-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559397179-5833-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: vireshk@kernel.org, b.zolnierkie@samsung.com, axboe@kernel.dk, herbert@gondor.apana.org.au, davem@davemloft.net, linux-ide@vger.kernel.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Using MODULE_DECLARE_OF_TABLE() macro to get rid of some #ifdef CONFIG_OF
and make the code a bit slimmer.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/crypto/picoxcell_crypto.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index b985cb85..3c299f2 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1612,14 +1612,9 @@ static DEVICE_ATTR(stat_irq_thresh, 0644, spacc_stat_irq_thresh_show,
 	},
 };
 
-#ifdef CONFIG_OF
-static const struct of_device_id spacc_of_id_table[] = {
+MODULE_DECLARE_OF_TABLE(spacc_of_id_table,
 	{ .compatible = "picochip,spacc-ipsec" },
-	{ .compatible = "picochip,spacc-l2" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, spacc_of_id_table);
-#endif /* CONFIG_OF */
+	{ .compatible = "picochip,spacc-l2" });
 
 static int spacc_probe(struct platform_device *pdev)
 {
-- 
1.9.1
