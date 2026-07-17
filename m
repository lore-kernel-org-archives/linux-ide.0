Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA037B40C;
	Fri, 17 Jul 2026 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312760; cv=fail; b=neBn+IjAQZGFaKabwFfg4EHz84zij2MWzhgfNyCTQAHvXKrkwW84WyIG1iqrKWkygIitolq1TfeXQrcfDC5IEO4jf49nPXmt/1N80vIvshXuZCnl2XZCeroIj2fznReYs6aW4Tyn5ioNMNjgC9m4jdCCUtCCvkEsZuQm2jwzI2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312760; c=relaxed/simple;
	bh=LEo9bGNbGi4RntkK3okyYAL6DFHdsq7/bmZF8LhbFm0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IOr7N0GYpMHDd7JITIr5aNS76nkyRrPRgoYInEq7HR3vrSl0buofLh5l6VhDXhA5AuUvXD33afgzFj2AYx9Mj3macID+KUhdjM39b6bnO6If+yKFdF9Ppa1uBABEcuh4Zsvnmk9s1r7uSGUu22TzDTyIbgljvjP+g46nWSA43uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mJB3VvSa; arc=fail smtp.client-ip=52.101.46.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mJB3VvSa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G28apYxaT4jF63Rf0JkgiZRJqmwZrftAp9Y2sboMYHROpIBzF2RyhImIidXutZoMyvMEqrzm3GXUhBIJMV9bOBbjTFhmZxzv3iDD97AZbM5nIdD+G3kRqeLUDlpCFePAGjjI/8mBrkj710CKeoG4vLYNhd6GDAQazGgbD2MSxKW+UGIPXukdmkQbtA1huIaGeNqsjUy6+1Zd7z1vF15xpSRSXyz1Lhi4tYauUUi7V99MJx8bGC5cb023QDk0mcX68BuWAGtSxmBTXrggzDl7vswwxOXbkthav9Ms5dyuS0tkqQOadJPanGOGfpkIxlNzPO3R1f2UJq3GE65h8nVkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyc3zr6/OJ3aFrsGJ+a4JlU2L7NffaRdLUJDGG1OObg=;
 b=bsLzswTwMsxVxXYrK96ts5zY1AoYRyk2NRxWXvZFMZaJHAm3Vgrd/W+h3st6fR9wIwIGed6K1LeKA7AuQ1SY9WvqLZkjUALfRbZGa8nIqcIG9qM//XxOcAS5tkhyUiEoH4SnQNJQOf41eQHYcFCHLb+5h/Udepl/EGT2yZT2I7aeQAAoA6jrJ5mC8EoXYfSO5JoIBsdrURJcdt7psmgULqdvHiknqPy5iGOEMoySGfHCY39kunHrBTP186/TxtQrNAVaIqsiWayIVtQlyasS8048NNnt8B9VSPU9yqMJ+SrDxYkud5/FIcGHLFML4juS9gYFSVDW6qysB5uIGg9PKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyc3zr6/OJ3aFrsGJ+a4JlU2L7NffaRdLUJDGG1OObg=;
 b=mJB3VvSa+f+HJCBOmFEKX4Mf3UsImH1bNSE8rBQBioW3jHHqsSq+PIaou9Esego+PcmZYtw1zSPbcscqa1dWIFdmCqdvUgGfeDcErhW95OahgoBFdKC7FVZ1+sZc1wep8QWut107SQ+sGzlptnHvRD4zqyyyQLTYg6Q5ug1ptcM=
Received: from SJ0PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:33f::16)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.13; Fri, 17 Jul 2026 18:25:54 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::ac) by SJ0PR05CA0041.outlook.office365.com
 (2603:10b6:a03:33f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.8 via Frontend Transport; Fri, 17
 Jul 2026 18:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:25:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 13:25:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 11:25:49 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 13:25:48 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] ata: ahci_ceva: fix error paths in ceva_ahci_platform_enable_resources()
