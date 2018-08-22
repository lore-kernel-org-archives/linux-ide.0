From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 3/3] ata: ahci_platform: enable to get and control reset
Date: Wed, 22 Aug 2018 21:13:03 +0900
Message-ID: <1534939983-16264-4-git-send-email-hayashi.kunihiko@socionext.com>
References: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-ide@vger.kernel.org

Unlike SoC-specific driver, generic ahci_platform driver doesn't
have any chances to control resets.

This adds AHCI_PLATFORM_GET_RESETS to ahci_platform_get_resources()
on the generic driver to enable reset control support.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/ata/ahci_platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 5709273..ddd9308 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -43,7 +43,8 @@ static int ahci_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev, 0);
+	hpriv = ahci_platform_get_resources(pdev,
+					    AHCI_PLATFORM_GET_RESETS);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-- 
2.7.4
