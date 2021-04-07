Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C9EC43600
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 01:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA47C613A7
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 01:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347720AbhDGBZo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 6 Apr 2021 21:25:44 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:57441
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238500AbhDGBZg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 6 Apr 2021 21:25:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO8sBrdmwPMG095NrZ3L6IdvG0H4/jwmOvLZARfjcsHIiTXC7FWTI8uON+zkVZI4ujJ2OvsyMAKqMFLrNfaHTIre1IaneOR45CNBS2PlqNqMsqnadVZpxApeKVv1zhmIXkYeqLkbjNiFRQw1tJl2/oPf2M7DqwhScECM9znEmfinPHUmiDcLcCqEYVeq0cuBCOCJ+BA5giAOfujVOHg9FoTTvibTUh9JKg9NB1Z17i7BAJn/mgkGSHsoPVi9XDvlvKBdc6TwBFb5ibebdmySBYmA0eQ6qgrcdZYjZ6GsmeyCts9KrOdWx46QTYq5KEYZR3YJbMIS97sqh9EG6AaSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfDrNKCX5CMNRDpfyCEpZKmu8tRIqYugQbcPQhpYCL4=;
 b=L1e2VAE4bdfKDTJBgcgyTXZUtPkuTvMv71DZjghmvMiqYWBp2pJaYBe2BDYk+9kijn6gWXpCb3lTk7Br6Hdqb4ZlsF9vBWSR47EeddN1eVXncVSHTp26mtyciwN+ph24ISwFxoE1THm9dorR9PFE3TWT1ZxPOi4pJqKLXuAsdcoA/B+o982uC4ISYDOiFhbIW3iF56MF95CwAsxmOglcWW5sNdW5L+K5FR+h0fMyEyY9psk5hDAEO2n477qQT+yXLim3zIbIFLMDQSSL4jizN7rUuzZf35gXA2IouI4fIetPgP8s4tBCxSbsK5DbPSStSQJ0hjkHw5MKE2J1YEYX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfDrNKCX5CMNRDpfyCEpZKmu8tRIqYugQbcPQhpYCL4=;
 b=TTXc+MTxJ3fdVSLevpAuGE87wivJyXjCuSNvEDFHoo3QFQlmVKVYTF3+Gv7USNb+aygqrUq1L97I7tXmpKSSgnCTTtZyHCiajG0I/zHFrrriK6Qum350fefKuUy6wqUNqxaKvWqVv/0FQIhp0eADkjgGzVM82aaQzqSdudXAwCSTqXAYJVT1OByPqzwwPGjIYgy7Qg/dmVJLZZy2Q5L0IWIaAW/V8RyHBYzaYAodJdwv0cQ7FUlmpwVODCrgZt1HGq5TN58ODivsDRmDWR+FdLdDJ114qJvwmcNkIS8XFc/tUYycoVewOTEfxG5id54Gl1SzTIZDo2OULbINwNg7uQ==
