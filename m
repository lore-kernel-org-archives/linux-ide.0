Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06840175A6;
	Fri, 27 Sep 2024 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727400845; cv=fail; b=jMe9daHKEBNnEEjfTEJCGErmA3BLSvX7Tu9/D7xmqbc3qoeX4c4rcK5u8YY0zRirJOFM58x7WtuhJu9UkgLsDHms4JLKItWnsO7EZFbcXwLzTrU+Qxc3NhZTqtkuA7211zvtvbyGGtfwmGjmX8/Zw0MlW1WoxdfhW/Rh45OAdIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727400845; c=relaxed/simple;
	bh=AlhqlFYLf8dNQbyiO5HPbBFOY6lTa2J8fDYPHV+2fYo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=isE146fN35pm8w57Phm4HpikBybHP8RlRRYZPtzbIdrCokKJ0eDmISgHNfr3WC8f9s2rstkYYMG7x1++jsOew+ft0Q/SBsq+0cwxvnHTAu2UM14aih0SIbyx4k6JVTagL4HnaTr+hJNQtChfwr5LvlmDQLZUzhE5mcpvO1UG6E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ndphzxw+; arc=fail smtp.client-ip=40.107.215.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ndphzxw+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2L4hYs3FdN5UNwgcU94Jiliohc/e7jDAaZa5p1JjdHjuR7ZQ++N5pCDywI8BVZXK8Ko5pnBiUXs5nGsBXE+xq+xDzBAzHhSUqdiZNJ8lxWcFGLAyvAM6C+Y5xRVYNHUqv8GR6p0+1b02U3yT7r1TQzy1kSLFHxMSzHZaejt6tbrDXW10xU3YHo6Tn+SMPq54YG7/tCr3dMlR9nsBzvvgfQooJcTY1bwqsXaPgh8Jh4beSJuiHHJXGQN57miHq4n8wAlU/9j90pm+Rajf4ffMe30Or8tME9ddLvGYuopHnUpfZsv+FS0dZkeclZ25XjLSq90mBUFRFHKWn4myQdqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wnh8v98StIPAcSSzVNpvYeafPZF7iSd4ZajEoWQBqiw=;
 b=V/Ny+3rcfMli4smC0YsrcKxTpU0RnEvun9QTbm6CkCZCINi6k9lgevApQ2F7y2mhfd6eTiSuYvOW9ESBh6t9kAnIyc6Txi5xcAqK6qcF3v+2pK/9/L7qpUKIMSMts1EmxwqxUKMtFoWjytTM+XzOFhiN276VVW8QaNaqkYIXiLQ2htKE+h/rOIQsi5dqdAgAdxDMyiI29G+2KuXtnK8yhj0QZVexRiEQ+IzjGxJRuTAyea3uIy2rJbmkc1Y59Y1zA9h66Tl7N5/jkCCA08Rz5D0ZVbwwjGp1qLWhdcC/+obSOqQs9jyr2C+PNVlODuZB/P7yj7+3CGXQra+UF2XCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wnh8v98StIPAcSSzVNpvYeafPZF7iSd4ZajEoWQBqiw=;
 b=Ndphzxw+3moNdyO6qS/7CQ62C3h3xtr+TSHLU6cf4RKV4AyZPB8f2n5a0GsCPMwLxhVyUTn8aZcsYCG3GR0IqGe/V7SLIJf3TuziQxDuyiurax9q35ce5LfzAiIVWPRywbnyaCuswoU0KL8AtIcypDNUGcyyRFnPv6MWTey2BeNmntwTbiJuUSfVrGSAbHOfQJS8XetwUwi5RGLDckB3Ftf+8NBV2+oswOq0PgPYldOTMa2UbeIckibzBfro/H0B9VYc1hWtJODDGcnUcHHj6MDDp7b8TwNQsV/UXUC0hlZqU5A65ztWyTY19PQIU8BNsuPJjzFyn4BANajgwHr5SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4128.apcprd06.prod.outlook.com (2603:1096:400:22::9)
 by TYZPR06MB6190.apcprd06.prod.outlook.com (2603:1096:400:33f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Fri, 27 Sep
 2024 01:33:58 +0000
Received: from TYZPR06MB4128.apcprd06.prod.outlook.com
 ([fe80::2bb1:c586:b61b:b920]) by TYZPR06MB4128.apcprd06.prod.outlook.com
 ([fe80::2bb1:c586:b61b:b920%7]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 01:33:58 +0000
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
Subject: [PATCH v2] ata: Fix typos in the comment
Date: Fri, 27 Sep 2024 09:33:01 +0800
Message-Id: <20240927013301.4162772-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:405:2::29) To TYZPR06MB4128.apcprd06.prod.outlook.com
 (2603:1096:400:22::9)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4128:EE_|TYZPR06MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9ce28c-a7dc-4af0-5f46-08dcde947526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOxij83yz0eZg1CM3oJgQPpTN8gh7nxexYIVe7Cwe+Pn+UYuSpweL/a9ZPEi?=
 =?us-ascii?Q?3R2gC6pqKwJxxmbMnZyYoa8O0l4qw7FZyJO2CwNODqnBnl+z3Qz4pNuDrMTp?=
 =?us-ascii?Q?y6YV9BhJPDPns9pkWJPOKkTQ92MsM27yYb6AMPCGY/4Q620kkLNU/9ROdlAQ?=
 =?us-ascii?Q?+d+BNndgy7qLHYsrN2OyyqHV4CZ6F/ZxnwDYlbrAqf4+dO6ybPQdzHxAz4O2?=
 =?us-ascii?Q?BUJidZ6rvlQuE6BmP4b1R2jCPnWImqD8BKsHwiK44YTXvqLeipDIiiJtJcKF?=
 =?us-ascii?Q?jN9m0zgwCul8R6iOj/uTHDVRjyy7f55ldwgzizCgv+8tIWIzJwGkDxxs81rA?=
 =?us-ascii?Q?pHkzQymKh7IrV9jLQDJ2TMO2gu9FxYwODbf98RTR5EFqV1FMem7FkfZOHDv5?=
 =?us-ascii?Q?3c38CgbL5S8STnYNYlK1yPfPH19x6EIEWc7yWAvC2m+OdY2b6D3z6K6lwjUq?=
 =?us-ascii?Q?t0Zrv/r++htHKBveO9N7W/mSkQgUx6ymLkbIi2fjwnduD5ySIeJgzELCyqWc?=
 =?us-ascii?Q?RQqVNcIjcjNYtn6RVgtNfJBTz8B+OvdRKPHTPRdus9OzWI/o9j/zXNXAE4Nt?=
 =?us-ascii?Q?49/p4/ddHukHLbYZCuPNtblcEjpq2hRqYq0lmQFpJJBZYD4CLdKQ4XpeO5jr?=
 =?us-ascii?Q?qo6VS0DNGEoc3xqT1SQAV1zMWxBpMyvBj+T6u5/jogjOmnWkYV06bkxbk0Sq?=
 =?us-ascii?Q?DHXWpC1c4ypnznovLypoNqitnLqJ5N/IzcAB2e+hn4Vwd1FLRCZKOq+5aoei?=
 =?us-ascii?Q?gsmBRWtcFnxAIkJPKurLFOtCGjYD4YkM3m36R1Hm7K9urXJ4qFKYWOf8PS8n?=
 =?us-ascii?Q?YgDWpDz/cfkFfN35Pijy+/WbVGaWadQxTivKa/5ImErz11LI4gt+mbJa2Xgr?=
 =?us-ascii?Q?npXPFQRh716r+5/97Pl1b9Ly/SvbEirakqeZbmtja6V858NeUMsZ95otRvuK?=
 =?us-ascii?Q?LNVyJxIhlKadGQ8RVvrVv/SBZZA6pGFfGb7S614CQ0hcGV/Ucv4i2I9MlaRc?=
 =?us-ascii?Q?neArHRxNn4gOkTSaxyl2s60sRpDUq3ICNfkbLi8NK0aZcOoQXOCYO6DmE2dW?=
 =?us-ascii?Q?5u+5Xt3L3WqO9QldNOktDBMDeDuKg9vANLCB6E5oCAoqgI86QQSsrEHMAe9F?=
 =?us-ascii?Q?6XwP/9/nXAcXLQV26ab7YZVYu8IXuEhjGoBIKn92EOdMm/5wMXLLVIJLPPh8?=
 =?us-ascii?Q?29eI5S/ZDvb9F1H4BswO2FfcampabvchabdHNJOjr5aOsSvxDe+h2lk2c5pr?=
 =?us-ascii?Q?BKDTuWo9SBJYJZ94OODq0Ip5YICcLhQOs2C+L6JXbCqxbs2MGForgSVtF24W?=
 =?us-ascii?Q?9x33blfjLUCFiwbyDegcvUpCNEP6rNlIfIRpgyto4wK3sg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4128.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kAolJ5LoM+AlICR+8vxQrV3nLgedf++rIeOdfDILoh5x7UWSdl65dlYgaWxo?=
 =?us-ascii?Q?4tvD6z2J5S7CxyFcq72UoiQwV9dnY1BOSU/Ci9yHZBobDraoWuGk5QPdfnTy?=
 =?us-ascii?Q?FdOvyEJeOHRLA/0LIpT9YfOSeRomwzQ4+NbnSV3y5DcnZCKAXoO1ePvTZ/97?=
 =?us-ascii?Q?lDsory7c0eZsDviPoBryRFjqzWkUOC7LYoIL4fWfPvRffFnK3rM6KA12IGPT?=
 =?us-ascii?Q?JF/KYrxe60222tvWdvS7qCeubyu+KmVw4BAwIStNjNVlFnfT8ab3FN2RYC88?=
 =?us-ascii?Q?cWSXh7R7D2bgOHe0SPB3/gb9XgILKaEZ/8KwR0GW2x5A+NW0EpTpHxni65zr?=
 =?us-ascii?Q?/3wCWY2R2TVHplUiLee7FnteL5ovaQKfgeP++KAqcf0tz5OPGNb5EK5BxaZa?=
 =?us-ascii?Q?im/9hKVX2iACZu2FyZPpnvmRXu7VI0HoRy/DYwqs0E2o+h87mRNFoNgfbewh?=
 =?us-ascii?Q?dtOyq48f75r75AFKFq35dmbJlF+jPPTjwWoazqGDRARZlHG6/y6Cm1KHI5jy?=
 =?us-ascii?Q?gVoDdo/6otB6GGh3RrrXpkWwNrMwRtl6J5+7G5wpIed8lU7a8Og5IkHsUbqx?=
 =?us-ascii?Q?fQYyGTEDk1jLU52lNyIVIEXQSSbB1M806FnrgdYmi9YiDFLaWiQKbb8QsSRu?=
 =?us-ascii?Q?E6IY1cZSLUpgxIk1Z+QRdwxEi4ry2ot/KQ/m5yxkQnHFDcy7bsvriRG2UquT?=
 =?us-ascii?Q?1nIv50LK0H6+yI7osEGvVk1pTgR+PTe2ZGxAtALwv6ehKG2d6MRnpD+DgL3t?=
 =?us-ascii?Q?nlrI3xNFoJN/+TjcohCz3kjeRZbpx0FZOCEHq4T9jV+U8ggY4w9T0jr0S+eW?=
 =?us-ascii?Q?vTmIQEr2uube8Ur1Ramzv3OlKn/dPYm+QZzjRESBtkC5UMksOkiNf2JCm3O3?=
 =?us-ascii?Q?sLNtJ/cSOjzeAJJ18aO32VG+AR/fwRjvYSnAQeyPm8VS/CGwZH5X5QydR4dw?=
 =?us-ascii?Q?lzdj10iwjWVUde2m7LzNhMKsudo4wzse1lsLT/t+0h8Yv3tAGnm+WEJ8qa6U?=
 =?us-ascii?Q?rHWa/rILuz1n94UZMuE9dGAIYV7sU8DGSZPMb4IpT2ChCikj8bLJ6AM0daao?=
 =?us-ascii?Q?7BQbIEC4JPkABDPGSlb3qbOoFa8sSazDGIzR4LNBuivBTnR8y673MGxOUeMo?=
 =?us-ascii?Q?GAapfN4HYnnv7LSRDpCleKAjc0MDgxnqo+ktiKAOzSDM4lpqR5mCGkwLOaLa?=
 =?us-ascii?Q?me8MgqLU62hedAWANGoa7FE/V2Ar2J6CqB9PP1HBjbRAjTdF7MhNHUY5qULP?=
 =?us-ascii?Q?JRN6S8xrcJRTTM6KxXKDXORZ+qAsBuHgfMuvNO0amkvwbBNz4qSC2lJcjqhG?=
 =?us-ascii?Q?Dnqg0gNcup19B9pl+lTSPhGyW22u1EYrGTt6QeWvzlCOMu2Mnx00fS8jxlKZ?=
 =?us-ascii?Q?je5NiYpHg5t+RPSKEGJmvklpjFI9NV20jF3pMWvFqb7FCM+bF6W5arIcBszM?=
 =?us-ascii?Q?cijTDTDFwfZlZbu0KzYFlZUmNOODCvWqCs1HnoSXaxRiidalpepUQ/D/zB+U?=
 =?us-ascii?Q?2mRqCLSbJKwR4E5aoA7sWMHK6Db3wdVSUY4+FLXcdICZxjp4GRnuC3p3HrVo?=
 =?us-ascii?Q?CSdOceTpHdLGngCVto0v2sHIoYlyE4PYqyCsnehU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9ce28c-a7dc-4af0-5f46-08dcde947526
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4128.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 01:33:58.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGHG6oUSpS2AqF42X18VfPqRTdvX4wJntVQKcahua0TUMiaDyOk5XiEwGgxZsOFBGwLRRHPCv4qDZi2E5PO3cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6190

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

Change in v2:
-In the subject, replace "typo" with "typos".

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

