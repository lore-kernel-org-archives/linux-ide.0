Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013045.outbound.protection.outlook.com [52.101.127.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0123506F;
	Tue, 26 Aug 2025 04:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180953; cv=fail; b=HpLkpGxQmSct+0zBfqMOQsy/w0KmyhdzrUtDNdXYqF62eHmzYVzJ0jsaex7EJWl4TJrkOdlzXi8ZjdPeCwtzVnf+XhhXb/vta4QtsjwZ0wFlx/lEQ4s9rUy95aQVNt8AyWnBbswpEb0cPEEKFtTBXpcPGZjZSponusko3wMN6pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180953; c=relaxed/simple;
	bh=243RO3KvQH41YhgLrZ8kQylF71BkcN2rpKaL5SWDl1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D8I3MaNCh53L7dSb+43lQ9afpFAHgfLuadRLGzKKyoJMcH91VykpGSAdpDoLiWvNvNy9TjL3U78i7GPmKJUdkw9dsWZLDlOq476pkht5dmuYizkOeEIe40+6KLjYIRsRThrseCAp5rcHKfefZfNySVd9ihR0SjUSpPGWqvvRbkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cbpCUrp9; arc=fail smtp.client-ip=52.101.127.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cbpCUrp9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHlKX52xxGbhYTaorDezo3tOTUKExAvGOqt2vOQOSWYEiKQ57LDEmdnjb1/XVQ15KI4ZjuvgSl95DC8RTOWKs9fKrJjgUiTw2opMfUaz31oSh8j6HzHyhVhJY6V3OqTbsFuzcszHrq1yjELygUMXbJjI923sRS0drvHsn73vzCs7Asc+GDsswfZSM8kvtW0aNVD6tUHWGPWXC3nNdFP6hHZq96r5XIFfwdlylhPnyJCXUOO2GKk/+TPSjafjNvpRjJcky5A4R2Ny1oaM2cU1cyr0j6mBQ1S0JgbmbiXhHmQm8pHfDsDtx1HfZlDKan1lGQwKUYHeRiDT4b+3JMKLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmdHfKNtGC9mREnQYyOq2JObaAn2tr6btgtH8KtK3HU=;
 b=cSvGZP+14vW2shGHZxe8KvJTCbPteG/d1muxMF701HHSGdFI5O2c/zn5rB4ZgipZIpGtQIkap0UeqzpEArhlN6aGUW7kFeELt/Gkq9fzquDTMgiDyZa+nJI+LwjDx6F3B0fGTDAeRy7YPxLjkoVBG2tKelDeezZsXdy1nDNxfgqTxV/rmGBlIhOlrxbt1eiBr0y81DOFgXZdXVEWIY0TrHFcY8sw+LK8R2Xw4OiOPcWxIDv2vuS75FQJxFW0AAR8MEH49I/61+pah3F0OSBHBruCLb/+/CxAuG4Z0ouurGt8ln5STodQT2DMtIzx4PqChwst8FxhGiHVntsvg7g9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmdHfKNtGC9mREnQYyOq2JObaAn2tr6btgtH8KtK3HU=;
 b=cbpCUrp9iS6VIHY2wlwyLd5g7ZkJFYtVDnI2BpPi0SZwzCtadJHaPH5V1yeUxi6gs1TfUplSfbN969BdXtshcu2e7a5bB1kTTpyRfszEnpZk4njopgx3rb6JfmP/fQEpKkpbSuTgtENrw5YQPIZjJ5J/XOSsEr+oo8k7ogrBhyvCF0uVXZA2FsG75ldeYA8dl7AIWKg3Ki3+ZV2EPLvu632hi7rL1/QV9NcroP2LDtFJiRDMfChHI/L2G8luqwTQAOsXIQKA78Br5zpZaIiUWoN5e42Gj9x3YCzyqN6u8+6cWsszrY9vCuLnn66ooeme3xOMnxFiD3meGTXiklxAcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB6526.apcprd06.prod.outlook.com (2603:1096:400:481::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 04:02:28 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 04:02:28 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] ata: ahci_xgene: Use int type for 'rc' to store error codes
Date: Tue, 26 Aug 2025 12:02:19 +0800
Message-Id: <20250826040219.133959-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYSPR06MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 99185905-5e5d-48bf-e9da-08dde4555f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?icQZ+vsUjxKHBMgvY1sBiJ+0/U06ldQIkjQCWwzPWwErpoVcjFb0oHoW+dc6?=
 =?us-ascii?Q?wULzk/+OaBNjU/htYECGO8w+8IgNF8tFaakAh7mppxmi1MxXHrOuGrLhwlDV?=
 =?us-ascii?Q?2g0SKpQWsL17jgHzlipZh2pYV9BsETRfiUYFMFgE64+ONvq+dUAeJ65OU5B5?=
 =?us-ascii?Q?J8ZzxCyOEcNgLLSejw2lW329NsDqQM6EtniGELB8dwzjVRa/Jg4+zKPErrNV?=
 =?us-ascii?Q?k4zmt1mp5HQLiP7h6u2X+gzf5mTbbiM0/65AZbWqpuF57KmJ/Zo6DGFB4XA8?=
 =?us-ascii?Q?JqywuKSU4IwTfIVdEbXOwuJmUyoD0CSUMRfq2/S5ODEVp3slWnT0hx3RMXGm?=
 =?us-ascii?Q?MMycwIrnyEE1OFojtPSSOCvtvxFedg8k9cQexeOQ1cbIBBK523inZZKihKZb?=
 =?us-ascii?Q?oGVGPzPLIFfVPwsHtibP/DDYsRon36NN0OeuXxQuQgGkZpcCSPlqzkba8g07?=
 =?us-ascii?Q?nulE2TKDi8PqCdDjb2rp1AaFxi7tczcRmUIb5WETjo8IZDPJ4mWIVeKWsQvE?=
 =?us-ascii?Q?J4lDgJG95oAR44OsqQBc7x3PZG0l0YTgmK7ur5kKVdyqTZqMTGknckd0mpQc?=
 =?us-ascii?Q?4qqE9u5+stnb6UwBkzPtfZaJ0PLRX53LK29iqGqUEJz3N1ppAHFC4Vpe4YdR?=
 =?us-ascii?Q?FW+0sczTY51SXgqfHtI91EGEag7PyK5sNlbN+eTMpOSgKVdlWg407QyqZqX+?=
 =?us-ascii?Q?eVlv4Kd2No5dV2XMcI56bp2zncmuvoHJkmLzfiyk6TVX6dyrx0s/EbtC/eOc?=
 =?us-ascii?Q?2EVeig47TFCBeL+2RJrsAS+n+ZcbenklAsTSemeNstugjCAHf9ItKN232zE/?=
 =?us-ascii?Q?nsjBgTVgNEnoXblC2qnXChnlSFG336vhQsXN3F4g/NIUPVtdgdww4zx8T4X0?=
 =?us-ascii?Q?Rm5xBJdr1p/A9NplnlEzDY4dn7/d2DHoqVwVWUXAsn7ESVUnWYVcNE6jEmZI?=
 =?us-ascii?Q?FBz+iUOj9XtQv3jehzitBoeutTn0w7IN7FvX5RnvCTmqscNKOsnOGrPCOu37?=
 =?us-ascii?Q?cir9d9FgB7/LgEwVhHu4m5hNVTm8rO9ql75xcD4VTMjgUsRzxiikdjHhhvCU?=
 =?us-ascii?Q?yZOwfU+XWpxqMpSKKVMzk4EuRlm1KGRNo886ZVBCA+zysNDXa2NsaIB4slLZ?=
 =?us-ascii?Q?hG0AE/lIj7tqrG2OWdLa/GW02phV15b2CYE5LVeGXjLdvhp0C2pBheOA0XTI?=
 =?us-ascii?Q?XB5hf9KoRNjwR5dNYX5Thsxl/xjYcOYuIosyQQnFm8yoK/YdNAWguY75BN/S?=
 =?us-ascii?Q?75TI2VbRFOgrrxtzNDxqgHrZFLk0380+ufChx7SvxGMjLRwbJWsFG5IYsYgq?=
 =?us-ascii?Q?2W6+VzLoo/BEijNtqNBtgzmXrYGwGX6xOpDX+HPUuarWOz/Re9C+KzZoIW6R?=
 =?us-ascii?Q?UVU5CttArDrZ87ZotQhpcPub+IquBB/S8zJ8KJmHG/8/xHaWe1y3woIey08s?=
 =?us-ascii?Q?k8Wa+EHKW9FTIZYf+A9tdN/3J/VOY4wRoyP7hr7Wz/fA1jmLv3dg0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gaxeKJHQ6VOrMjZBtYrRpauAldDv23nEZ7VsAnoT+DH3kLLq5GhWvArJotA/?=
 =?us-ascii?Q?rBh+hg6mlkFtLdf4081ss3I++aIYHfMw2kMzXMx05kp2sDRmGPqyYLSQyx72?=
 =?us-ascii?Q?asHGYDFraVSG1ru13U621JO/qwfv7AlYEHVXIyvsVruddbqs2AN0QGBhEQ+A?=
 =?us-ascii?Q?OYJTAOj1hgeJK2ABRVjZUQXDB95HzWOG0mCJXPPDzJygYCufTzJzzmYDl7uf?=
 =?us-ascii?Q?vTw/ucO8g8AUytqbs0kZ7aNjSRz0SoOZc+mkew2+2QEbVYYrpoqZfgobDLtO?=
 =?us-ascii?Q?j80hoUFlF0fSaNfHJnMG/3AgAGhzvvnumwvRKsrMZKm1vKF+iPLcoNx1Xphd?=
 =?us-ascii?Q?luHXTWj+n1dfLf10pfMd0ULPUmFDruDF3Us5JFZhsfgQYZaVMcAPiSEoUsmf?=
 =?us-ascii?Q?55A73Xt18n98KfP0EpUn2Ls3DhGUOxaMCUP3oYax5J/UsyHu6T9xJ2IqHjRY?=
 =?us-ascii?Q?tcTO8Ky4Lb4XAjQg8ItEh/217gepIam3732ssc+iifCRAbpdGmN6FBpELIDI?=
 =?us-ascii?Q?0tY/tHmmMg3mFkBDf547N5utt7bskF2Kt0ZVyY5tmKus7zXTppewJOFg7jDn?=
 =?us-ascii?Q?3Z6EZlnhih1hJLn+lFMHWjEeY7cp3zhIh9Okv3FTts8lkF2GMJ2DKu/fc6cK?=
 =?us-ascii?Q?/6j/WajFE9mZiV7PjbYTCAUst88dgWj8IhXHaagxgba5Z3hJdNj/S67POpw+?=
 =?us-ascii?Q?LT3oixV8eMGnflvE7Dv1eqLuEsZzmY7CFX9g8+fVxVHI7FTH5wjaNU+1WMt0?=
 =?us-ascii?Q?BIfNEFE10s9DT2wNRGih8yTF0cUPW9x7xIQcu6rGYnUw2xqLY2G6njiOgkC+?=
 =?us-ascii?Q?lD9C972Ge6Yubug325PtC3my63ZUnMMKCaqllc+gyA7jaFjqFPXYTFkZZAmk?=
 =?us-ascii?Q?LE5Qh6bJ3uxQTyIkMJmJPRePVMwxa+FOJgzKnRr4zl5GHJBC5Xna+yzGkcg+?=
 =?us-ascii?Q?YhFFe0Iit1eBjm1Q7CuPXVe+iv5shR5UOaRKruSL6tSV0NlGGOZ99/tKyEoW?=
 =?us-ascii?Q?StqKIiGnL8lg/tXtK2dQSdOf0cjqP61HWMknaDBFSc3RUurp6EX4UOZsGftq?=
 =?us-ascii?Q?LYD8xrqiFNZ8sIPZa7qc025DLFYfz5pnrKEhrlLOKqX8HJS5qpXrM6QfHO2S?=
 =?us-ascii?Q?2KqKF2xu6jCmpwRBQRXWy02MjHeapnEOB2Kc9yaUrh+FErHxDZvVEbVBn7nE?=
 =?us-ascii?Q?hjv2uVps2EnE5onV/l39NeGPSGPIq+Q4Hbam9pPMMv2QjDXuoGq7BlFUsSdN?=
 =?us-ascii?Q?/KbTGoqgo1VWaAcrLjfEJN0bt561eRWYf01Tt0kfgHIU6CBVMtUagSTxwuhx?=
 =?us-ascii?Q?n1zmLLIelkbiVrnM/9U1pOxpVSwKs4m0M8OXoF677B1MlWGdKHytMXTfzTao?=
 =?us-ascii?Q?G/003/BVMp3ejv4aiOk66lfaaAqkrQguoy61qx4xYJUqTTebJBDkgiLObl2P?=
 =?us-ascii?Q?BB3GcOT4MJwqpAq97lO4+wBMLYpil7Nrv8S+AMKeYOblQ86mC3UBdkjg/X/v?=
 =?us-ascii?Q?itnEtoVE6sTmWYD0zMDaOgkXDs2LbpKyQzB14RMAGdzGPngNOFqo7qhLHOa0?=
 =?us-ascii?Q?d9YUJr6iTIh4Y9ZtOp66AI/eH3SMOaElHMgqRud+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99185905-5e5d-48bf-e9da-08dde4555f91
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 04:02:28.4912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CuyIjprzQNNl3Jh0pZfa3Wjy5ZfbM5dkmMIy4OWH8VfV7gcOi51Y+8cmDnGodoKdi5sZ1yqw77iDeBTJZcxng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6526

Use int instead of u32 for 'rc' variable to store negative error codes
returned by ahci_do_softreset().

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/ata/ahci_xgene.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 5d5a51a77f5d..8d01c105fd44 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -450,7 +450,7 @@ static int xgene_ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
 {
 	int pmp = sata_srst_pmp(link);
 	struct ata_port *ap = link->ap;
-	u32 rc;
+	int rc;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 port_fbs;
 
@@ -500,7 +500,7 @@ static int xgene_ahci_softreset(struct ata_link *link, unsigned int *class,
 	u32 port_fbs;
 	u32 port_fbs_save;
 	u32 retry = 1;
-	u32 rc;
+	int rc;
 
 	port_fbs_save = readl(port_mmio + PORT_FBS);
 
-- 
2.34.1

