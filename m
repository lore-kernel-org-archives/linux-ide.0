From: Sui Chen <suichen6@gmail.com>
Subject: [PATCH] ahci: Acer SA5-271 SSD Not Detected Fix
Date: Tue, 9 May 2017 01:20:53 -0500
Message-ID: <23f52147-bf4a-9707-6ed9-657b83619648@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33652 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdEIGUz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 May 2017 02:20:55 -0400
Received: by mail-pf0-f193.google.com with SMTP id b23so12561217pfc.0
        for <linux-ide@vger.kernel.org>; Mon, 08 May 2017 23:20:55 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org

On the Acer Switch Alpha 12 (model number: SA5-271), the internal SSD may not
get detected because the port_map and CAP.nr_ports combination causes the driver
to skip the port that is actually connected to the SSD.

This problem occurs occasionally. When this problem occurs, CAP may hold a
value of 0xC734FF00 or 0xC734FF01 and port_map may hold a value of 0x00 or 0x01.
When this problem does not occur, CAP holds a value of 0xC734FF02 and port_map
may hold a value of 0x07. Overriding the CAP value to 0xC734FF02 and port_map to
0x7 noticeably reduces the occurrences of this problem.

Link: https://bugzilla.kernel.org/attachment.cgi?id=253091
Signed-off-by: Sui Chen <suichen6@gmail.com>
Tested-by: Damian Ivanov <damianatorrpm@gmail.com>
---
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2fc5240..6b29e64 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1364,6 +1364,39 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 {}
 #endif

+/*
+ * On the Acer Aspire Switch Alpha 12, sometimes all SATA channels
+ * are detected as DUMMY. When this happens, the last byte of the CAP
+ * register becomes 0x00 or 0x01, wrongly indicating there are only
+ * 1 or 2 SATA channels in the system.
+ *
+ * Overriding the last byte in the CAP register to 0x02 (which
+ * indicates to 3 channels) resolves this problem.
+ *
+ * https://bugzilla.kernel.org/show_bug.cgi?id=189471
+ */
+static void acpi_sa5_271_workaround(struct ahci_host_priv *hpriv,
+				    struct pci_dev *pdev)
+{
+	static const struct dmi_system_id sysids[] = {
+		{
+			.ident = "Acer Switch Alpha 12",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Switch SA5-271")
+			},
+		},
+		{ }
+	};
+	if (true || dmi_check_system(sysids)) {
+		dev_info(&pdev->dev, "enabling Acer Switch Alpha 12 workaround\n");
+		if ((hpriv->saved_cap & 0xC734FF00) == 0xC734FF00) {
+			hpriv->port_map = 0x7;
+			hpriv->cap = 0xC734FF02;
+		}
+	}
+}
+
 #ifdef CONFIG_ARM64
 /*
  * Due to ERRATA#22536, ThunderX needs to handle HOST_IRQ_STAT differently.
@@ -1636,6 +1669,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct
pci_device_id *ent)
 			 "online status unreliable, applying workaround\n");
 	}

+
+	/* Acer SA5-271 workaround modifies private_data */
+	acpi_sa5_271_workaround(hpriv, pdev);
+
 	/* CAP.NP sometimes indicate the index of the last enabled
 	 * port, at other times, that of the last possible port, so
 	 * determining the maximum port number requires looking at
