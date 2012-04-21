From: Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH V2 4/5] ata: ahci_platform: Add synopsys ahci controller in DT's compatible list
Date: Sat, 21 Apr 2012 17:40:12 +0530
Message-ID: <aad8dce41013d16075a4ea479fd21a67ca548715.1335009632.git.viresh.kumar@st.com>
References: <cover.1335009631.git.viresh.kumar@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33246 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab2DUMMP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Apr 2012 08:12:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so2061502pbc.19
        for <linux-ide@vger.kernel.org>; Sat, 21 Apr 2012 05:12:15 -0700 (PDT)
In-Reply-To: <cover.1335009631.git.viresh.kumar@st.com>
In-Reply-To: <cover.1335009631.git.viresh.kumar@st.com>
References: <cover.1335009631.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-ide@vger.kernel.org, sshtylyov@mvista.com, Viresh Kumar <viresh.kumar@st.com>, Rob Herring <rob.herring@calxeda.com>

SPEAr13xx series of SoCs contain Synopsys AHCI SATA Controller which shares
ahci_platform driver with other controller versions.

This patch updates DT compatible list for ahci_platform. It also updates and
renames binding documentation to more generic name.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 .../ata/{calxeda-sata.txt => ahci-platform.txt}    |    5 ++---
 drivers/ata/ahci_platform.c                        |    1 +
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/ata/{calxeda-sata.txt => ahci-platform.txt} (90%)

diff --git a/Documentation/devicetree/bindings/ata/calxeda-sata.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
similarity index 90%
rename from Documentation/devicetree/bindings/ata/calxeda-sata.txt
rename to Documentation/devicetree/bindings/ata/ahci-platform.txt
index 79caa56..8bb8a76 100644
--- a/Documentation/devicetree/bindings/ata/calxeda-sata.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -1,10 +1,10 @@
-* Calxeda SATA Controller
+* AHCI SATA Controller
 
 SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
 Required properties:
-- compatible        : compatible list, contains "calxeda,hb-ahci"
+- compatible        : compatible list, contains "calxeda,hb-ahci" or "snps,spear-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 
@@ -14,4 +14,3 @@ Example:
                 reg = <0xffe08000 0x1000>;
                 interrupts = <115>;
         };
-
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 0c86c77..9e419e1 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -280,6 +280,7 @@ static struct dev_pm_ops ahci_pm_ops = {
 
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "calxeda,hb-ahci", },
+	{ .compatible = "snps,spear-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.7.9

