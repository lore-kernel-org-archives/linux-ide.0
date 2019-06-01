From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 1/4] mod_devicetable: helper macro for declaring oftree module device table
Date: Sat,  1 Jun 2019 15:52:56 +0200
Message-ID: <1559397179-5833-2-git-send-email-info@metux.net>
References: <1559397179-5833-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559397179-5833-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: vireshk@kernel.org, b.zolnierkie@samsung.com, axboe@kernel.dk, herbert@gondor.apana.org.au, davem@davemloft.net, linux-ide@vger.kernel.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Little helper macros that declares an oftree module device table,
if CONFIG_OF is enabled. Otherwise it's just noop. Helpful for
reducing the number of #ifdef's.

Instead of:
    MODULE_DEVICE_TABLE(of, foo);
now use:
    MODULE_OF_TABLE(foo);

Or declare the whole table via:
    MODULE_DECLARE_OF_TABLE(foo,
        { .compatible = "foo" },
        { .compatible = "bar" });

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/linux/mod_devicetable.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 448621c..5f4f2dc8 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -245,6 +245,19 @@ struct of_device_id {
 	const void *data;
 };
 
+/*
+ * macro for adding the of module device table only if CONFIG_OF enabled
+ */
+#ifdef CONFIG_OF
+#define MODULE_OF_TABLE(name)	MODULE_DEVICE_TABLE(of,name)
+#define MODULE_DECLARE_OF_TABLE(name,entries...) \
+static const struct of_device_id name[] = { entries, {} };
+#else
+#define MODULE_OF_TABLE(name)
+#define MODULE_DECLARE_OF_TABLE(name,entries...) \
+static const struct of_device_id *name = NULL;
+#endif /* CONFIG_OF */
+
 /* VIO */
 struct vio_device_id {
 	char type[32];
-- 
1.9.1
