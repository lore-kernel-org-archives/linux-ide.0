Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2062.outbound.protection.outlook.com [40.107.255.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD8414A4E0;
	Fri, 27 Sep 2024 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727416942; cv=fail; b=eET3eNA39zBMUnvsCImuV/5itoZkbUGSnvRsRDLDb6xuhiGZHb3TRgKLs1PcJHTsT//KwHI+JicpDTwW6Y1l86L4wRw6LWj0yvaV1O4OVK27STnsZvZk820I7wMSxzso0SEt7l7W9cIoyiY8A5lwXupoR6Mz+IC9UcIxOB43yR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727416942; c=relaxed/simple;
	bh=D9mZpkWkjFpeXuMpPaxvcYWO5Eq5ev4K3/hczGmeNhc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gBIOnB/ma/y0WAt25IU9nmWN0O3N/39dTT1M0zHE6NmZyrkhWTp/JHT/HiTJXXNBZ2hiGKUbXmNQ4Y28zOpFM0JSxPnpSMCRqkU8OrbuCHRPFVRdy8SFra2o/BLx0zVOzSmYTf/iduZSLb72LPnUEAbYecGR0wN22c7OHKIM9xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EwI1z0W0; arc=fail smtp.client-ip=40.107.255.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EwI1z0W0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wof1sEpvaHfdHfOyYhKXXF1rRb+eIWqaloiBO6rw3gFigw75JBgXtyu0nE9OU4dn2CvG/aD0Qy7lPIZko539ADR9aYxjifzzzweMdXCLQ947zdRZftq6tJxlFRbR0JTbm+frr+Es4+70f0SRp+QmmyFfL4SOIi4HHlAwjqlO0W84AYV5FWOKSrmNw9mp8YsCJiBmjB/FlmuTC4YXI8cyUKNSsLehToWK1plwaT3bu2LiAyw5AWq6g4y7Bg6Vr7v1cgnx4faFSss1+w/dSYxhhWgeZZDG7s4iidY74c8Z556e2YK0vuZua3UU4LDKLyLPcVYXj5xbCruiMKnVGmoihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osbT+shT4oasGBhMInLYW94i3rDaY3TdNC/eOxpQpr0=;
 b=scsM8oHoaeVIvpHGkiGwWzYcSL3S9jZw8sUVMeatiTliiMChFkD2vQt4RLN73R0O28oqe0HPxHUOEqvlu+CFXZAfg6b1maXj995+C6WYwqSACA5jQGQ/nCRAToVew9dH2pfw+aElRFGVkSp5p827Qhws6Uzqa0qTUqEBdqS20CS6XE1mWw71oqnNsMEQ6G1egfg4e2zmEZmDk6cOSRC1ceH1EXbAfZoqznzfDFgh+7+N0c7ejRiJ5htb04gHfGs+lyyfo1P1iAcQCYl5dE2up8DwwW4NUYyxF+NJmxYVHaUTCMlaLVGcYAZWw3mafStyYd5k0Z7y2rDoNqpjJBGwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osbT+shT4oasGBhMInLYW94i3rDaY3TdNC/eOxpQpr0=;
 b=EwI1z0W0kJ60sKMnVPIlooZQYJ6p02Sg/UzX5vQ8EZ48X4NBFKzgrB4TTSJbubwvPPmaFmsRF3cVdqN8L+gXYnQRP/jCfPURkF8GAqEzjic2xHZOdxj1w8gMSTWhbPtMbynPCK12kjkcXaVX2JY9iozC4+AAZi7LAvOYfBoHY5G5bi6u0grODJybXE7M1nQ48sHHAaXblylKgVKSO+UH4CfLzGn95EH3PlVAAA/3Q9w1VzUQuow8WxrknVCQQX8IM3CwdmtoOwemllH4lRPfxwIZlJrxvzjsOBQ9yeaCymXjMgcRhFHqxUeVS1p4HEPUMnpmrE4jrbA2jLWDKtSlyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4128.apcprd06.prod.outlook.com (2603:1096:400:22::9)
 by SEYPR06MB6277.apcprd06.prod.outlook.com (2603:1096:101:13f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 06:02:16 +0000
Received: from TYZPR06MB4128.apcprd06.prod.outlook.com
 ([fe80::2bb1:c586:b61b:b920]) by TYZPR06MB4128.apcprd06.prod.outlook.com
 ([fe80::2bb1:c586:b61b:b920%7]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 06:02:16 +0000
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
Subject: [PATCH v3] ata: Fix typos in the comment
Date: Fri, 27 Sep 2024 14:00:56 +0800
Message-Id: <20240927060056.221977-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0297.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::20) To TYZPR06MB4128.apcprd06.prod.outlook.com
 (2603:1096:400:22::9)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4128:EE_|SEYPR06MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f70250-408c-4256-2fcc-08dcdeb9f03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ut00ei+U38ygPAK2Ce1dhoL1lFKLR+4WQ3I5lObtITJX+5HQmWyUDAFTnq0j?=
 =?us-ascii?Q?CWbLNSnMy42YfUU1m6CSoGYNM4IhHmKpj+PoA3TNt/CmZf6V8aCc+uTnQNqs?=
 =?us-ascii?Q?ZyuQvYAvjyTHJ1EBhw4MTqjY00DPuHzcvoi8UgNeIOs/Rv4BeU7ir2YgkAi4?=
 =?us-ascii?Q?ymrB98ZCqC9MIVW1vfL7i8jf8qn+iSs0z4+2RkfrLDKaWAj3+C0TgU+svyI5?=
 =?us-ascii?Q?FhuMUHEqYzjLTm4pmNay15xsTV1At+1ZWUUdtvOR8CfBox9dKp3/C1qmMSeK?=
 =?us-ascii?Q?X5m9vxKk7V3DHAQV0f2Eam8gu/A8mrWH2b8RyaG3Y1tVStcO94H5AsYtq1Xy?=
 =?us-ascii?Q?b5jae15CKNyHNinA8y016+3oVgahKjqTpvkrO1JHwIHQBI27hW3yd/YkxRii?=
 =?us-ascii?Q?ze4qHHQJt02fAZsC/pEAgkoYEnMwRbEv7g1yqd+DUIraF16ULh1tDw0bp/80?=
 =?us-ascii?Q?tOo5Ggli1HR7dh3OuSHHiTB9AGHuKfJK4FisruajkQEV2MfTbV2EPauD8yyC?=
 =?us-ascii?Q?a9ffxAzPauia2TB++oCaXUxTpWStWd+tO84/naJc7mPW1yyJblMAKgpF0G2t?=
 =?us-ascii?Q?s97U1f1GflMY0jsGemI6pSnFVNavdP6hdxlFMmrRwS2CTumz5Cb86XokSJaL?=
 =?us-ascii?Q?4eMZ7M74au5Uxjh3kwE44sYH/V7+wn/rgv1C05Z4KIUknaJ40uVgwgHwF4wn?=
 =?us-ascii?Q?5kyuef0c26K0O+mNU+35HhdivvDa2WfTBlZyZrtczPFAlWiCbyCK/NJwarha?=
 =?us-ascii?Q?ItaWGF21EoSpCPcRwfhf3wQPxtMdVD+f+baPsHzC21/kkd1Oo5UhySMLMmL2?=
 =?us-ascii?Q?UoIF+eLg2tWjuaK9CxwinSw0Pc9dEzc89Z0nZc3z1gVpIzifGYZynb2PvEfi?=
 =?us-ascii?Q?6Z0bC0BFG5jQL31suEc7/e5gZtjGVoxYcx5nPhshHytfMJXmhDYQVrJUkdFK?=
 =?us-ascii?Q?nMgybii4bNsioxATgzFzSY8bRw59ca6P6nXH5Cs1/p0cIM/oalHsmgXcvIpJ?=
 =?us-ascii?Q?yXivOOfRfamHY7BAMtMEp6+Ylcjqwp9h7ssKu6Ekog/CgqvL3bosT+eBBr1O?=
 =?us-ascii?Q?eSXIBLTEf+P2o4JRBSmnQ+oHygoHMTaRetUQMCnvM5qqVvVEu+nbBzLSKdyc?=
 =?us-ascii?Q?bUWgvD6NQIUlRkMb75FOUn6nuoyAUaXv1tM8gZv9tHLnvsHq9R/kzCPf4JLH?=
 =?us-ascii?Q?oZL5UyrLvTty2t8hfrG+9Hy2z6FrpL5vIra7nrR7vVezvTFBMU4mc6CUKAy2?=
 =?us-ascii?Q?f2HtBPCG79ewYZIfDs7wEjbNfwOMmtKiHzEJlrmHFZquJda3rfwJMmvo9ZgR?=
 =?us-ascii?Q?bf4yLc/ikvjEsTSnLD5oUuP3aaVcDAqxb58v+KX9WXUvy5QMhHEhJlxUWaIo?=
 =?us-ascii?Q?lmkq75IteMiGcs61lB/gmtzDg381d/9j3v4bfNpyFtRyht1JBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4128.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KgKTSfLkjvc1SKCQH6KJhzeMqCZYax+zYgksOo6qEAPzOaY79iiHmZ5Q48R6?=
 =?us-ascii?Q?UuCbjCjuqN5ExgvXIrjg2xpb0pmBWBe4+sQafBdr1qJWqijtEs4zcX8x03HX?=
 =?us-ascii?Q?nnWcYPUoiJqxQZysbrGTcwKqV7NZ5zn0rMAdbCdbUABchfUNTh79oWIqzXu4?=
 =?us-ascii?Q?GUBaLH3exCbPX+JAt0h+cYKQGN97xsWQzoT1QtJEb4B9P7E2981xOcLP/ZSi?=
 =?us-ascii?Q?pYfMBXAPwjbKd962WUuiCMqbeVcJAsmsipDda6n5exhm5w6Tjk7NDe+5O9Mq?=
 =?us-ascii?Q?Nz6foGM47TNPtR+XZTeBmT62TgOlLNb3XUSY8GjWgjm+rUM8wm1i+xky5Aoh?=
 =?us-ascii?Q?OzpINcrQFLlXaOh6dMpAz66zL1xl4wLmuL/ffgTlx3nM8reJP1hN/2mR6piL?=
 =?us-ascii?Q?KQhh7Kb+3Iur/88dDcBUlnQHbUeiGLnfHyvMFZgY9+L4+sKBMNTrMr7hUXtr?=
 =?us-ascii?Q?kNPsjlo498JKwQZduRDlU2Rku/KM8QHsj2x1UGkBTWKdRqMvYY7hTPdazRw2?=
 =?us-ascii?Q?gWm8BamcBRMI6Ff3NqQ0UXQPtXIjkJboU/L41tr84iMPpT/+koXHHMwD8fWx?=
 =?us-ascii?Q?mns/yr3p0qfecpOdVGOMT8ixc/T/ObWm7nkO9R8yUMVh3r7sRS/EMBInfXvB?=
 =?us-ascii?Q?2p9KWVUtHCmZiS3rfoQXVa4GkfCsbNvw0VIHRMUSojvCSo6VHC0qImkhh/VY?=
 =?us-ascii?Q?OJ0o4LfmgfHRWVJznq1T7lGiFs+NpwTO3qYJCSFf1ZznYPC7TJEJu3G6G9TV?=
 =?us-ascii?Q?ZHlW3GyNNOYNGbSHKqA6WHXKR9ebN9cz2ur1Jk4UWOvOlsuWG/lXspPsDfL9?=
 =?us-ascii?Q?5ImgFAtg5zGL5AYs7Yd+PVYK1kjZuHGBooNjZCEWJbCgqXT1kKK95lmD+XpW?=
 =?us-ascii?Q?fUJzZhf4NTBwqShpvVQMvuWG0MEdrPLAo4YUSnTlUCTzNw3iDpGljbuP2Y6c?=
 =?us-ascii?Q?Z1GIUzOEjduTYrfysltO3O5YNQxT4wgd0E0aBVLM44w0FAGLeDmHt2ymUUFC?=
 =?us-ascii?Q?aBvsYIOsGCK5Kj61ID4oJH2Il/Wsch9rQOS1W4+sMN033bNloHH9eyF8t7c9?=
 =?us-ascii?Q?M4O6JGcWCP3CkHF3ofY2Q+/UJR/srKXVerKtTaDXVTjJytxVUm5yZsLh4RVk?=
 =?us-ascii?Q?imnxfuaiXDqF55evHnLd44Q++jNw8CRLIb3YD55QSvW6vvnkGNPvnSEh5i9A?=
 =?us-ascii?Q?XImitNwhCukP60dAzFPVBnfFYydkSRWW9y41U341j5QBa8m58b9UM8y9+/52?=
 =?us-ascii?Q?Bw2qfun4chCntmeBS1CincJc6DhbOIHJRD/8IkCmGB/Wgl4psjxccBJqVt0B?=
 =?us-ascii?Q?xyBDmVAjAazndyEI/27VbIe+1kx8VMy8eo7I8lmgLertzfSnMMlvoT9d+EVp?=
 =?us-ascii?Q?w12SMxtptJ8netl1wF93KmpfA6Gi9H9NXZwEGsvXvNU1E7odJX3RAlwf59t/?=
 =?us-ascii?Q?rmZipYTxSw8RoKGR1+DTU9mZ9CGrgyd1McBUogFnubea7KRPs6Za/9nh3+Eb?=
 =?us-ascii?Q?/5+GKpzgDGm3MAQ8AcP3o84mof0BTDLHN3SQVQCLNlfiljTwKFQ27BtD8fdr?=
 =?us-ascii?Q?TCmPIoLHDDtr+2co0zP/IbyRE/WK/gRQ/T1GeFmK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f70250-408c-4256-2fcc-08dcdeb9f03e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4128.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 06:02:16.3801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ///Kcs4W2u/cvzF9fgrDRWM23h+sCLoyKTaEIxRBVrk8S7zCgyvAmHphPsE4JISBiqHotYRAtjCKon4HBKLX1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6277

Correctly spelled comments make it easier for the reader to understand
the code.

Fix typos:
'multipe' ==> 'multiple',
'Paremeters' ==> 'Parameters',
'recieved' ==> 'received',
'realted' ==> 'related',
'evaulated' ==> 'evaluated',
'programing' ==> 'programming',
'coninue' ==> 'continue'.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---

v3:
* Although v1 has been reviewed, some of the fixes in the description were not
reflected in the source file, so part of the description was deleted.
v2: https://lore.kernel.org/all/b4a9e472-e2db-4115-99f2-4d1b702cfc46@vivo.com/
v1: https://lore.kernel.org/all/a5e93c28-bb7b-fdca-fd6b-a44eb3454980@omp.ru/

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

