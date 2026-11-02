Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793637117;
	b=cmhJJNrhlKkN1dYfDBxbGMdyGOwHiq2Ze6fomvGvp/AaweN2uaqrFhZtp9CXZrZmBZwS
	 129JKl49Zf8QJlyUjbEOoJBKEjExPZ7zZjc6zizCv3TBlStt8L5eT5WpMSKhkGOhPZ3BO
	 H4ossSX71LkSfkWjkLfRMCClZ9gklIac01RMArB9z/0gXPL0L0CkygrnN0K3yBUwUC58k
	 s4XMeI8LujRVLBEZT/7vQx1/tA+Y1QNbR+HVAFzCXwLFdux86jMw8Iz+ISi8362XI6mDZ
	 pbz5ioAB353dLu0Tdci6QhU+8qRJw9isgYqAT/n6YFgLiUNc7Gp1HtBveYqtFcTnDuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637117;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=L96UNSFHtzb/4ZmmhbNBwUFmXorwgQH4UmjkCGMfZfg=;
	b=k+uCYH3blDHOXLRVqAFfBEI9g4IjXo1DZiHA5WAEBTMKTwTBHqGh1f9q9iYl+PEpHhI/
	 RI+WQsjPATDL77WL1E79r/ICXDEpo6ZP8wXR7qJGSI00p1cB+wBECf9iXaogmMAkPrG8x
	 JiHUp06FZFD8IxaJqJxkroS5OxnQx58SgvlYLpQPG7KrHoSxanqEA+J3Dq4KMiqJmLSDy
	 DJPI831Q9B3uMmboeSMDHz4eNQkT9jjF/16M3ZUGL5qHapFTMqH+soBMax/BJ3OknfN2F
	 2LVs1mw0n9zBmtPEo5hMbecWa6cM+gg/pLqdEMXjFrjTZcbMQBYQM64sMbtkwTzOGew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=URW9fI7I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.65
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013065.outbound.protection.outlook.com [52.101.83.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AF606A931;
	Mon,  2 Nov 2026 16:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C72AF606A931
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=URW9fI7I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFZBkTaZmO12pECiV0TU7HVERcP0X2Zc7dqU0lE8mehN1mG7Tt6QayZJndQFoWbM/2v26Zc3WwWHO66A/hJEbrqMedIsz+YvMDXvUm7AR0Pq/byMIt/BWB4APUtwZg0qHKVfmp72I9PrT6OlMkOCwtDKjyGKp9XxlNdAcOaIb/tBzYez7QqlP9zX9+bXFZi8DI9/mV6hDWf3uVk9Tu65M7dBdxf2Nh+Hjf7G7fJmw9KfIU05Ux5iz9kiLhojurSJIDpRPhtHFR1Vgp7cZ8MSvDZUVg7nMSzZdQH7/Jef7BJ8p7dkmLArLlpS3/L2jwxZ70ZSHxe1ik6I8ywvd4VXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L96UNSFHtzb/4ZmmhbNBwUFmXorwgQH4UmjkCGMfZfg=;
 b=Ab3NFwZ8hSGQMq+ZCZVQJKu8oTCKDgmBnFtVAFGS7161s0teSvpYzXqfFmxSO+/i7cumqr0lsRCi83Lw6WzCTQeFVkiNHtiwcldzHJx+BAaxxBzJwI4ZTBfkTyfM3GrUk2/+uYwii3vyqLnWm1WfchdGJvRaYXdxKYGaaU15mrgCffQEKQ91DXoqEouxwpnnvJtJPBypFK8MsihhvmYH2x+3C+3kfyLpW9lk1b8H4o52AUq/AvKffnfZdg0hTUJo/7Na1UF3C/PkmhSPsxvfrETvvVzL7NSBa+xKY7/BKwRY9ptosNZVSbjUKx+qCo17IWGG2bLKwgIVkLM+7n/Nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L96UNSFHtzb/4ZmmhbNBwUFmXorwgQH4UmjkCGMfZfg=;
 b=URW9fI7ICWDmawAgyZNtbKNSop76GKtcioAkifYRSheOwwBrd/8KciR/cPLFyuqgkS4WMjaYoMJmJJ1c783PuoSsk+RwpQCSOdaKQ4yV+vqAP7zLQdSwubIaGBBEMPSinG3gvbZu4wIdqj7v8w1jkwN4MrUmPIH7oif/+36YkR8ERSZAdY8QKfaaDUu2Xl2+hfFf1QJlISUnjY8tgPNHBj4IitgJqEaP1uvzhD+Awfv5A5/FR5SEr9g7Ixb46yLMn9KpPkDdmr8j2OnQqn5bsqvX0v/b9wiSPTlWpQBM67GdMWIcgibrR5HzASsybxq39QUbg/V/raPB3Shp+jPHBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM7PR04MB7191.eurprd04.prod.outlook.com (2603:10a6:20b:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:31:53 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:31:53 +0000
From: Frank.Li@oss.nxp.com
To: Viresh Kumar <vireshk@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org (open list:LIBATA PATA ARASAN COMPACT FLASH CONTROLLER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] ata: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 11:31:40 -0500
Message-ID: <20261102163141.3812536-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0017.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::7) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM7PR04MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea036f3-dfea-4d27-cbe7-08df38fecdd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|18002099003|56012099006|261102123227099003|10067099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|11063799006|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	m4TbCODDZbUkrOshIvLMnEgf61EWNfTM2hj+MLcFJBGhkm5Msb/rJssFsmRpNJoLdlHuhwv5QkJTfCd0l4TzCIoiAlWIujIgGDDpzNnxOITWYc29+F+KV1YQkUyauX+yGMgJqSOPCz2BeP9NaH3LhNlus6oVbDysAB2ogmGt6c6HZbUmnQKyXwSb4kEMhUu6SYAIzfz0ca5w0L74r+d1mnJHche3DxHb+SkQselYi1ICNnBn4A/LbPfdfvknBtL6O5V8xKwSfsCP4kAdC4zA8IG/RfqRw0f7sq67co7u+IKynXrhvCFX0Zk+BA58RGuncGQ1CcflXudi+dBFMhD/ZvvgvT8itSRC5miSOW9BNB8bvvappeBuPNNaftQroYBQ5/BjuatyCXoHy2ejQ5dbo69pIM0ksAVCD9tRDXo3uLGSs7ryDW43+CthDMwYJMrNkx7GhWlY27pf9ocAgrrtpq0kfCECV++uYY1bAJf1mkiPfWjKQzbhdywG5VOABCGAaQAsK4D0ueyJ0XyIivErthQHkDa6nD7lRnHqRjfktXKDmlmtzHbj/xyfLPLAB6AU+wr4chnSF5lGfQi3up+P6KyqM73JYDEpvw8/Wq+qwpIozOBGK3qM8xrKa6NnaV8Ah3a3LrBI0D0xTRy61ae6GFneJcuTVH7cGxTFbrsaQRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(18002099003)(56012099006)(261102123227099003)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GvO9N00KB19EzPnTiw1dNbTxz6NSUV/STX6PU3wr22NHci3L1SgaUCHallCO?=
 =?us-ascii?Q?aA76LMHGjcIdl9yDEvFH8bbQ2bOXaO7P5B2RAbN/q9KACln1yukGLJonMMdd?=
 =?us-ascii?Q?iVNdkdskpUB9bOWmFHEZGl/hJ+JH6rro1/2sBb0ABniQ6JgPqPZVDFiM1RDL?=
 =?us-ascii?Q?f+Okg4elx+a4NAtXt1vH/QsS0vK5xN9f5gYb2l5217kceb9s9Zzq4jHPT70s?=
 =?us-ascii?Q?iy96gT5kXXKjL1BsnmiraEM0OiyrNCaxhbQwgiYkIL9CncYd6QfrcAUXi7Cq?=
 =?us-ascii?Q?g4wfAl2VDGFHooZdv4mERJWdDHWqBLEPevaE7jfhlV/5QCUDzrJPrWPWzF/1?=
 =?us-ascii?Q?KPP/k3QgSAqmQYnM+9rqNB3TVv5rlUkd/AA9skv5rTB9tgUWtSr+SrEfnAkM?=
 =?us-ascii?Q?oPlGlmq8D/w73ClnDOoutOCJZy66MsJYCRTm9EV2SAFHiWlwrZhqZyH31e4c?=
 =?us-ascii?Q?ahBru+1rEDcE0cbao7UM010h1X5rK1kTVQgOdWAr4Rt1ly6vxz6LVumTUUHY?=
 =?us-ascii?Q?2UiKU9ljw41wBxaqPRcP8QJ1PwFPmoVEYAJqkGpWDRjcm0fe6M7pCrRbbuMM?=
 =?us-ascii?Q?iV+c8tccWcMvx+tgWRezHe7yDQ0QCZD3IJ4nf2j2fiwJE/BsvloqANu0r85j?=
 =?us-ascii?Q?X7dHWtI1QYdg4h0CW52rOLGydk9oPdArZJ+4gN+ngoA9IJa/SlFBq7jv9CJE?=
 =?us-ascii?Q?quefsCsy7aDrZbq9v8/8Mvh811Y6H69kfn6Zx+BRfIlP8eS9xR5Nl/sDqpXT?=
 =?us-ascii?Q?bBcZqqRF+kVE7PcOdvLePz1aSz1KtQt3lITTPvcsOiuzB4x/ZfopgwngN0j7?=
 =?us-ascii?Q?Fe7NtD9C6OK1VYjNxe86/2FAhm/UajQIewUiR0Jm/gp1Nx3I5US5dl4zCOqH?=
 =?us-ascii?Q?2rqt4QHwMtV8f0Jlzq7V//dU6zg+FUzwNTe+bypZGopoyx6/0fNKFXz2dUZp?=
 =?us-ascii?Q?5LzomT+w0acrGV3pHKDUbPLY1oO9Doc/tsjl6pcPHl7o3RusiS67v5kniB0t?=
 =?us-ascii?Q?6yn0Kl5JORucB4F75mY6kwrJekIJnRC084zR0cuW6kedUtMNYdqA8B59bomn?=
 =?us-ascii?Q?VUhIl0dsfGDV5RtaG/B7/RKXXUHfSNLFsvNj/DfpX4z+ACxJM9Q1faJJrcVc?=
 =?us-ascii?Q?6mryockykDSoznMyRSxmlvcC1HXECiPWZlfQLG8pKfMmKaqBWmdAsKMMpIwx?=
 =?us-ascii?Q?pMW5kMgn8QQmXB/VxeWDdJRRB2CQ2tUIKbdNdnKJq7cuYF+TlJtT4WxtOJGZ?=
 =?us-ascii?Q?tpPmgSLfybz3RuV9Yu6OL9La77N6XLzBjj+Gff+SG50TOWQodIITlvSI5DXr?=
 =?us-ascii?Q?5pWx4HIc5689kFyMqbDZ0d7MwsYYBLjl12oOYcvE+Yi061eF35RS8MKmOOzC?=
 =?us-ascii?Q?zuAmylTWqcaCcZ7QYOFm71Z+GLqWrN/zOj2/5HOka+u3/iRXycoNhbfxsw7Q?=
 =?us-ascii?Q?AaIg2SUoj23EK/+eME2slP/PTe3Q4orOJX4oXDlSATF350KYsvWb51K3XBOB?=
 =?us-ascii?Q?SYo19d2uB5cH8VokQrD+pWRhx02XeoUyvLETWRhmCE+dNMHbm8BBwkCp5MQb?=
 =?us-ascii?Q?ZgXeouWa/uXG7HQK4AecZ4iBp47AUYfq2A76twFq/CYNRL1wG5pmn4+BnlNO?=
 =?us-ascii?Q?ReC+a7ckRUeulITRqGKLZjGMViYDWMdXCE8iWdo9adwpyXk4Vrm1KAgJBQRg?=
 =?us-ascii?Q?BzMsvFE0YtZkWZr/htScV1PuFc1cnlLoSPiCBw62z0jVxcNkBP1bE+65rBId?=
 =?us-ascii?Q?f/yB+G9941/N7Q8f/dZzIcjMLGfU3UPNnMNlWSPjUwRL9hzwWLwt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea036f3-dfea-4d27-cbe7-08df38fecdd7
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:31:53.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CeNs9VzS9n2OkomoLNEHAKy26IwEJsujF9yuZSo62KjkNiAeHKPaV/dvvJr8h/xIdn19G8AJkjHgiDgdIBOsK/x7+3kva2cxFavpoGm2h5kZrj4YGJGfzwuaiUqmlLA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7191

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper.

No functional change intended. Prepare make to struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/ata/pata_arasan_cf.c | 3 +--
 drivers/ata/pata_ep93xx.c    | 3 +--
 drivers/ata/pata_pxa.c       | 3 +--
 drivers/ata/sata_dwc_460ex.c | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index a652a1b57338c..5bdfe46182472 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -406,8 +406,7 @@ dma_xfer(struct arasan_cf_dev *acdev, dma_addr_t src, dma_addr_t dest, u32 len)
 		return -EAGAIN;
 	}
 
