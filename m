From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 3/3] ahci: st: st_configure_oob must be called after IP is clocked.
Date: Mon,  2 Mar 2015 12:48:39 +0000
Message-ID: <1425300519-13747-4-git-send-email-peter.griffin@linaro.org>
References: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:35067 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbbCBMsv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2015 07:48:51 -0500
Received: by wevl61 with SMTP id l61so33111154wev.2
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2015 04:48:50 -0800 (PST)
In-Reply-To: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, tj@kernel.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org

Currently the ahci_st driver will hang the system on probe, as the
st_configure_oob function does some register writes before the IP
is clocked. This patch moves the function call to after
ahci_platform_enable_resources (which enables the IP clock), and
resolves the hang.

Addtionally st_ahci_configure_oob should be called in the st_ahci_resume
function, so we also rectify that ensuring it is also called after
the IP clock has been enabled.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ata/ahci_st.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index bc971af..ea0ff00 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -68,8 +68,6 @@ static int st_ahci_deassert_resets(struct device *dev)
 		}
 	}
 
-	st_ahci_configure_oob(drv_data->hpriv->mmio);
-
 	if (drv_data->sw_rst) {
 		err = reset_control_deassert(drv_data->sw_rst);
 		if (err) {
@@ -172,6 +170,8 @@ static int st_ahci_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	st_ahci_configure_oob(drv_data->hpriv->mmio);
+
 	err = ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info,
 				      &ahci_platform_sht);
 	if (err) {
@@ -222,6 +222,8 @@ static int st_ahci_resume(struct device *dev)
 		return err;
 	}
 
+	st_ahci_configure_oob(drv_data->hpriv->mmio);
+
 	return ahci_platform_resume_host(dev);
 }
 #endif
-- 
1.9.1

