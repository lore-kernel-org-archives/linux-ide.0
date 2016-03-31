From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/3] libahci: save port map for forced port map
Date: Thu, 31 Mar 2016 18:31:38 +0100
Message-ID: <1459445500-9071-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459445500-9071-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1459445500-9071-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-ide@vger.kernel.org

In usecases where force_port_map is used saved_port_map is never set,
resulting in not programming the PORTS_IMPL register as part of initial
config. This patch fixes this by setting it to port_map even in case
where force_port_map is used, making it more inline with other parts of
the code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/ata/libahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 3982054..a5d7c1c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -507,6 +507,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
 		dev_info(dev, "forcing port_map 0x%x -> 0x%x\n",
 			 port_map, hpriv->force_port_map);
 		port_map = hpriv->force_port_map;
+		hpriv->saved_port_map = port_map;
 	}
 
 	if (hpriv->mask_port_map) {
-- 
2.5.0
