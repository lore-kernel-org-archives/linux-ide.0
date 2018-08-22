From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 12/14] ata: ahci_sunxi: add second argument of ahci_platform_get_resources()
Date: Wed, 22 Aug 2018 16:37:08 +0900
Message-ID: <1534923430-9692-13-git-send-email-hayashi.kunihiko@socionext.com>
References: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

Adding a flag to indicate whether acqiring the optional resources
as the second argument of ahci_platform_get_resources(),
add the argument as initial value 0.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/ata/ahci_sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index b264374..631610b 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -181,7 +181,7 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-- 
2.7.4
