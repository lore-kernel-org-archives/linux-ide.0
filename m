Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793804786;
	b=232quQePs14L9FynzNQpWqFYyFNzJKp4Md9l88S8PqAVTRpRxI74Fjaa7BOUIqZmfaPh
	 y+/FUKqxSugNkcb4kXkYQcuJ2AQ/y/9tMdWE0+X4AN2W1q+uUZ2ECl8nSqfnyETazb22F
	 cPKn91T9C4XpdhxPUuiOpVIRADNOWsKj7wgNUT2WXIWe+bgfEzW82zW2Natt2ZdH0b29k
	 WickiGGDc8u57LqZ6MjFIgtJ5s0ukzjTyVRKm9ZZ56pqJM5j2i+onjd4pXLdW33fL2cze
	 +UTD9lbD49+eON1rpkSwB5n3t/QovDpFE8lGRdWIdPtgdrjTWKcC8+FHVx+8t2x8hxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804786;
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
	bh=HHs2Mol2JA6MuHFu3mHss7iLnCnmNRxGBe2b6ph8QZc=;
	b=BwRuWvDs2Dh6w2A5MA8mVxMGoCI2hVUG+G7hEywq9H8tYqDfvdzmiPiCvr0ia7rH9dMi
	 78qyuuUp2l6UBvXxyZcSkB85ru6Dbctx04MTViBxeSLNUIwPofSWKC7r8OxrJ6jVn5LLY
	 9W+lyh1Qa3+z5EfZhKjlGrnhfBMTgfjLELyYH3Uw9tE1atasBaYEyJSr25qi3zwhR2gBz
	 IVBKf17dewQoQDOi1rP9sAMD+Q49EKC6sgOpMrM+Ygz4ZovAy3EHCe5tXx+ulwcq8RHjM
	 74xduhipIOKbXI1ru6ARvm5lz8BC/KZWMT1WK01zYiMR4VG5NZROqZkcsjD6z3A0LPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oRaHo03v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.59
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2E1606A328;
	Wed,  4 Nov 2026 15:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A2E1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oRaHo03v
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unuKfaEcnJXXLgLcxWEhnXaiR4tb/paPcCijHKHXpxwyYGaJv2VlFs5rGCIPfKLuOedbqGphjYtvRSA4PU6NHYLPaagZUXGw0BIZs8C3x/WNYyVoKqvj/UlVQrJ9+lcMkeGo/LB5u9M6+m/7ChRqoNGdiC5RtsDoZFHd3eLPl2R0tvqc2g2S+X2kvOd0xJtYUnCxbRL4afA8oMeTjcnhGnEaMWDjk3zmVqpa/TZaiypgP1/mv1gGaI6S0wRcM25QLQ/G0KtVlPToBWxArOe6bZhGPhVaYdnzHnnGvSRJZglBUfwilLatV1egUQMgfNGsw6XBmOY+wQlndTJeutsfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHs2Mol2JA6MuHFu3mHss7iLnCnmNRxGBe2b6ph8QZc=;
 b=WNBNF2Co84fSaVDj8ijktLRseAOJ0ysJs3Wou2/4UQZYBPDjHf/3CIpF8IpeDC0n4w7FgGeOoszwZHBQ3cyMLpD1M0gryGDnanIhsoBN228H5Ol/tOneZ2MDI0JdREKQp2+uswj/FftAZ5kIGVHgn5fS2Qbim62MB6dVPq0uE4220fgRi9ojBKbOpwZZXG2yAffQ3zWhYzacmnJFEW9ulOVuTwC3i+e2ISMaKr8aJflBfaNAlF41iPwoNc1Xps5WdP71A2QcXCylNz9ENDMsiCfPSmttDHwcxAtIP9OJxPbzSecBJzwgk+A28wgqkZAyOmb0EQl3tvC913L9AkvQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHs2Mol2JA6MuHFu3mHss7iLnCnmNRxGBe2b6ph8QZc=;
 b=oRaHo03vQRU9DjwuSejhEOqN3LLACerRkizOnDRBvvcDonrvwsFLmG+7h5yPC+lBWh8nVdqaQma3uoKDRGyAKjkGQ2nxq1ZsbvLy6BoyR2SPLyk7MLOV2rg9vwhv9tECU6bYeXwUIq71/Z5IWcElzvY5T0fdzU/eLIg6qnD15uvRxYVOVYfoLVU/r+vTDK4JOpGzfAi+7FQGrMa8Rv7tziSMpeoiyLoqyiBrrfPtD4ajWobKjeOOv5aelp9AKvQe1EMzdEH+sxK7KQfgAyEvIQpSCkAhaIxXteGcAqpLRoSyMgUNX3uvjz79YT+OYOcSm9RpQRFDj3Pe+9ZqtVTUpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 15:06:21 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:06:21 +0000
