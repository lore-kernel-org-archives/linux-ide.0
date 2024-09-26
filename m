Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2083.outbound.protection.outlook.com [40.107.255.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C971A42C7;
	Thu, 26 Sep 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343520; cv=fail; b=ZtFVlSPBqn9EFTUiZYUbn12IxiIKjDV4bolZVi0+pp8CmLXfGdr+S2fqpaVWWsRWJlFfUk9d9egt6b9IMZilCWrGlYtn4R98qvvwhY3j2vIbsALvRIWk0/+qRumJHy8iEUdkCjmH8kZQ0g6W32RaxI+cDpGegXGzQypy9NFA8qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343520; c=relaxed/simple;
	bh=QzT45SLfsZLU8Uzlf1sTInVR2SbC9ifhaeCkHRE2oUc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WosjWsX5kWmtEh7YM7C6NwSaY6lVbwyqpqyciVhtr8/xr6qt8BtpGH9G5jdYwu4G8dITxg5N/UFuF0YdOjG2nSR7JB++rLse8z5grwxRbAfUjwPhmBza6iOH87mes4ug3MnjWabmWFhY2h7agUI731Ds/by+QcNBj/ZHHvLr3n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LQIXuUV4; arc=fail smtp.client-ip=40.107.255.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LQIXuUV4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHPiwWe87i0BxaAXR++Iwf3ERDxy2Rt+vgJPum4nzVrF94d2MQS9ERA40G4i/46eufIrWGIZdqBtOdGC0vd4TcA07rw2tkAuIPRiyB6GuUHmnU0czbyFDnx6YBr5NqI743w8u3QiQCPx8i+KzNP7YZlLQEbUNDEBUv9vnmTO4LcNggepnfywdoYSXnIlCnyzc2hCKGOAyI+F+SkvIPInLYmPxhbtbxY2cFAI3JbIPRfD5664WSusGAATMkpjoduDMRcWO1jZcybAHkVXpN+yfZtlFxOEE6REUpBSbwuZq1/KuGeuAKHYu2t2MnG2jfBCl9Emxd8KHjDICCnkNOqxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su6CSDlgOn7P11pXQE+mhjm1x/OuQkDwx27lb7p++4o=;
 b=U+8mXDWsUyCYS3v5sdF7lo26NVFN5POZe5QFOhTy0NCPazBYr9TMmX7t1Z/BrIuLLjXZdIEpIAdZ3BULyx25Ec2XpaxzxPoZE8rAxrNCRGKjPqDebnorjCU69J02IEgOCphcD1XAkV3CEGkE59K9x+FmEtgdHggfc23/8PLZZ0Feu2h337RCgTjYAm7RGRMlpYnYCuqIonRPb67tusJwy9k16n0YBHZ6a5/RKHVFFyUo5Pfuj5k2d5dvf3suS7m8FiaG/qkDrq82NRZnQbvi0vqB1eQ4VWRgWeM/iLml7iiIDuDTTeTyZLgUwkEKy4XkOvjHWvYXRoGeWaMTxKsd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su6CSDlgOn7P11pXQE+mhjm1x/OuQkDwx27lb7p++4o=;
 b=LQIXuUV4ChdGvBZ1622kZIvLljh1m34m8/SglrpR5XEsWed4duMPGYW3hV//Gmnr4ymNHLXkU63a/wZBMt0gh+6Bjpw1RfKv+23fne7ZXp9uFSGpCL0K2lnV0A9DskoN80GvquRUjlDsZeqJFtoVqQDSEzpy3mF8s6lcxA26t6LhuudoA7zzavJgRxGsNN8E2dMA6c1LODlqVt9rnMrp+I/kA1IL5nRbSTe7c1WDxyedNIyP/BeBtuecgp5KySSmiaBti7mCyDnKYJb1Ysc8M60q6NaN16MzRig0GwhAzikih3I9TCY+D8asM47DLVCHPW9ZA+e04vqKyniuQpDxrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEYPR06MB5491.apcprd06.prod.outlook.com (2603:1096:101:b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 09:38:32 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.8005.017; Thu, 26 Sep 2024
 09:38:32 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	s.shtylyov@omp.ru,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] ata: Fix typo in the comment