Date: Fri, 17 Jul 2026 23:55:26 +0530
Message-ID: <20260717182527.3414781-1-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d3b47c-fe34-4d0b-67b0-08dee430d60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GXBVaRGA1YraRhy26McITTm80JaMyI8liey9No8oeKDTnQpFD/g7vb6aFva8ZFxeh/vIO/TIydJ8lcI/v69o3npPlpkwTC6SYzOi5O5iCwOGD5Rilzxh6fxKnoIpQ7CnGtLzj/L5c/UTuVB6bM8tVhif8M50rdRLGRjuBEMvMyKI2mii6mDDvdYGRd+3C8At+Pbcyr38PMo2h+gwzJM4qXNcnbkI8NagZdo2SZiDwdTyoTo1iEOqX4R93DZNZmu9cKbsq5Ed1C3WZQIPix3oPRIE+xorYbJOaDRSHnTfaOfTVA6a0vFpkbtHeAZFhkT7P/uijA/MTh97WRw07msyb0H3rsH0LKbi+JZA/YNiZeMehqtfOy04z4DOPjWJpcdfhb/puZhztif2F9BDwMIZG+jc8XKLESH9RubQ+tc5vkmPQzK9wKzB8WraGvxGqsrs/l3WnK5FL53DspkjdCRFJw1P9wC2EOzaSZt6B3fhWzw49zwbV+6h3O+xq1npCJmqhwcb2JRD0Jfljrl70AMFbclBKPy6lA3nr5GwV+Ne70rhF0l5Cy6BzsavIuccKikXP8MmY4WLUokp/vSr45p/xVGvtT7kVS48x36uiQXe+NZs9cTXnEzN9dpull4w3La7bG0rVlAQjkN3Eibc6g59LRipnsfDKeTkg6+PVyj9N6dNOSnf9VQ4FjlOVhUVRuQ5MrlAhu79rJG3v1QczhMAxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jb82I+9LLtIR5aARxymHeFplBQQ8HltmmOxijX5tngsDGUUKsaj1k8o7UpAUBvRciRlEACQSGCKyrODoXVTYW98My7cUA6KLgCFJmzEadCrJPGeV4/Hj1Xg5uMluZu8JKUShRV6GICvxS8WmlI3Ly8lE0Mz4InuouclLw3MnuaUxawSfD5xzBvx+9yvGkofbsnmb9vGZJ7YHSiUKEtJduo2/qtp1Ed6hk+vwwFETgYeJmDyqHX2CtaHV9ykq+iOBrdXnNPQDN7/R3r6UqOs+lL57kmrUodxn7+k8yOnWoMFR1dQt/kxPmuLATvUqbQZQm+eDluMLHqSKwf0MUdGcNdjcxcCqDmmzwytWIoyeU6aKIdOJ+7CI8ui1mQefBlubx+zA+jPWohXMBvkKdoW1Lqbgp2aFA+UK/TAzxwNNOTRe8sOajqvasOjN5vPAFxTx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:25:53.2437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d3b47c-fe34-4d0b-67b0-08dee430d60a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010

On phy_init() failure the error path fell through to disable_rsts, which
deasserted the controller reset and then entered disable_phys calling
phy_power_off() on PHYs that were never powered on.  That corrupts the PHY
power_count and triggers an extra runtime PM put.

Use a separate exit_phys path that unwinds with phy_exit() only and falls
through to disable_clks while the controller remains in reset.  Reserve
phy_power_off() for the phy_power_on() failure path only, and skip
masked-out ports in both unwind loops.

On phy_power_on() failure re-assert the controller reset before disabling
clocks and regulators, matching the teardown order used by
ahci_platform_enable_resources() and ahci_platform_disable_resources().

Fixes: 26c8404e162b ("ata: ahci_ceva: fix error handling for Xilinx GT PHY support")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/ata/ahci_ceva.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 2d6a08c23d6a..2961e53288f4 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -211,7 +211,7 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 
 		rc = phy_init(hpriv->phys[i]);
 		if (rc)
-			goto disable_rsts;
+			goto exit_phys;
 	}
 
 	/* De-assert the controller reset */
@@ -230,14 +230,24 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 
 	return 0;
 
-disable_rsts:
-	ahci_platform_deassert_rsts(hpriv);
-
 disable_phys:
 	while (--i >= 0) {
+		if (ahci_ignore_port(hpriv, i))
+			continue;
+
 		phy_power_off(hpriv->phys[i]);
 		phy_exit(hpriv->phys[i]);
 	}
+	ahci_platform_assert_rsts(hpriv);
+	goto disable_clks;
+
+exit_phys:
+	while (--i >= 0) {
+		if (ahci_ignore_port(hpriv, i))
+			continue;
+
+		phy_exit(hpriv->phys[i]);
+	}
 
 disable_clks:
 	ahci_platform_disable_clks(hpriv);

base-commit: 1a1757b76427f6201bfe0bf1bea9f7574f332a93
-- 
2.43.0

