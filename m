Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36B6C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 12 Nov 2021 20:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A411E60F93
	for <linux-ide@archiver.kernel.org>; Fri, 12 Nov 2021 20:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhKLUSl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 12 Nov 2021 15:18:41 -0500
Received: from mail-bn8nam11on2053.outbound.protection.outlook.com ([40.107.236.53]:30369
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230235AbhKLUSl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 12 Nov 2021 15:18:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwQBTnQuajykTv94kE0XRPcxvKAyd91VOztkVgCBKWokHeXj+oZLbnBtiyXMVNf/KumF3WBgPVxtnUGbLxMZ7sF68hykDcRXullf7qEQKqlBsdhmenHMpCl86wVFvIYGGIipcRBKvOoSvbEs4yCrQc6SekYXRM10+ItlsxugA2ZLRgP2c6BOSgo7U9Sf9e1Sg/6Es6ziN0wpEsD/x8kD91NSMp+z0jjskDkwOwsf+TNpsHDG2+JPLE21RGgEEjUURveBVJyIILKCZB2blpgPSyyU7Yua+PuLFhlK3wrrCIPlgGThS403UHosnE7Lz5qmqp4MBq3cfHrdm9LgDQtSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDw14s7iChUNhdZtf7kxAvagn7yz0qHaNZuBy142+Xo=;
 b=gZDKAkqpHLnyJxALI5gmxBeaCqQPmod5g0qZWhhSjvdxB417rvVfEvrYf/JQTgUtpgak6KmK7b3ZGBSEylJDryXUgj0BOgAuyXs6ZGkiU/zaatd6vk94WX+vFbGjW73hZb/awlp9Ef18nA1LqQbZLLOIAEPZIUEGM82v/InIx7QJf+z3O3dOz6fM+Rcy8Gg5fF8dPXZy7qP4F07EEo3j6cs/+tTFQ1HVJdxHwDnMWwHVNsBcNkqbLO7wuquPDKX9xedPScPQJ6Gab5O6P75EAtM0WLj2BNsfYzEnd6C958SpzDv+0YwK0L1vXJmDL9H0LRyxJm4VH4l++jFiqx086w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDw14s7iChUNhdZtf7kxAvagn7yz0qHaNZuBy142+Xo=;
 b=Ep60bFRHv/zmEmvlPlBtIO5j4Jpb5n7PRz1MYQKEYAJQM6qQll+fibGnGN9PULKBN2+PoCo3eN8xCSh9hrW4xLNKzwpGlnrY1sDbeguOkTgvdjJV0RmEWVUzVKMGX+ywUwMwd2rqEObGLD0x8K2A3oJwv4ws7go2Nkovk3fMizI=
Received: from DM5PR19CA0029.namprd19.prod.outlook.com (2603:10b6:3:9a::15) by
 MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Fri, 12 Nov
 2021 20:15:48 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::70) by DM5PR19CA0029.outlook.office365.com
 (2603:10b6:3:9a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17 via Frontend
 Transport; Fri, 12 Nov 2021 20:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 20:15:47 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 12 Nov
 2021 14:15:46 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
Subject: [PATCH 1/2] ahci: Add Green Sardine vendor ID as board_ahci_mobile
Date:   Fri, 12 Nov 2021 14:15:38 -0600
Message-ID: <20211112201539.17377-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1650ffac-ab83-4d16-6013-08d9a6193732
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4205B93E7E748CFF907BD109E2959@MN2PR12MB4205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGdirqfcBMhT6Tbizy4fOydr+KjFvc7Qfh28Ck+lNNYXqHsdr45zeRibbUkkaG+y1yclaSPcomXMeWnYpWjb2xg9xSHdKoFO/UDMofd4sB8bMxZKtj71yG60EXkhUw01v7SDioXklRP16QTGk1PI3W17lpeKX/qfDLjfx3Cma6yM9bbz5y9JfaZEtRcglUdvaV6ARlPJpfSDdREN/PF2xscQWH2+PQzhIRoIJiGv1u7FZbsqhs2ZalI2vEipBxnvvLcXmv01mtxTMw3z4ktSDeXtceTwJhBi7IAjoNCouph9y6TCw7Atu+2/Y7uILvz1F/quzOAxVDO+O4XetugZqM6x7A7OvnL95NplFYmo82CyANdJyQcC13exMGzVuNET259+kL+38QUFf3PDdoRAJ7HrsbVuPlzNjYltwYsdX6k7zYS6sUJvQic395PBQrcwsWzPb7LdIU9aDjB4PNd2D1CLPdmSvaIB0s/eC4Yf8vYeNMkTzhkVPjofjYTWkHJHs+Ro8RghNnQ90qqC8DXRaZ1m7ltoOzIaHiYLA0xfF08AoaDJUqj8y7U1uDxnMelCF1UDy9xOCBNtTtJXEfHAKgXfIdc0kTclM67dWsPGRqK3NkMvyM/E+ovRbPzOlrdHgMfYv6PWsGLoe3aAot/uyS8379x5n6WDZIJlzrgS+E5lFAYbVqnykZDxyEfgC6M4zKelrqPq0f9RrU2uPYG1Aiv4Cik2Zj/cmcT5tNcwjzVW3q2hvX6/xWf/OVMW2/OOowDhamLAKTiUXbxB3FB88BIJFRvq+FBTqPBLqKCTPRhMtSdV28AAMeamS8FUbiEB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(5660300002)(36756003)(336012)(7696005)(8676002)(70586007)(2906002)(356005)(47076005)(54906003)(186003)(44832011)(6666004)(36860700001)(1076003)(86362001)(6916009)(16526019)(2616005)(26005)(8936002)(508600001)(83380400001)(966005)(82310400003)(70206006)(316002)(81166007)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 20:15:47.8987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1650ffac-ab83-4d16-6013-08d9a6193732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

AMD requires that the SATA controller be configured for devsleep in order
for S0i3 entry to work properly.

commit b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with
SLP_S0") sets up a kernel policy to enable devsleep on Intel mobile
platforms that are using s0ix.  Add the PCI ID for the SATA controller in
Green Sardine platforms to extend this policy by default for AMD based
systems using s0i3 as well.

Cc: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d60f34718b5d..1e1167e725a4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -438,6 +438,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	/* AMD */
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
+	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
-- 
2.25.1

