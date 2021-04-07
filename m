Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68522C43461
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 01:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7F7613A7
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 01:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbhDGBZp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 6 Apr 2021 21:25:45 -0400
Received: from mail-dm6nam10on2075.outbound.protection.outlook.com ([40.107.93.75]:39137
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242655AbhDGBZh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 6 Apr 2021 21:25:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm04rktdZaP/o9zI1pkRPWNzySiVjdEu4eVrbdg+eHg/mGpYiu+nJPjZUWRo6ZniC+3cbVPpxGKQDN7RdL0+oVNsCb4MN95AbGXO53xCEw0gRiTPqt7wplFX63CaOiFB4TWzG0wyp7RxVosKSfSSwN1GYueNZqg4BLlCbftnet16+z/DElCkhTJrPKfdDJjXSUo0nQ6TYCylhVXwyNa9OKosoPe909dSQkamUodKUfJDb0KFm/xYpA1cRNpqcZbelFjsADfiYolYKBo0KKNaxYASuUKgOa8NO6UQ3CGa/Z7deElq3YPFPXfGTirlzgIkwfW/31FUyusBMGSloDBUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuoDnHcnGhEevhf1Zh/7gdjVQApYfl/WHCoySUA+VnE=;
 b=B4zd49akE6BcofpLG72RmTDUhqv5WNjbrPLW88h0jhpz+iF7COwN60U8zDetGar8jHLxorIDHHDKKG6zoF7V4TCI8A9xcGpcawrP90kgQdHKtRrBhyW+UGtFbtVlAAqbTq2/qjjpk0oiy01r5uxnrlO+5hKmLZLf8DmAvKHkxatUV+0nYkq/3n9fuYjmKWs4x9BzpCWCeiHrAGPMIxnmE0sv2Vx6O2s+l5jZ2H2MYF+M9eqw4LCe7/iNwaT/8fxR1NBn0G8ms9NiOCExQlp8ej5HS5/6iu2gDIVx0hZ2JzIx6Jx2M5UYtZavpJ846dnfmoPHdcwlNQVnbdu8u/4BRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuoDnHcnGhEevhf1Zh/7gdjVQApYfl/WHCoySUA+VnE=;
 b=OdZPpoG80oza5kqmEl4uXh8NCRit9TMM0KM6QEWkpZvj/n5xsEzTqG4m8FfHFJM7wnthVjYWPHcqgZLL6Vw+yVE/ltXkuV0I4MTKh9qxEKeR74hrzX9qMcmU3MoWlNGkoctBh19LtP8t1HQqPdTDt8gfSzt141Wf/QJNvMXAwYZ/oLVDb6ht0VWIQhwu06Hs6cUI4taq+rYY2WyKybKL/63a4q7SQgE00wDBPLtOKk6cepcnDrj7rCywRbPMorY2GJz2dAIUIKBqKdoy/B/Op4wfgfkuBtQ2OG/q/Blyk5TntHMBJ54Gwcvbhd138OQP7YSoG3AEfQjNe5Tv2xOIaQ==
Received: from MWHPR11CA0036.namprd11.prod.outlook.com (2603:10b6:300:115::22)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 01:25:25 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::c5) by MWHPR11CA0036.outlook.office365.com
 (2603:10b6:300:115::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 01:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Wed, 7 Apr 2021 01:25:25 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
 2021 01:25:24 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 01:25:24 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <axboe@kernel.dk>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] dt-binding: ata: tegra: Add dt-binding documentation for Tegra186
Date:   Tue, 6 Apr 2021 18:25:30 -0700
Message-ID: <1617758731-12380-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e7efdf-3ff3-44d8-2946-08d8f964052b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4444:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4444F6E16B5E59FE4D01C51DC2759@MW3PR12MB4444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCUhHhpgdT/nfrz0bwQdMxTALZklbrkeeT5yoMbGh7UfTI3GE66OaKvwEyvk1t6L4R7uqdUaalGJcJntEoQHDSxN2vpdwclyEVozZdLJY2DOTP0IMnOqS/LxXeBWevjAfhoGkgUL4gEqBAH2CCgeX+so686M85ZKfvEGXMvT8Fw1ZLY/bq0NSS6qTk+IuSkH76iBs3QBcf69M1av51nejFYVc+He2F6aO7xtaAr7+APwPe3S0lakpy2M+q3umlRSOAq/mmXFi54eN9fe6CLdoFO0i3nVCGqr2N0iQubGJducn+85hnwnirMOus4GDIQTJa6XqAldkcQd/mLpEnedTTIyllp5/Q+DqFiiu7aiGPtsdCFJRes/3tscXcVN3dJ80SHT/f5JzLtP4UZHxcrD4y9p0cCBEJdNhp2jQACO3oTWfYyL9n7TA5ziuIhsGCMLuh41Fv6cncgyLrQbdq893vON4rT2z8uw/e0wfe7r9NWBAtA95Vqta/bigl6qOGMAkmMD3/0LQrX5O+j2l6i2XbBNYmJM7PgEawPEb+G0RKpIipjAHfR07BzyfRtk/KajLrhrdAtPoMHT5yu6sauUXbequtvt4g4dWoR0PqNlZIoIWyLkWYnpBXg+HIJq/ghL1VpPSdSEdn26Q2H1AoXkCIxPrAar2ApbbBdbGjzGrxY=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(36840700001)(36860700001)(86362001)(2906002)(82310400003)(8936002)(356005)(186003)(26005)(4326008)(47076005)(2616005)(36756003)(8676002)(110136005)(54906003)(316002)(6666004)(36906005)(7696005)(70586007)(5660300002)(70206006)(336012)(478600001)(426003)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 01:25:25.0676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e7efdf-3ff3-44d8-2946-08d8f964052b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch adds dt-bindings documentation for Tegra186 AHCI
controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
index 3c15aea..a75e9a8 100644
--- a/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
@@ -16,6 +16,7 @@ properties:
       - nvidia,tegra124-ahci
       - nvidia,tegra132-ahci
       - nvidia,tegra210-ahci
+      - nvidia,tegra186-ahci
 
   reg:
     minItems: 2
@@ -37,14 +38,31 @@ properties:
     maxItems: 2
 
   reset-names:
+    minItems: 2
     items:
       - const: sata
       - const: sata-cold
       - const: sata-oob
 
   resets:
+    minItems: 2
     maxItems: 3
 
+  iommus:
+    maxItems: 1
+
+  interconnect-names:
+    items:
+      - const: dma-mem
+      - const: write
+
+  interconnects:
+    maxItems: 2
+
+  power-domains:
+    items:
+      - description: SAX power-domain
+
   phy-names:
     items:
       - const: sata-0
@@ -114,6 +132,26 @@ allOf:
         resets:
           minItems: 3
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-ahci
+    then:
+      properties:
+        reg:
+          minItems: 3
+        reset-names:
+          maxItems: 2
+        resets:
+          maxItems: 2
+      required:
+        - iommus
+        - interconnect-names
+        - interconnects
+        - power-domains
+
 additionalProperties: true
 
 examples:
-- 
2.7.4

