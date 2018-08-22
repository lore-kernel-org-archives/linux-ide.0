From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 06/14] ata: ahci_imx: add second argument of ahci_platform_get_resources()
Date: Wed, 22 Aug 2018 16:37:02 +0900
Message-ID: <1534923430-9692-7-git-send-email-hayashi.kunihiko@socionext.com>
References: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
List-Id: linux-ide@vger.kernel.org

Adding a flag to indicate whether acqiring the optional resources
as the second argument of ahci_platform_get_resources(),
add the argument as initial value 0.

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/ata/ahci_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 6822e2f..b00799d 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1127,7 +1127,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-- 
2.7.4
