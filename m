From: Nate Watterson <nwatters@codeaurora.org>
Subject: [PATCH 2/2] ata: ahci_platform: Handle shutdown with ata_platform_shutdown_one()
Date: Mon,  3 Jul 2017 14:02:42 -0400
Message-ID: <1499104962-17498-2-git-send-email-nwatters@codeaurora.org>
References: <1499104962-17498-1-git-send-email-nwatters@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499104962-17498-1-git-send-email-nwatters@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nate Watterson <nwatters@codeaurora.org>
List-Id: linux-ide@vger.kernel.org

To avoid interfering with a new kernel started using kexec, quiesce
host controller DMA interrupts during driver shutdown with
ata_platform_remove_one().

Change-Id: Iedee7f7ba12172b3d34796a3e3b92dbb72d4ed9c
Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/ata/ahci_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 62a04c8..ca25b0d 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -93,6 +93,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 static struct platform_driver ahci_driver = {
 	.probe = ahci_probe,
 	.remove = ata_platform_remove_one,
+	.shutdown = ata_platform_shutdown_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_of_match,
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
