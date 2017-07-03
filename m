From: Nate Watterson <nwatters@codeaurora.org>
Subject: [PATCH 1/2] libata: Introduce ata_platform_shutdown_one()
Date: Mon,  3 Jul 2017 14:02:41 -0400
Message-ID: <1499104962-17498-1-git-send-email-nwatters@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Nate Watterson <nwatters@codeaurora.org>
List-Id: linux-ide@vger.kernel.org

In similar fashion to how ata_platform_remove_one() is used, this
newly introduced method can be used by platform ata drivers to get
basic shutdown functionality (stopping host DMA and interrupts).

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/ata/libata-core.c | 20 ++++++++++++++++++++
 include/linux/libata.h    |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e157a0e..537932e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6702,6 +6702,25 @@ int ata_platform_remove_one(struct platform_device *pdev)
 	return 0;
 }
 
+/**
+ *	ata_platform_shutdown_one - Platform layer callback for device shutdown
+ *	@pdev: Platform device being shutdown
+ *
+ *	Platform layer indicates to libata via this hook that shutdown is
+ *	in progress and the input device should be quiesced. Functionally this
+ *	is equivalent to ata_platform_remove_one(), however devres_release_all()
+ *	is not called on the shutdown path as it is for remove so releasing the
+ *	resources associated with the device must instead be initiated directly.
+ */
+void ata_platform_shutdown_one(struct platform_device *pdev)
+{
+	struct ata_host *host = platform_get_drvdata(pdev);
+
+	ata_host_detach(host);
+	devres_release(&pdev->dev, ata_host_stop, NULL, NULL);
+	devres_release(&pdev->dev, ata_host_release, NULL, NULL);
+}
+
 static int __init ata_parse_force_one(char **cur,
 				      struct ata_force_ent *force_ent,
 				      const char **reason)
@@ -7222,6 +7241,7 @@ void ata_print_version(const struct device *dev, const char *version)
 #endif /* CONFIG_PCI */
 
 EXPORT_SYMBOL_GPL(ata_platform_remove_one);
+EXPORT_SYMBOL_GPL(ata_platform_shutdown_one);
 
 EXPORT_SYMBOL_GPL(__ata_ehi_push_desc);
 EXPORT_SYMBOL_GPL(ata_ehi_push_desc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c9a69fc..6c01f23f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1240,6 +1240,7 @@ struct pci_bits {
 struct platform_device;
 
 extern int ata_platform_remove_one(struct platform_device *pdev);
+extern void ata_platform_shutdown_one(struct platform_device *pdev);
 
 /*
  * ACPI - drivers/ata/libata-acpi.c
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