Date: Thu, 26 Sep 2024 17:37:55 +0800
Message-Id: <20240926093755.3983833-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:404:e2::18) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEYPR06MB5491:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0f5ce3-d42f-4fde-6612-08dcde0efc1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kBZgohah4JUw+T/ZdQlns7G7HmWa3Rqq8uYeXBLBbGRZtVt4kKDRBSLfw+61?=
 =?us-ascii?Q?4HvEpWHPNwE4BfqrmD7iXX2Cm1zHHBb1nh+eLqiIDLnY7uaIjDwO3+8FSEMC?=
 =?us-ascii?Q?LGFt/OAt06fsiXSInPcCI7XVqzZCI/MLWREY8oFplaPlsysrUM9iSjw6907j?=
 =?us-ascii?Q?CKFzq7NG+xup9i3CV3cD2FiNM8cuhG4kTRN9UYifRQ0HL5aDHOeKLM38uhoa?=
 =?us-ascii?Q?O2cb/dv4kNJxWJnDOvIWCaHjxre/u0O/h6e21+c6Wxbt+bAN82Rg9gPEQO3a?=
 =?us-ascii?Q?XmK3gtpSj6CRWyhskspluQnRwuI3TlTiMqoA4+mj0wMRwOvocfgesNFsT4xS?=
 =?us-ascii?Q?sUKP0RbfcP/W47b6CbkPZYhCgPUsgAut3CG9Jm2v45L4pTQKHci8cLxuMd1l?=
 =?us-ascii?Q?PpoDEr6qVY5fFU1FBbKzG/ieq9VJB0KfC9bCApNlZVMh4vYwE1s5otDOYsPB?=
 =?us-ascii?Q?XSebsgg4EfPGYF2/wXkLEsDztmZHCAFcMkli6VSqk4ynhwknP9iDikiEvpMx?=
 =?us-ascii?Q?22S+kj6sddECt+J/ysaOJRwjRqAMtQCsxKQrbQzsKGyRvj/GcQleN+ABxPBB?=
 =?us-ascii?Q?dhEta503aN84fZc8TCBVZRTh8wXyDRo2Me4l0rmnagP2YGwRE+ihjoOm/NH0?=
 =?us-ascii?Q?Z9SWRvWMGfSUxhGYdL9mGJax9FJzq91ugd1Ju06kvH8NO+mnx8UX6wp6QJ5i?=
 =?us-ascii?Q?000dDO/8GoIlHwabrseSp7q8sFZtj85JlNX8KfYhxSUCjM1x9JDHTnycx72e?=
 =?us-ascii?Q?nZuxghfoHNVgAiOh+m5cEmPNzAoSW2kD2zv+CIrVjHgh2bODvxWQ7Mkw3AaV?=
 =?us-ascii?Q?59cQ9rRm8+uAUBNxmj9KtAvT/5QDU/AJAkzoT+hPBRpWwTwCcDaOLqphg1Xi?=
 =?us-ascii?Q?4+J13LmqeToQyFIFFjwmF80ubJ3E3uj3KaJ4Z3T8cuAdcYB9wrBgur7pWz3v?=
 =?us-ascii?Q?ssic1KGLBjQrKTE7AWITNcAHjfyul2QjJ8tRniRX3EPH9ek43V/kMQRJ3VNL?=
 =?us-ascii?Q?kNdTTPxhlglar3GkuvPhBP4pWsMfPcNVpQvpgytvhRDQq6bRPKjJszX7NyNH?=
 =?us-ascii?Q?AXw4xfLkKT/a7oWWxfY3JyoXQaI+LqAjFq+H0o0AE/uzMXDhMp6dnPlpoNKe?=
 =?us-ascii?Q?F0H0MPG/+PhI2SdK0uFubZGkNnVSTzRR4fHHt9l+ifJiW01u2UPH407e8xlv?=
 =?us-ascii?Q?LvdJ+zGlpXzo9uTDdUGAhvXlcHqwgmxD1+e1Lu2LPVcRvb+D0E6OKVwx/3LF?=
 =?us-ascii?Q?t5KjErBOnXfZiNnG/coLYB3dKJiNlL1Pvz51fd9vmkgwGFR8npwzFoOCtfG1?=
 =?us-ascii?Q?TbGbbKzrIlcwKmi4tMAZny32R4kBOlQWIQo+1QlFRmms4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+E211PsLtIrw+DYdLAQEpF8PvSa2PYVPWjB+shjNM1uNYdO0ZhJMYyYQLcO3?=
 =?us-ascii?Q?1UFsADi/AcmkCpTLLKmXzmP1hzGyt4QCbBo1N3v9mROtx9tbfvPlRDiMOqqF?=
 =?us-ascii?Q?GyC39z5KqgMkDv9cxkyJ32pn4wF9TOswuY5XiFCxl3VgRLjde+Y8+jbMjcbL?=
 =?us-ascii?Q?xI2wWAJ6Nx10augAq+FTFy5Z6+KQu/FK1faFRArUnWErvwVH1XPaiJVgVvko?=
 =?us-ascii?Q?PNv8stVYlBB3rAtVOH+cZ7CmvI/agP9203RfeAZ9WFHtABQdi2Bz7hLDSQyB?=
 =?us-ascii?Q?S87dJgYN5f1RY2d8JcP37rnuA/LRTcsnAENYm3jO7Bz0zQ2lIwDqZgEtXnfv?=
 =?us-ascii?Q?ZAJ7CPNxm4lACB7RZjHwvYtvvvjN39XOiOWWKlJr3Zr2Cdk/n2yjoFjsZms2?=
 =?us-ascii?Q?Rs2ckKCElVfCwu29Rc74MXOoxrni8rL7aQtzEFZt3mRRwSOde0v0YpB92IPJ?=
 =?us-ascii?Q?ABI6MlNZkixTB0yGe8Zezb+d1aSwtHn54lnfJAs+1KFvSnocs85ldtIPqdnl?=
 =?us-ascii?Q?O/ko7S6FmJU2bAgnLd7O54TqMLkXdswud0ZTH3nasgjjyPLUpjbNGzNAld8t?=
 =?us-ascii?Q?yVVfa0MUAWzP5KneTprfdh26gWNyGSB6qsFxqcQiLIISICCQZA1Vovt5nRAG?=
 =?us-ascii?Q?LYWfMogyJlkYh9z/jOuXZmysEf6b7ohZ7qJS3H0fAmbRk+d9QF6e+v2wEhmr?=
 =?us-ascii?Q?sO54jxc//IctwUKDHyPDHxcSWBGH54+ItcfQXmZcLpyArbQ0SmYYu9gM2MFr?=
 =?us-ascii?Q?d2OfkDa6fGohrxalhBRJd+hz1S7bevldbDTr/M3Mr4BVptyeUEWvR0q9+ca7?=
 =?us-ascii?Q?jeo8Q/+LvrS/X7llK60Yuu97extTJrp8zqZDXN4t5n3s5ZuNAZYXN3fxKwxd?=
 =?us-ascii?Q?Hokj8CLcxEQBiMyokRYKabvb5tHv3g6oLJdJd7+VSURIGSF6hM1LSjwTR+E+?=
 =?us-ascii?Q?aVGCrtcW6oHfScU82wPat2WzwYtoeEjvXcxvhjhlxISS1KGRfrwWuzbPIwBe?=
 =?us-ascii?Q?DGdnvVv03s7tehbExWt5j4Xx7YxfgCtNrL0c7kRQV4SzQF/W3tTmsEwa1Qxn?=
 =?us-ascii?Q?zzQBJYEVhxQyQAZKHgU36IVNbAYva7ZuLOLHyGCuL86sHCH/6kOplO7NuXtv?=
 =?us-ascii?Q?0bFldjJYYjJDcdB9h6WzOs2eR5df6U7vqeE3EUxX3CM51x4vnXXxG0jkypxZ?=
 =?us-ascii?Q?P91prubWgADcmbcz6+EUwF7Wq2B2gYRxLE9i7Ks2TyQwgm99CeGZl87GZ7yX?=
 =?us-ascii?Q?jJAPDpLxWl20/aIFyyx96dwM5cDaEO6+Dil0aJ5aQm0P+yxMFYfnSZukODJv?=
 =?us-ascii?Q?IL1MgVHXIAXtvFDhknuIKP4agA2qzb/iOT13Yjt/XlS+CI/2959Mxg8Sgta9?=
 =?us-ascii?Q?5JGayEiz9gtpQAFJMCPrPcsErFt07WG29K6gfedK7fHHakgz5cfmuGHoqFgX?=
 =?us-ascii?Q?4Wl0A2epT3i3FdTNflqvfaEzc3ZxEi0jMP4oJmiIw0VDh3vr/tr2dWAc21H2?=
 =?us-ascii?Q?MbCrdms8onyFIcv9M/n/gap4Q9J/LyQAfnQIWz9a22K/bMHFZjmrlxz2e8C6?=
 =?us-ascii?Q?t3v1Is/JWW+oAsmVpb+iUWSKoQ6Mmx/QPcEYP1XJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0f5ce3-d42f-4fde-6612-08dcde0efc1e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:38:32.2726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xJ+bZbj+H7ysxnlSEF0FuwXIitRVjfJneZ0m3TeR1ovPETvWZlP0C+h92kromszJwPp2j4DJgZRkkwltb3JCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5491

