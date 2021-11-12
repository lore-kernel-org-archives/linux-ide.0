Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D93C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 12 Nov 2021 20:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B084A60EC0
	for <linux-ide@archiver.kernel.org>; Fri, 12 Nov 2021 20:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhKLUSo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 12 Nov 2021 15:18:44 -0500
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:42980
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232902AbhKLUSn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 12 Nov 2021 15:18:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAoEjFYTmhL8ynS+wy3vWmgcurSlNpGxU+YRjWs3S6qVdoGNONYzF95H+LtRskiob9S9LDDQOKT/IKn18GbC7RD23rqaSWo3D+jUxCs96gAVbVNmrTTO6Kwp3jdf22ogNxN8Ijo2gQFrkZ4tutAfaO7SCcRUXGvRbD4OVBFMe0LbWWRbSoaA3RQv3WXy5SBiDZZj/+SfUKxUEC3/7PoGSq6SO0JxDy6DNsS3r75As5cPxBZJ/ZCev04ra+xJPQZ8AUpOsdDEOTTF5V6atqloiqtpbR5S/U9hKk3oqs91S4CVuHhVZvg6P6Cpv+ObIS+2/nTY6sOiGvIBTXMm0Vo+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZi3mFQ8NjQm7ZfSL9XbEonNJpNMKNWxQFFu2zqPtoE=;
 b=SICCvZrRcGSWjsY0EmKpGebpbBMiucDb6NbNfVcWB/kj/srzv6QaS4QepUfsIN+aUF8wmXGJrd9AEc1VdwndBjoXZ02BycqsVlImx4sreDFj/TWrBGK62jYyJyD/Fh3ISirYrVs3cfGwGDtmm29FdgTv/xPk1mwp1h+kt3c8e/5f7OxpXYfomicEpa7uk4V5qF3GdatRij5mTogp3h4am6SVCl27tWVmY9cLUwXtH5I/Iw52qSTRJGPJEVodm/8zl9punRKVtftS46pV0UrpFsSrCca6yUrDuaB+jSFZOpAjd+5xGmxmrs1fF3tTNiX1+bjCKeH2aPfJbN3mCsSA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZi3mFQ8NjQm7ZfSL9XbEonNJpNMKNWxQFFu2zqPtoE=;
 b=PVzYa2PDE4xaIeGJ6sDfnlWuzC3FIMOhNsRcxi8ow+rMhy9GDgX6zqGGDb4Z0t22a9sxxSj+xLgsJHknyd1zAQk9QKOH2QKkXfRNaWVQGrQROqVDIJgrIls7kvY2aOctx51jdyaNFBka9BjtIMcnz6LpR4RKtyBloqitjzArmko=
Received: from DM5PR19CA0028.namprd19.prod.outlook.com (2603:10b6:3:9a::14) by
 BN6PR12MB1890.namprd12.prod.outlook.com (2603:10b6:404:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 12 Nov
 2021 20:15:49 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::79) by DM5PR19CA0028.outlook.office365.com
 (2603:10b6:3:9a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend
 Transport; Fri, 12 Nov 2021 20:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 20:15:48 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 12 Nov
 2021 14:15:47 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
Subject: [PATCH 2/2] ata: Adjust behavior when StorageD3Enable _DSD is set
Date:   Fri, 12 Nov 2021 14:15:39 -0600
Message-ID: <20211112201539.17377-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112201539.17377-1-mario.limonciello@amd.com>
References: <20211112201539.17377-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c4133b0-c0ae-4705-c5b2-08d9a61937bb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1890:
X-Microsoft-Antispam-PRVS: <BN6PR12MB18908104A992AE73B4EC37D6E2959@BN6PR12MB1890.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Re0c/VB0Sxh17bEJy1lmBEmvefoawZTFvSY57RuJ8M4gQ3beRW6RZp1apa2SJSuUHpXrJ8T3iN8AUXQcjkuaOFgwLX9wd3TGHQA1yD9LMW3pfttHO2n731RV0lzSYKkt0yaIC0rLLcaUnpDkAR9xh5S7gtnkJi0KN9YdmwcqAx/5YmJxrH444XDw4q140/oxVxn8W+df3QFdU1dDMfryDtePimodEOoAekH2H609Y8fwYXVRvVX5QAwxoNVmWJIHevKU7NnFRX5fm3cFD0K44m3s2xmDHm2IUGqZTYQd5JqDY6gNtqGwFWj91Ny6AS0w7JTs8PmgkkHZ/HReVYbdKhuYHyeH76P2y53zWEflDgjAFvCTN5iZBOfPEoPyKE4N4suJ1BdkNRly4MHqnsSpiFy7j53VIIOOFE6Jqi9RrK0jzd+9us2Z5H+oBsqIuVs2wLZfqodb+mJe3y4K0CAIiRS9YJ+3HcaiKAoH68kSXezh9V2ARHY+ii91A5tm7xRoZmLqBIcYDu7mGkSqm3MKescJOD6ex0IPPy8ExY8dXdMYh0fAkR4DHdTNeDnG/+/0eeA4hr3nDmtZvHVC0eU+8Ul0UrPqG2a5Qd/MD5ADREps+QjQWBYGXPnoY4cY/OZJV17drpZ8t8Ptp+eNjEWOlj1L1W69tq4tDuu9FDvve+p92iwbssJMW5xTt0WGo1wfebkaM+Z4r6QQEUYEWhRSx8cyUbWnbmHyhvmBLNRiF++lopqR0WA/a2IDK43XSYHZIIdtepGmYqYp8LqQHeKh/z+I6IVgemVSEVrqzcEcGobrI0M9XYkhX33HrknqylNjPY8Y7N6xUG23eWWhkKVrGOXyqSSwb80lWOGjeazGeIU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(70206006)(36756003)(6916009)(82310400003)(508600001)(966005)(83380400001)(36860700001)(70586007)(4326008)(6666004)(54906003)(86362001)(186003)(44832011)(8936002)(316002)(26005)(47076005)(7696005)(1076003)(2906002)(81166007)(5660300002)(2616005)(426003)(336012)(16526019)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 20:15:48.8022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4133b0-c0ae-4705-c5b2-08d9a61937bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1890
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The StorageD3Enable _DSD is used for the vendor to indicate that the disk
should be opted into or out of a different behavior based upon the platform
design.

For AMD's Renoir and Green Sardine platforms it's important that any
attached SATA storage has transitioned into DevSlp when s2idle is used.

If the disk is left in active/partial/slumber, then the system is not able
to resume properly.

When the StorageD3Enable _DSD is detected, check the system is using s2idle
and DevSlp is enabled and if so explicitly wait long enough for the disk to
enter DevSlp.

Cc: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/ata/libahci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 28430c093a7f..15c293da30ca 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2322,6 +2322,18 @@ int ahci_port_resume(struct ata_port *ap)
 }
 EXPORT_SYMBOL_GPL(ahci_port_resume);
 
+static void ahci_handle_s2idle(struct ata_port *ap)
+{
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 devslp;
+
+	if (pm_suspend_via_firmware())
+		return;
+	devslp = readl(port_mmio + PORT_DEVSLP);
+	if ((devslp & PORT_DEVSLP_ADSE))
+		ata_msleep(ap, devslp_idle_timeout);
+}
+
 #ifdef CONFIG_PM
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 {
@@ -2336,6 +2348,9 @@ static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 		ata_port_freeze(ap);
 	}
 
+	if (acpi_storage_d3(ap->host->dev))
+		ahci_handle_s2idle(ap);
+
 	ahci_rpm_put_port(ap);
 	return rc;
 }
-- 
2.25.1

