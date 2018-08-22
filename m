From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 05/14] ata: ahci_dm816: add second argument of ahci_platform_get_resources()
Date: Wed, 22 Aug 2018 16:37:01 +0900
Message-ID: <1534923430-9692-6-git-send-email-hayashi.kunihiko@socionext.com>
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
 drivers/ata/ahci_dm816.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_dm816.c b/drivers/ata/ahci_dm816.c
index fbd827c..89509c3 100644
--- a/drivers/ata/ahci_dm816.c
+++ b/drivers/ata/ahci_dm816.c
@@ -148,7 +148,7 @@ static int ahci_dm816_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-- 
2.7.4