Correctly spelled comments make it easier for the reader to understand
the code.

Fix typos:
'multipe' ==> 'multiple',
'Paremeters' ==> 'Parameters',
'recieved' ==> 'received',
'realted' ==> 'related',
'evaulated' ==> 'evaluated',
'programing' ==> 'programming',
'coninue' ==> 'continue',
'Decriptor' ==> 'Descriptor',
'Lable' ==> 'Label',
'transmiting' ==> 'transmitting',
'correspondance' ==> 'correspondence',
'claculation' ==> 'calculation',
'everone' ==> 'everyone',
'contruct' ==> 'construct'.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/ata/ahci.c           | 2 +-
 drivers/ata/ahci_imx.c       | 2 +-
 drivers/ata/ahci_xgene.c     | 2 +-
 drivers/ata/libata-acpi.c    | 4 ++--
 drivers/ata/pata_it8213.c    | 2 +-
 drivers/ata/pata_octeon_cf.c | 2 +-
 drivers/ata/pata_oldpiix.c   | 2 +-
 drivers/ata/pata_radisys.c   | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 45f63b09828a..2d3d3d67b4d9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1676,7 +1676,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	/*
 	 * If number of MSIs is less than number of ports then Sharing Last
 	 * Message mode could be enforced. In this case assume that advantage
-	 * of multipe MSIs is negated and use single MSI mode instead.
+	 * of multiple MSIs is negated and use single MSI mode instead.
 	 */
 	if (n_ports > 1) {
 		nvec = pci_alloc_irq_vectors(pdev, n_ports, INT_MAX,
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 6f955e9105e8..357aba1d5929 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -511,7 +511,7 @@ static int imx_sata_enable(struct ahci_host_priv *hpriv)
 
 	if (imxpriv->type == AHCI_IMX6Q || imxpriv->type == AHCI_IMX6QP) {
 		/*
-		 * set PHY Paremeters, two steps to configure the GPR13,
+		 * set PHY Parameters, two steps to configure the GPR13,
 		 * one write for rest of parameters, mask of first write
 		 * is 0x07ffffff, and the other one write for setting
 		 * the mpll_clk_en.
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 81a1d838c0fc..7e6b4db8a1c2 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -534,7 +534,7 @@ static int xgene_ahci_softreset(struct ata_link *link, unsigned int *class,
 
 /**
  * xgene_ahci_handle_broken_edge_irq - Handle the broken irq.
- * @host: Host that recieved the irq
+ * @host: Host that received the irq
  * @irq_masked: HOST_IRQ_STAT value
  *
  * For hardware with broken edge trigger latch
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index d36e71f475ab..b7f0bf795521 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -86,7 +86,7 @@ static void ata_acpi_detach_device(struct ata_port *ap, struct ata_device *dev)
  * @dev: ATA device ACPI event occurred (can be NULL)
  * @event: ACPI event which occurred
  *
- * All ACPI bay / device realted events end up in this function.  If
+ * All ACPI bay / device related events end up in this function.  If
  * the event is port-wide @dev is NULL.  If the event is specific to a
  * device, @dev points to it.
  *
@@ -832,7 +832,7 @@ void ata_acpi_on_resume(struct ata_port *ap)
 				dev->flags |= ATA_DFLAG_ACPI_PENDING;
 		}
 	} else {
-		/* SATA _GTF needs to be evaulated after _SDD and
+		/* SATA _GTF needs to be evaluated after _SDD and
 		 * there's no reason to evaluate IDE _GTF early
 		 * without _STM.  Clear cache and schedule _GTF.
 		 */
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index b7ac56103c8a..9cbe2132ce59 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -81,7 +81,7 @@ static void it8213_set_piomode (struct ata_port *ap, struct ata_device *adev)
 	int control = 0;
 
 	/*
-	 *	See Intel Document 298600-004 for the timing programing rules
+	 *	See Intel Document 298600-004 for the timing programming rules
 	 *	for PIIX/ICH. The 8213 is a clone so very similar
 	 */
 
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 0bb9607e7348..dce24806a052 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -183,7 +183,7 @@ static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
 	reg_tim.s.ale = 0;
 	/* Not used */
 	reg_tim.s.page = 0;
-	/* Time after IORDY to coninue to assert the data */
+	/* Time after IORDY to continue to assert the data */
 	reg_tim.s.wait = 0;
 	/* Time to wait to complete the cycle. */
 	reg_tim.s.pause = pause;
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index dca82d92b004..3d01b7000e41 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -70,7 +70,7 @@ static void oldpiix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 	int control = 0;
 
 	/*
-	 *	See Intel Document 298600-004 for the timing programing rules
+	 *	See Intel Document 298600-004 for the timing programming rules
 	 *	for PIIX/ICH. Note that the early PIIX does not have the slave
 	 *	timing port at 0x44.
 	 */
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 84b001097093..40ef8072c159 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -45,7 +45,7 @@ static void radisys_set_piomode (struct ata_port *ap, struct ata_device *adev)
 	int control = 0;
 
 	/*
-	 *	See Intel Document 298600-004 for the timing programing rules
+	 *	See Intel Document 298600-004 for the timing programming rules
 	 *	for PIIX/ICH. Note that the early PIIX does not have the slave
 	 *	timing port at 0x44. The Radisys is a relative of the PIIX
 	 *	but not the same so be careful.
-- 
2.34.1

