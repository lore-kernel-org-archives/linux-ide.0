Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F31C433ED
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 01:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BBD613A7
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 01:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347695AbhDGBZh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 6 Apr 2021 21:25:37 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:56577
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238346AbhDGBZd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 6 Apr 2021 21:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvV/aWlCfyA/UABYr/uue6D0JTthzUywrKoiPQLnoxTFB/PMggbfb2zVhdvTXjZ/Y3lCGlozG1YKQQ8d+p5Kx0qWtuvwmjBE10QJE5FGfAEWSRBTUUvGkXZyDyPE6JuLNvRD2LGVMkA+V4JiDSqqf1G9iMafWCUnhdGqVZSy40iG/H8JAjr/9PipvOKC7lUARJll0Ap/TJomyEu2kmNHsFowLC/Qxb/YCV3LfRLD2Txkz6X6ttoChrehsevewvtmJjUbt9TKN0xoMz4NXIQE6MCop5X7lXeqtTBynvFSGLFxwab9O58BAzIoNJKDOup+B1N6dUEuxQqKU/cYyWLiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJix4WfNsLZm+lYekpRcrc3AKl0GDdBVxZMlDPsodU4=;
 b=QSOqXMyUYdQH1j7ygDva5lKcJjWjNlMGv4aZNDIr0hH0M+T4naTxUa/om1ffO8eQwBn9JVgULrOWLdf5qDaNtZJVvjTsQuSg0bsm/xKJyaMwx4Ow5LielxyRD9JVmNs1mv77uUY3ucD983ihcYgHg9IAvenMz09YCLYwhXJz8NTikEqKkNVlY3HsnMb28Qfje6Usw7FVChxRf9oFByeCVhfwwQosDRT6Dsg94td+Fneda2moLe8gfUk2x9qwP4CACwR6VAaO3PgFuHtzpR40ltxiJ2FSzPU4fDObbBL2iOZnzPT4PLFI6nEBj4M1aQe+0+QDJL11u3wCXWZFwg1PnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJix4WfNsLZm+lYekpRcrc3AKl0GDdBVxZMlDPsodU4=;
 b=BRYJJPgxOC9EsHsO9lfzvY3k5W+Z34DwTJhS8g+bY8d3ibL7blycByb0ypFFaV663WeH5fBp4mxbNEIN//siYzAE/cWrkzAwANQQoavtLg4OAdRlmQ+vgh37+t3LlYMG0d/1ovk5xTbZytfMke95CDATbTfcKRscTtI7NnKjk7hCKY+CDLWrIzCo5oE+QwbqxKPAAdixMstWzk/HlG3yDNQfmPeLdAqWEeeUr/Vu4DgxxxTsfVMvC2jZseIWfcX3NOC+nezAmcVLGJaoSpNFjod2vRNaKvDFIFNjM6IqJeVOVMXHs6nGRLQ2ONcRQUI6jacW5J21I4VbzxsBklw6cg==
Received: from DM3PR12CA0121.namprd12.prod.outlook.com (2603:10b6:0:51::17) by
 BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Wed, 7 Apr
 2021 01:25:24 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::b) by DM3PR12CA0121.outlook.office365.com
 (2603:10b6:0:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Wed, 7 Apr 2021 01:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Wed, 7 Apr 2021 01:25:23 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
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
Subject: [PATCH v4 0/3] Add AHCI support for Tegra186
Date:   Tue, 6 Apr 2021 18:25:28 -0700
Message-ID: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7f855ae-9b89-4f35-9d28-08d8f9640483
X-MS-TrafficTypeDiagnostic: BYAPR12MB4791:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4791A7EE586779736D15B535C2759@BYAPR12MB4791.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cI49pfR0p9EKsbg8B3OX/d+OcX1mLgRu/vEb9S5BXi63MJ0KJFI0hSI8Up12XvvD5jCJ0rnpSwDcRuPfVrKmgb53dApQlLbEVX/L9RoWOgESl2eF2kt/o5No1foBgGplVULediJ7gD8diTEf1cpOzi+eWMfA7YPrLC5ccIRpON7xdkxKE+9IuYCeCfZ+MwOuHK6btORwN0gaUPmMFIffFUH9Gh7rfHZnoNBBJ4Sht3Xrd0pFhPiIc8EBfCzi60HPfYR8KMLRKsPF5/yCXwnNbp2FZ2QEEGci9gmrvnibUwGSL5wcXRv4fZqSKgmOU/whPv7Wbq0Auo44rpsMxqonYg6I3SILsy0nbe9jdVVvNsmbbRSnljffG89Vn/Ks+tg/C10MQx/0wa4b1Z3yLMbgzNIGEsuAoADcl3cU/R+wf2MsfzTiUaS6++gUcBzQybmxdlFOf0jAA4hpysJuyZTXb0aR4cksrgtOPFdXtgXp/eqw3VkK7ZVcIB/uzGMXpkdwyKU1Na4rhumPi4f5YtN/O50r347TYwlLzyd1sBCToLq/62zgOocT22MZXRLwJIYzY2iubhHgv6/Ovq0zCQustdjJ9SwVStSA9WHmn/dfscruxoId9jqw25asj8W/6q5DzO/5eP4+G0Tvnx7qM53Pmw==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(36860700001)(478600001)(83380400001)(2906002)(8936002)(36756003)(7696005)(356005)(7636003)(186003)(54906003)(110136005)(426003)(2616005)(82740400003)(5660300002)(336012)(316002)(36906005)(26005)(70586007)(70206006)(47076005)(86362001)(4326008)(8676002)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 01:25:23.9705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f855ae-9b89-4f35-9d28-08d8f9640483
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4791
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Re-sending dt-binding and ahci_tegra driver patches as v4 as device
tree patches from v3 are merged but not the AHCI Tegra driver.

Missed to add Jens Axboe to mailing list in v3. Adding for v4.

This series adds support for AHCI-compliant SATA to Tegra186 SoC.

This series includes patches for
- Converting text based dt-binding document to YAML.
- Adding dt-bindings for Tegra186.
- Adding Tegra186 support to Tegra AHCI driver.

Delta between patch versions:
[v4]:	Same as v3 except removed device tree patches as they are
	merged.
[v3]:	fixed yaml example to pass dt_binding_check
[v2]:	v1 feedback related to yaml dt-binding.
	Removed conditional reset order in yaml and updated dts files
	to maintain same order for commonly available resets across
	Tegra124 thru Tegra186.


Sowjanya Komatineni (3):
  dt-bindings: ata: tegra: Convert binding documentation to YAML
  dt-binding: ata: tegra: Add dt-binding documentation for Tegra186
  ata: ahci_tegra: Add AHCI support for Tegra186

 .../devicetree/bindings/ata/nvidia,tegra-ahci.yaml | 176 +++++++++++++++++++++
 .../bindings/ata/nvidia,tegra124-ahci.txt          |  44 ------
 drivers/ata/ahci_tegra.c                           |  60 +++++--
 3 files changed, 223 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra-ahci.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/nvidia,tegra124-ahci.txt

-- 
2.7.4