Received: from DM3PR12CA0136.namprd12.prod.outlook.com (2603:10b6:0:51::32) by
 CY4PR12MB1606.namprd12.prod.outlook.com (2603:10b6:910:10::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.26; Wed, 7 Apr 2021 01:25:25 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::63) by DM3PR12CA0136.outlook.office365.com
 (2603:10b6:0:51::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 01:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Wed, 7 Apr 2021 01:25:25 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
 2021 01:25:24 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
 2021 01:25:23 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 01:25:23 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <axboe@kernel.dk>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: ata: tegra: Convert binding documentation to YAML
Date:   Tue, 6 Apr 2021 18:25:29 -0700
Message-ID: <1617758731-12380-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65ac4d64-d1b0-4084-f7dd-08d8f9640538
X-MS-TrafficTypeDiagnostic: CY4PR12MB1606:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1606264D901706A56F634013C2759@CY4PR12MB1606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSEG85wYT30eXWF+9klYna8CIHjNu0uyFhiiEJkudkqrrQrY8Qkk4Oe7E9cueb9wDUKl+4fcr+VZcJEyTv3Z7k9cOQ/p9K3DYcVD1vOAXDibJvW4VeHUPG2iCr9ogZWI0iUNvZsr4zAmZLTO7BjEBEe+Dm027AfyEDg30UGiQKIRiKvBf1J3XEfMyH4TSVUYFHYihWNYs9hKj3LAA/ZqM53W6LCTsicv7nkWoREJl7KNhkmFDO6MMUxc0LloDPDWwDU6GdhyUWEMAi0EAGPLR8+JCU+2pS1Vi2fcpQOscJ3H6DQ6Ho5HpaKM8Grc+8wihgistbJp7CA22rnWHRniio8iT76rgO+CPaW26RZqmC1gthULxFqx66X0M/pK1jDoBaFYfkw7uLlFHcB+uUSeif0BoOFou0WJXGadKtcx3+3g4olctwvobK4UV+FWc5y4ImTtr8n0wvbaCHWN0DqVC+uWl+QSZ+zij0BsWK0bXWv6sOjvvIogkoXlk9ncsZOZF3vWiwMTCM0EhjLnyLKkn9P6EoBWDkN1OCebysKxsv5I0ABAXhaZLyYy5o23vT659znTputgExkHtcTPHXOJyhc5pfoWCZG7s2z52YwvA3v8yx69eLP0FAHVKZ38H0xLW7/CwJfrrblKqp6KxQGNCA390t7igLu/QHYT6uz6UykmLbHmhBAT50yORMP7Aoo+8TTX8MF/k7coKU6SJUNjjQveZ4X9ZuG2fAHHavFcoc4=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(36756003)(478600001)(83380400001)(70206006)(110136005)(356005)(4326008)(7636003)(82740400003)(70586007)(7696005)(82310400003)(966005)(426003)(86362001)(26005)(36906005)(8676002)(186003)(36860700001)(47076005)(336012)(2906002)(5660300002)(8936002)(316002)(2616005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 01:25:25.1581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ac4d64-d1b0-4084-f7dd-08d8f9640538
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1606
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch converts text based dt-binding document to YAML based
dt-binding document.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 138 +++++++++++++++++++++
 .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 -------
 2 files changed, 138 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt

diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
new file mode 100644
index 0000000..3c15aea
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/nvidia,tegra-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra AHCI SATA Controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jonathan Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra124-ahci
+      - nvidia,tegra132-ahci
+      - nvidia,tegra210-ahci
+
+  reg:
+    minItems: 2
+    maxItems: 3
+    items:
+      - description: AHCI registers
+      - description: SATA configuration and IPFS registers
+      - description: SATA AUX registers
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: sata
+      - const: sata-oob
+
+  clocks:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: sata
+      - const: sata-cold
+      - const: sata-oob
+
+  resets:
+    maxItems: 3
+
+  phy-names:
+    items:
+      - const: sata-0
+
+  phys:
+    maxItems: 1
+
+  hvdd-supply:
+    description: SATA HVDD regulator supply.
+
+  vddio-supply:
+    description: SATA VDDIO regulator supply.
+
+  avdd-supply:
+    description: SATA AVDD regulator supply.
+
+  target-5v-supply:
+    description: SATA 5V power regulator supply.
+
+  target-12v-supply:
+    description: SATA 12V power regulator supply.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+  - reset-names
+  - resets
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra124-ahci
+              - nvidia,tegra132-ahci
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reset-names:
+          minItems: 3
+        resets:
+          minItems: 3
+      required:
+        - phys
+        - phy-names
+        - hvdd-supply
+        - vddio-supply
+        - avdd-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra210-ahci
+    then:
+      properties:
+        reg:
+          minItems: 3
+        reset-names:
+          minItems: 3
+        resets:
+          minItems: 3
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/reset/tegra210-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sata@70020000 {
+            compatible = "nvidia,tegra210-ahci";
+            reg = <0x70027000 0x00002000>, /* AHCI */
+                  <0x70020000 0x00007000>, /* SATA */
+                  <0x70001100 0x00010000>; /* SATA AUX */
+            interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&tegra_car TEGRA210_CLK_SATA>,
+                     <&tegra_car TEGRA210_CLK_SATA_OOB>;
+            clock-names = "sata", "sata-oob";
+            resets = <&tegra_car 124>,
+                     <&tegra_car 129>,
+                     <&tegra_car 123>;
+            reset-names = "sata", "sata-cold", "sata-oob";
+    };
diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt b/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
deleted file mode 100644
index 12ab2f7..0000000
--- a/Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Tegra SoC SATA AHCI controller
-
-Required properties :
-- compatible : Must be one of:
-  - Tegra124 : "nvidia,tegra124-ahci"
-  - Tegra132 : "nvidia,tegra132-ahci", "nvidia,tegra124-ahci"
-  - Tegra210 : "nvidia,tegra210-ahci"
-- reg : Should contain 2 entries:
-  - AHCI register set (SATA BAR5)
-  - SATA register set
-- interrupts : Defines the interrupt used by SATA
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - sata
-  - sata-oob
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - sata
-  - sata-oob
-  - sata-cold
-- phys : Must contain an entry for each entry in phy-names.
-  See ../phy/phy-bindings.txt for details.
-- phy-names : Must include the following entries:
-  - For Tegra124 and Tegra132:
-    - sata-phy : XUSB PADCTL SATA PHY
-- For Tegra124 and Tegra132:
-  - hvdd-supply : Defines the SATA HVDD regulator
-  - vddio-supply : Defines the SATA VDDIO regulator
-  - avdd-supply : Defines the SATA AVDD regulator
-  - target-5v-supply : Defines the SATA 5V power regulator
-  - target-12v-supply : Defines the SATA 12V power regulator
-
-Optional properties:
-- reg :
-  - AUX register set
-- clock-names :
-  - cml1 :
-    cml1 clock should be defined here if the PHY driver
-    doesn't manage them. If it does, they should not be.
-- phy-names :
-  - For T210:
-    - sata-phy
-- 
2.7.4

