Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012048.outbound.protection.outlook.com [40.107.75.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092B27E7EC;
	Tue, 26 Aug 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194875; cv=fail; b=InhLNBVI6p0dMBa/8MRcM3KWMMBliqTKxlmEYcwuLf/WmugYa2nmiKaLTLsy6OisD4uex52xy60U09QQG1eNocSTeaNqA2em0No7K0uXqOZKLxKkWfyK4v4Fclsisg6yq91xvIk1eqGp4CKd4gI9reKvHKUgZLgCI3E+e36lqLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194875; c=relaxed/simple;
	bh=P+76oQBA2e/39U8Xz0yMieo4AsoKUSEsSYUVu1ywnt0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LxdpSpvSo0oiXU/SPeX85oz6R6NUdKTgfzkFH7zg4hw30om4aU8djl4m69nZZPtvymPdqFCdS6S8IqFZfKvE0V6hbsHx/EFGDRGIvv1wqRyK/XcVN5UTOFC5fEewmRI0MIZ1eG/TQJo/3u/rgx4Qx98Aqv1/qLjB0zuQtpAFKC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=B1bwC0PY; arc=fail smtp.client-ip=40.107.75.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="B1bwC0PY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7d6RcDNZk3SVfw5zOIZlIPJ+810ae7NkXMbtu8QtxwNm+6X7McF9JLslN0xME0r3A2T0D5XJ8R+7WxPtQRAupS2CRcgF1HQA42LM6HP6NIqM7xEKgaZCqNQ80bib+TteylwvYJewoxrsJ2bXiDxGUR/5fl5x6/KZWHKsTz0QNr9VJxuAvc9Guz/O1KFSzuKu5N4oghqBUe+cEV3dr04ZSpW/cewWvILB6OHq/gYCySu9BmlChudz992oTO6GnbW/mhT8j3m10XWwVIjqKxEnJsdbFh3ZwtBQKjPio8xYgMfmQX6/F/Ph4zjYZWE8paeS+8IAGhDbQDaAxFMxOsHGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp9sP7sRT400ezdFHbMoll0HcMxPNBbYxcw1B3KDhow=;
 b=Q3QtxBle5KBdt58H42l1f+phJ6V2n1vBOAMrw23V36UFk3gcIfh2f1onPUMbU4/cLtHlo3AysKlxwSfku8OCo89SAYVjZ/WIYiI3el1YqTKnsl2i3LuRaM2hISGiUjRrTBoc6QAmk3/72X5FsnU7FfKEwnKHwLIM9Ga9gnoeemyhEk0/ZfLz0E3VDvd8NXC2voxN2qgjVgOmopVhtOD8Ps4EzuGybhQ0Ufip1SBVy6UQ2gJDaeJscRVA+ePTOm+aLMETZx3GHmtVuBxBPTQJ4ceya2x8YYI2hF6T8NHwlK+h9z4yBwiCktOyQ6PX9/EvbOSPPMgNqAc4MPJ1rLFpIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp9sP7sRT400ezdFHbMoll0HcMxPNBbYxcw1B3KDhow=;
 b=B1bwC0PY6pufB/Q7XtvPOMo0yBNT3NYCJHlqOCV4yHimkaVtF+9zGMdpphvCdl7DK4lsevA0FZf/eCzPRVyRe3O/LoMKJP5ImHD5r69nz122e7L7k+/XcdVmsGvWSoYCZBaW/zoTYiAZXIsXQHEwAKD9PIhRJ47MsTK9zo4bJ5QgNLOpoLmmn5sqc69KveBhYgV9SBYATZNhxLfhV6PoMOxt9AcNhbJllbd2qEv8HFwRtVhyWMcZkKQKutOkYBVJfNeUW0pn1KW1xcTociUW6MXBEhWIv4Tlxkf3Xw+YKsXqpd0l974RfNx3vu/Aoj6Z/jf8IMmZrSlfZF2CEDjczQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 PUZPR06MB5435.apcprd06.prod.outlook.com (2603:1096:301:ef::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.22; Tue, 26 Aug 2025 07:54:29 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 07:54:29 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH v2] ata: ahci_xgene: Use int type for 'rc' to store error codes
Date: Tue, 26 Aug 2025 15:54:18 +0800
Message-Id: <20250826075418.196069-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|PUZPR06MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c968e3b-82f1-4257-17ce-08dde475c902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1VceKRwMKMQAoUzHGvXIeeTZvENgekhWwFWmHXdZmZS39z5I2aroeKQskJ/4?=
 =?us-ascii?Q?il7gN6ILR1vq7A6zoF+ow2HI1OYvo3juZAnSTHh8UpfxL8KWATsIba3IPYPQ?=
 =?us-ascii?Q?+QQyF4C6fhaIxrc9DVB9E3MLGTczEw1IVtAOQWc2znEz9j0Wh2gcguF8cPu6?=
 =?us-ascii?Q?UpBYd1wGdwaweY0aVI65Q76rFClcaV1q3jzd71SrTTp05lAwlQGhFSnZbMhr?=
 =?us-ascii?Q?5Bx/9K+8O2aGUgZspqp4VsEelNcEchEgDJJtO+gvx28pXwyuotPBEFhy1Isg?=
 =?us-ascii?Q?bmrvfdxZ+JKf2nIuPnwZA6iM5NAdhMuONq6jjPXUpLykW6/rUcNUv6OH82dF?=
 =?us-ascii?Q?+FolXzFiG4h8ZnA6OOwp9T1jcL5pB6yamJnILMaq7GHe1fTaUxcXdUC2li8p?=
 =?us-ascii?Q?kjdqxX+K5ZasnVVg0G2ekkuJGnt85hLIdTs/auZRbXVKRg/F3xmGLA6aOeyw?=
 =?us-ascii?Q?+/KPvyjiS4iFavLryBNARwb5SYVIrBLBzlUxg1Tdp+QxIVU5PyYQEYaqO3sO?=
 =?us-ascii?Q?BNVgF0CSyY/2i/gEXhEBYgP3f6lVU6Dm8MtZq8UscQIfnbaABW77TkhGRzbQ?=
 =?us-ascii?Q?5ts9taXspUa5lDaLfJ40e1W3lUtUEqL1vSxl6V1DoYQEvlGNSdY2bMaPTrKE?=
 =?us-ascii?Q?8UiYDBlumyk8J3EhR9GKluRwfmFxUZGqrAvnac6RN3O1LW8zSKJNq3qaJcsW?=
 =?us-ascii?Q?DnBpkxgbsxTxFcKJDfIDSvs+OOC2jkNFdDOwYw4D48of5lDZig/2qobttQjB?=
 =?us-ascii?Q?QtCpb7kImpy33SGHpAcTt+AtzoOQ4yfAYWlnxnE/jRnU7hitjrKh6YSmV68R?=
 =?us-ascii?Q?d48dZrYS+xnPFJ+aI+4g6ldOBGRcw6pAC+hNja2BQqtnoI6lSxZZTE5x92pJ?=
 =?us-ascii?Q?2v4j1vMuiyveCzr2OUrHXcItWC2ruFrjLpZZouLw6fjK+NkaBGEyB/j8c3hv?=
 =?us-ascii?Q?iL3eREdp3Sz/B4HkogBw8Pic32PtCrAjfmV4kfNWoLYAXRkpRhNPcq5OJRag?=
 =?us-ascii?Q?OfIM3r+t9PlrMZtI5zitlfekMGb8F5j5wFivl7pmQwHxuhtw0qcYlwr9XdoU?=
 =?us-ascii?Q?ple4D1WPJyFYUUY/h5m/ovDHdat1bN+eVZx23Cav8Pi3dNCns+nN9DA+mg+8?=
 =?us-ascii?Q?PQ3JiDL1hV3XUwfTP3pvmz5yEjLTJJldT/futjj5pXGpFEHs8i8z/zOCO2IO?=
 =?us-ascii?Q?ofJ2+sAkKSoO4XI7mE5lcoSQXaWqkC5C9dYgxZ6yTgj/MNNYMGBUFlGip+9Q?=
 =?us-ascii?Q?hN/A46nbc1XR3Rq9n6tQA9s3cAtRwEiE16C2SBVuoba++YZzIiizwEVNhDlZ?=
 =?us-ascii?Q?4HtiV3l9GD45rhsbS+VdeRQ3YUQMeYW3wsgyVJ4HxE3cVyworV0aEV9bgPko?=
 =?us-ascii?Q?Q2YVbltIrrI7+Na2d7i5v0u7jmX1N8bVCYtMBCdqePXD/hN3oy8o6Zwx9OiF?=
 =?us-ascii?Q?hdbaj3BCd2zdm3Cq1s9vOmmZsfQAKAD+IpVWoR7UVkO0O4/vqgXcTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vOaX5mHJwlnhzQcXOxSTfsYi5UKZgNjmDLUTB+o+4m++MgNI+czH2i3BJQ3f?=
 =?us-ascii?Q?OEO+scnm8ilnmUD3UD56lRoBvKCHlWlZWAJfO6AGeiz32JtcHTiEQ8JWKHcS?=
 =?us-ascii?Q?/5/pO0w5Nzd1WWXNk74qrrWtddUkMqDvwyaXGcPRokCCvHMiKFKAOucLXyP/?=
 =?us-ascii?Q?1h4ifB6z+1eJgvaQyefOGjX/THxpXSppAL3MvrpbekYWv5eOa9YHb969NZ14?=
 =?us-ascii?Q?qlqUNDIFTVcPiVuWYRIyPhiCm2gtLEslJqJZ+ceJdLj44UgP5j7FhDrDnxAi?=
 =?us-ascii?Q?R4AjRHiNm0SFjwblymugFVR6JZWZb72vAb7celZGX67pZBMe3OoWJ/6+5Dtu?=
 =?us-ascii?Q?snqaD7MnYKLjFC5aljpR5DR6Th6V4bVBafsfLnWcFvAn86B7qOfG47i91DaR?=
 =?us-ascii?Q?LD303JyfTae6AzQvsDG17T2SY+szeQkhajJbYG51GTRNpW3LI3IgSuDVFeC0?=
 =?us-ascii?Q?/iwPxT+PkcguC4oI8RsZrmjQFnmhkd4vVr6O60dGur1oUTQLhxqUj9jrVMhi?=
 =?us-ascii?Q?Uu2uNcPYoQnLhmaPLsY2V1CjzuRjWuC7ce+r1eWGKQBsOuyHu8rWb7k/kBtd?=
 =?us-ascii?Q?X2haIgpelgAICWU3LwbikAQ5tW45ezSHiqat+NGtTiwadgOGZ4uYthuRw7aM?=
 =?us-ascii?Q?CzG4Lu58gjQoZyQuIt/WL0XU5p6fhWwrLHzY2+cF1GJdznYJFYbpSApZ09ta?=
 =?us-ascii?Q?EbBKBDDtYlWAk/IlT3OulP9x3CYLdqd+CH2waL7aCUfs9lIySQGQLsQF1oYH?=
 =?us-ascii?Q?xz++eMXf9XexnVdZM+CH4QAXs2VY/2ZkiVQE6wcGBsPQzmNjvvymssYNWmvE?=
 =?us-ascii?Q?mCXSZAwO91vLHG/PKZWCzG22ZLS3uGgEaFXx8Lhqsxrqr8T0XzKi4/uhi/IS?=
 =?us-ascii?Q?xcxqmyxAEzJZeeLzjl1/uJPtDAg5rXNjBXs68PzD5wisIDztQudQjAEqKg3q?=
 =?us-ascii?Q?eTybnMk8c++F52YaYBTU7AwjGMoe6njKlptyrObwuiYIxNsQDVUZdFtmZu0W?=
 =?us-ascii?Q?r7dY+VIplv+WJsphMhierC8rIwBlCzDQNKfjuKuJh115lgt4xKQMhcT3rjUC?=
 =?us-ascii?Q?zdXsiO7HU8Wa+WiVMKqdHbdyH8sJk/Gtp7TXIOl2TCvWCRm94YlCPB9LPM0k?=
 =?us-ascii?Q?ghFfCxWmu+b5R5re1bAwZHWilWsgVVhcGVvzAKf7X+Blf7z7XMm8t2XYQHY8?=
 =?us-ascii?Q?XXON5PbVpkEDst3N0PbVZGuXLcCZM5TUfshIQzPkNxtW5hOzDZX3E5kgha3e?=
 =?us-ascii?Q?rcRwR/R65UR8vNouRlzLdE63gUAR2rQq9NVatDR8eM484GYw2MayW6Tk0AvO?=
 =?us-ascii?Q?PSqXifBuKx2KR9M6K/glJS1uOLBhrbrMDj2Joi+Ws7IPuznQK2Gc0rpBB8Tg?=
 =?us-ascii?Q?yGtuhosMBNXVlxvLRzTu4YSMu9lEQ6sGicahWcFUrTR4GOkQrb8/kV7nVTgN?=
 =?us-ascii?Q?WsHpVHPbwkvcKHeOxnCWMBkben7n45V77fnNSyP7OVvh4Bd/Y3XHd+z3F86J?=
 =?us-ascii?Q?NpAiCp4fnHUjuAnU7IvGvnQxsXwlwFZqVUWiKvDCu4obokNaothrKAJTS6ZT?=
 =?us-ascii?Q?kaYh5obIpV6KB6Yod5Dzvk4/UWZysZKeisv1+eAG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c968e3b-82f1-4257-17ce-08dde475c902
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:54:29.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMjobMnYamn4ngULjBCmAndqULGDITGDkASVxNkvaEh896pfLzvcfvRganmRrewnZwadPfAMcfO1tY7V1UFjAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5435

Use int instead of u32 for the 'rc' variable in xgene_ahci_softreset()
to store negative error codes returned by ahci_do_softreset().

In xgene_ahci_pmp_softreset(), remove the redundant 'rc' variable and
directly return the result of the ahci_do_softreset() call instead.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Remove redundant 'rc' in xgene_ahci_pmp_softreset().
---
 drivers/ata/ahci_xgene.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 5d5a51a77f5d..6b8844646fcd 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -450,7 +450,6 @@ static int xgene_ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
 {
 	int pmp = sata_srst_pmp(link);
 	struct ata_port *ap = link->ap;
-	u32 rc;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 port_fbs;
 
@@ -463,9 +462,7 @@ static int xgene_ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
 	port_fbs |= pmp << PORT_FBS_DEV_OFFSET;
 	writel(port_fbs, port_mmio + PORT_FBS);
 
-	rc = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
-
-	return rc;
+	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
 }
 
 /**
@@ -500,7 +497,7 @@ static int xgene_ahci_softreset(struct ata_link *link, unsigned int *class,
 	u32 port_fbs;
 	u32 port_fbs_save;
 	u32 retry = 1;
-	u32 rc;
+	int rc;
 
 	port_fbs_save = readl(port_mmio + PORT_FBS);
 
-- 
2.34.1