-	tx->callback = dma_callback;
-	tx->callback_param = acdev;
+	dmaengine_desc_set_callback(tx, dma_callback, NULL, acdev);
 	cookie = dmaengine_submit(tx);
 
 	ret = dma_submit_error(cookie);
diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index 339ee5e43e9f3..9371c7499b208 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -727,8 +727,7 @@ static void ep93xx_pata_dma_start(struct ata_queued_cmd *qc)
 		dev_err(qc->ap->dev, "failed to prepare slave for sg dma\n");
 		return;
 	}
-	txd->callback = NULL;
-	txd->callback_param = NULL;
+	dmaengine_desc_set_callback(txd, NULL, NULL, NULL);
 
 	if (dmaengine_submit(txd) < 0) {
 		dev_err(qc->ap->dev, "failed to submit dma transfer\n");
diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index a694f6a178e31..04bba37c583bd 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -60,8 +60,7 @@ static enum ata_completion_errors pxa_qc_prep(struct ata_queued_cmd *qc)
 		ata_dev_err(qc->dev, "prep_slave_sg() failed\n");
 		return AC_ERR_OK;
 	}
-	tx->callback = pxa_ata_dma_irq;
-	tx->callback_param = pd;
+	dmaengine_desc_set_callback(tx, pxa_ata_dma_irq, NULL, pd);
 	pd->dma_cookie = dmaengine_submit(tx);
 
 	return AC_ERR_OK;
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index aa816a1a4c541..93a7651ec672d 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -347,8 +347,7 @@ static struct dma_async_tx_descriptor *dma_dwc_xfer_setup(struct ata_queued_cmd
 	if (!desc)
 		return NULL;
 
-	desc->callback = dma_dwc_xfer_done;
-	desc->callback_param = hsdev;
+	dmaengine_desc_set_callback(desc, dma_dwc_xfer_done, NULL, hsdev);
 
 	dev_dbg(hsdev->dev, "%s sg: 0x%p, count: %d addr: %pa\n", __func__,
 		qc->sg, qc->n_elem, &hsdev->dmadr);
-- 
2.43.0

