From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/4] ata: ahci_platform: fix ahci_platform_data->suspend method
 handling
Date: Mon, 17 Mar 2014 19:31:55 +0100
Message-ID: <1395081118-15248-2-git-send-email-b.zolnierkie@samsung.com>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, spear-devel@list.st.com, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

Looking at ST SPEAr1340 AHCI code (the only user of the deprecated
pdata->suspend and pdata->resume) it is obvious the we should return
after calling pdata->suspend() only if the function have returned
non-zero return value.  The code has been broken since commit 1e70c2
("ata/ahci_platform: Add clock framework support").  Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/ahci_platform.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 70fbf66..7bd6adf 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -521,12 +521,19 @@ int ahci_platform_suspend(struct device *dev)
 	if (rc)
 		return rc;
 
-	if (pdata && pdata->suspend)
-		return pdata->suspend(dev);
+	if (pdata && pdata->suspend) {
+		rc = pdata->suspend(dev);
+		if (rc)
+			goto resume_host;
+	}
 
 	ahci_platform_disable_resources(hpriv);
 
 	return 0;
+
+resume_host:
+	ahci_platform_resume_host(dev);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_platform_suspend);
 
-- 
1.8.2.3
