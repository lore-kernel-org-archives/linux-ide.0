From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pata_atiixp: Remove unnecessary parentheses
Date: Tue, 11 Sep 2018 14:43:38 -0700
Message-ID: <20180911214338.1109-1-natechancellor@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
List-Id: linux-ide@vger.kernel.org

Clang warns when more than one set of parentheses is used for a
single conditional statement:

drivers/ata/pata_atiixp.c:282:19: warning: equality comparison with
extraneous parentheses [-Wparentheses-equality]
        if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
            ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/ata/pata_atiixp.c:282:19: note: remove extraneous parentheses
around the comparison to silence this warning
        if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
           ~             ^                              ~
drivers/ata/pata_atiixp.c:282:19: note: use '=' to turn this equality
comparison into an assignment
        if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
                         ^~
                         =
1 warning generated.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/ata/pata_atiixp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 4d49fd3c927b..843bb200a1ee 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -279,7 +279,7 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	const struct ata_port_info *ppi[] = { &info, &info };
 
 	/* SB600 doesn't have secondary port wired */
-	if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
+	if (pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE)
 		ppi[1] = &ata_dummy_port_info;
 
 	return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
-- 
2.18.0
