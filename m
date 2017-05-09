From: Sui Chen <suichen6@gmail.com>
Subject: [PATCH Resend] ahci: Acer SA5-271 SSD Not Detected Fix
Date: Tue, 9 May 2017 07:47:22 -0500
Message-ID: <086b549a-e2ec-58c4-42af-c5b5e23f67a7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33727 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753218AbdEIMrY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 May 2017 08:47:24 -0400
Received: by mail-oi0-f67.google.com with SMTP id h4so14369357oib.0
        for <linux-ide@vger.kernel.org>; Tue, 09 May 2017 05:47:24 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org

(Correction in this resend: fixed function name acer_sa5_271_workaround; fixed
 the always-true condition in the function; fixed description.)

On the Acer Switch Alpha 12 (model number: SA5-271), the internal SSD may not
get detected because the port_map and CAP.nr_ports combination causes the driver
to skip the port that is actually connected to the SSD. More specifically,
either all SATA ports are identified as DUMMY, or all ports get ``link down''
and never get up again.

This problem occurs occasionally. When this problem occurs, CAP may hold a
value of 0xC734FF00 or 0xC734FF01 and port_map may hold a value of 0x00 or 0x01.
When this problem does not occur, CAP holds a value of 0xC734FF02 and port_map
may hold a value of 0x07. Overriding the CAP value to 0xC734FF02 and port_map to
0x7 significantly reduces the occurrence of this problem.

Link: https://bugzilla.kernel.org/attachment.cgi?id=253091
Signed-off-by: Sui Chen <suichen6@gmail.com>
Tested-by: Damian Ivanov <damianatorrpm@gmail.com>
---
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2fc5240..2b4bcb6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1364,6 +1364,39 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 {}
 #endif

+/*
+ * On the Acer Aspire Switch Alpha 12, sometimes all SATA ports are detected
+ * as DUMMY, or detected but eventually get a ``link down'' and never get up
+ * again. When this happens, CAP.NP may hold a value of 0x00 or 0x01, and the
+ * port_map may hold a value of 0x00.
+ *
+ * Overriding CAP.NP to 0x02 and the port_map to 0x7 will reveal all 3 ports
+ * and can significantly reduce the occurrence of the problem.
+ *
+ * https://bugzilla.kernel.org/show_bug.cgi?id=189471
+ */
+static void acer_sa5_271_workaround(struct ahci_host_priv *hpriv,
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
+	if (dmi_check_system(sysids)) {
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
+	acer_sa5_271_workaround(hpriv, pdev);
+
 	/* CAP.NP sometimes indicate the index of the last enabled
 	 * port, at other times, that of the last possible port, so
 	 * determining the maximum port number requires looking at