From: Frank.Li@oss.nxp.com
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 1/1] ata: sata_dwc_460ex: replace chan->device->dev with dmaengine_get_provider_device()
Date: Wed,  4 Nov 2026 10:06:13 -0500
Message-ID: <20261104150614.3231589-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF0001330F.namprd07.prod.outlook.com
 (2603:10b6:518:1::a) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DBBPR04MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1221c2-43f5-4bd5-abc8-08df3a852f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|23010399003|366016|10067099003|18002099003|56012099006|11063799006|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021123027099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	2o/hnlLis7EsOU7ixkCxjHfJDnVf7wXtMu8cj/scKh9rmCfYhOcqOPoM+fvY1oEKZ4VFSwQdiUlpZ+WTfYyPeS5qKvOelzNn1raySN87c0CbfFpl+8S7I8Zjhpp1SfwoiTsxxf886Z4A6Kbw6Pk2D7ZU+4gxj+GYRdRXR3Jlqvp4JxMUehQw1zmwc6lVXZCfH3/wmyxVMsmW5z+fzs/fttqrunBQMIKZlBP7m5sJaC6kg7O9N+t3EYq4zRv9dQUM6a+LdWqasJ0Vv4HFp0Vp1CvlJZ5PtiBMl2uY19hey0amugrWHE0Lul8yxgDlSR4LGLHLbY4YD/X0LR8sUF0zvwxVeUGjKQbGPIKEZtBAYy7wEImoKFZsihxMJQXJSacMyryaMIUvL0/oWEEuDkQihwnZevJLwoQ0SdoP2OjlnxqNZJKynZ3K8kSBoFvK6AhdwaN8+EDPH60UepO3CL+Cuv+KEoJ9xNcHt7nvVXS22rDCafdhuigAt8Hf3eW0WvKB2FTGxARg3oWxfOuMDpo85f5npCuHDAfvVcADZSWLPtwsVpUo92gUbMORfgq2tyW0aFJcC062x1o45WkgTgRb+DEB0G5CiPoINoQkU8MULGvbwe6QYlSCB4a2o7t4V04TOVF9SDWdKHHO7C61uImuEXNEmOKfkee/bYLVGK/9Nn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(23010399003)(366016)(10067099003)(18002099003)(56012099006)(11063799006)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021123027099003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dwB9SCvPgqMnv3I3HzPNmtMFrmpEskL6Q+ytRe7nIFay/owvc+aF5RzNxMN+?=
 =?us-ascii?Q?vIPtxpg8O/epBpIom73e6fOM4f1dT9da0CvjjG2NyRCrx3bFnoSW6KAgIbhg?=
 =?us-ascii?Q?o0zk6CxBB5LudKqIvxLLlkuEdYUgUCyFrqC6GwJXtmauLCw0ladCAw7XQhFN?=
 =?us-ascii?Q?fW2Swbt1RpmJRxVvcquLZ4UnA+Az5SbJTlM2FoBR3PISxTD3Ca5KyUWzcw4x?=
 =?us-ascii?Q?in38eweW2GMFGXgEzQd5t464NycF46dumPzz9LWnJf9j/GWe3Azo//wJaOEX?=
 =?us-ascii?Q?69jB4afi4Tq9qE0k88pp6Ik3+bk0LGDeaOT+O/6d0ctL8dOTqJrCIjQhMnZW?=
 =?us-ascii?Q?/mmk/EKmFsrA1i6KZTm0tHj2eLJ+8GgYWVKrq2810UCVFBcBsKSUlX6wp3Zs?=
 =?us-ascii?Q?PqYanDw5esZk0QJfEvNhHiBt/EN6NMQzyHu28eltm6AAtHM2/IZKr0TImZ+N?=
 =?us-ascii?Q?tbj0hq2vDzuMklAaDjp1OqUtZsljx88m0zSzPNDY62tZjEJoO5vjf3N+VaUj?=
 =?us-ascii?Q?oPvRMH7aGMvUT5uMSgFjMjXoL45wxLaIJBDxaMRMjugAWAMqcvBHOnRUTzSg?=
 =?us-ascii?Q?9N3RW/iME92YFdTovYK646Znn3ARthIP7d9YPYJr1LuHIZe7cTOCpHDTJoKb?=
 =?us-ascii?Q?gZboWv7mVOnX393CzgdKwcQIb+RBIX5QMS8v0Ge5EcWd/nh0LJde+ddCFXlW?=
 =?us-ascii?Q?ezmCLUbge9CWHYi2phcVKWo12VN+kKC/Wk1Qj/kgh2aVdepj63Xuz9xrgQy3?=
 =?us-ascii?Q?3eLkW4fCdgX1BUDi0E4+lR67q3xAi9X/eCuLaoa6iG1tuBPHBhznYSlUQ077?=
 =?us-ascii?Q?aFMYgWEjixAH4fScmh/kheFLx4NdW/VtXD0+9793kqPJcylmIf1H9kIWtxXD?=
 =?us-ascii?Q?rt/TwHPN7cd6EmXdyA3WqvTNmanzf9TdY5lBEvNAvYJSlc4RbJjerxUd/B4q?=
 =?us-ascii?Q?mu1zwrLRi5B8G+6Cm2syHvw32IGWW+D1Op/dwhBUuoOM/3xSJfp6jeng7qiH?=
 =?us-ascii?Q?MKVK5O1iQqpU1yQ/3olwyJDpa2V0fRMZ7Ra4FlAkppqTLmZJ+XkOIPbSCxPW?=
 =?us-ascii?Q?/ZCr9KUSV2rN6BNJmLEQTba2N1VFHInvawxA8QIUoLrzbviCsxXiXmOUkQ6d?=
 =?us-ascii?Q?nVRLfagmixgbQgAz2PspuzZLlBKb3WqxdxzlBhvgZEzbKzwrNwOUzFALCw0M?=
 =?us-ascii?Q?TnN7TG1KScmBXEGxofXUPdK01SH7roaQXW2nT6s8KqQbgEKaKeYeSYPei9uX?=
 =?us-ascii?Q?oKUrxDoRYYwAtRNo238oekbH1do9XaTIJz0Kui6VnJ3d0Bqrs5+t8/Be5ejR?=
 =?us-ascii?Q?Cw9B1ClSL2AqumjCRE9LfhPxTNjs9DqPg2GLW7ejGy6fjakTwrohJMUnsqBw?=
 =?us-ascii?Q?7PvLgUZ/cfm2rMd+mZngUi0izndyGhYkhDlx3xOHGP3N4PVS+0Ewehz04ahx?=
 =?us-ascii?Q?9vwCJzK8KLJehCaBjqmN0p6dzRUSnb7/EVM3LOXLLkGy63cYEqskio6bkLcO?=
 =?us-ascii?Q?YaVBI03tGhsmUsHFwqiG8v4DQ0rDyVnaDB3BPJMcQz7aaH8MUFMAoB1Jt38J?=
 =?us-ascii?Q?tpRKovaamMvHkj2V36KM0NRB6xGOmBHvln9JsLG3Wpf8RWxK6QGdq1lKwcq3?=
 =?us-ascii?Q?lvk3HvMhbLtNaFbaLKEuSuE+bCQK1UBtWu6N1c861mgmBrwAD3XMm6cdEPxw?=
 =?us-ascii?Q?0eOLSVJ8zm4Om+kxkyaFMm82R75ftX0GXF/YX+V3K/kAlTe3VZnSRkM+9iqk?=
 =?us-ascii?Q?SMvkiHoWDuPgvLJttDz88yINnJkvnNHxeLisk3IMGYxV1WrYlKy0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1221c2-43f5-4bd5-abc8-08df3a852f5c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:06:21.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Qqt7tsYaMlEBU/vFIscaYL0LnHEjDqKgWoRlpzj9M2f2vEOmmX72+84HQaWOL6L3r0h56B4L3QhKwbLlmWid1GXK5fYsbOjPIRVkkRN3BJ3W6LkqFOTMSe6v6TQIBYf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913

From: Frank Li <Frank.Li@nxp.com>

Use the dmaengine_get_provider_device() API instead of directly
accessing chan->device->dev to get the DMA provider device.

No functional change intended. Prepare make to struct dma_device private
to the DMA engine.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- collect  Damien Le Moal review tags
- add sata_dwc_460ex in subject
- remove assisted-by: llm
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 93a7651ec672d..5bfad9a8c8162 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -192,7 +192,7 @@ static bool sata_dwc_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *dws = &sata_dwc_dma_dws;
 
-	if (dws->dma_dev != chan->device->dev)
+	if (dws->dma_dev != dmaengine_get_provider_device(chan))
 		return false;
 
 	chan->private = dws;
-- 
2.43.0

