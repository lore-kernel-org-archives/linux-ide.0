From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 2/4] drivers: block: xsysace: use MODULE_DECLARE_OF_TABLE() and of_match_ptr()
Date: Sat,  1 Jun 2019 15:52:57 +0200
Message-ID: <1559397179-5833-3-git-send-email-info@metux.net>
References: <1559397179-5833-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559397179-5833-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: vireshk@kernel.org, b.zolnierkie@samsung.com, axboe@kernel.dk, herbert@gondor.apana.org.au, davem@davemloft.net, linux-ide@vger.kernel.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Using MODULE_DECLARE_OF_TABLE() and of_match_ptr() macros to get
rid of some #ifdef CONFIG_OF and thus make the code a bit slimmer.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/block/xsysace.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 464c9092..d8e5dd7 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1219,26 +1219,18 @@ static int ace_remove(struct platform_device *dev)
 	return 0;
 }
 
-#if defined(CONFIG_OF)
-/* Match table for of_platform binding */
-static const struct of_device_id ace_of_match[] = {
+MODULE_DECLARE_OF_TABLE(ace_of_match,
 	{ .compatible = "xlnx,opb-sysace-1.00.b", },
 	{ .compatible = "xlnx,opb-sysace-1.00.c", },
 	{ .compatible = "xlnx,xps-sysace-1.00.a", },
-	{ .compatible = "xlnx,sysace", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, ace_of_match);
-#else /* CONFIG_OF */
-#define ace_of_match NULL
-#endif /* CONFIG_OF */
+	{ .compatible = "xlnx,sysace", });
 
 static struct platform_driver ace_platform_driver = {
 	.probe = ace_probe,
 	.remove = ace_remove,
 	.driver = {
 		.name = "xsysace",
-		.of_match_table = ace_of_match,
+		.of_match_table = of_match_ptr(ace_of_match),
 	},
 };
 
-- 
1.9.1
