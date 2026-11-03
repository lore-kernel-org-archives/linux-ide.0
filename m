Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793741079;
	b=nfDnPJRCtgQjOzddsm3OL3HYwife1huJnM9echO63uCT1iqYAWcB7EONeFVTWCAcqKWO
	 GyZvcUCsSC9CeNpSVHyjk+SYbd+ptVK+sJkcftL3aLMF6POQmdapitWGUkRPrPUgSTD/l
	 EVBsu/yTIp0iquhq5p5TqhLdN6+H6LCMuLLQUIEylsttR3w6y37jOZBFTlea1fEa5dnS2
	 pO5ZyioYwIO/cgMqb9Q0N5JHPRKMJiYEr9S0hkn8iRsCuvdXqiVJGf6fByPPqfoQ8rxcq
	 4UVfGRSa+F66/3fFROxLFyAczA5crA8j8JpkfbBtloSBStucBmvW7C+hQM+tq9OE8xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741079;
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
	bh=8JCSeEmtweA3zHPtQ4UwFzjPhjSGHy5GvTCS39yDL5Y=;
	b=j7YiXnt5aU7tP0VJBLnPpkrLTL90XH+FGIi4QqhVSben4OijGaZcYi8xqeneeiffzqSN
	 v16jqczS0ZagXfJOmeD6QwHSyzfzRfBfOlQ1mLiHbErBTkew1r0xmXXn3lcuH/KHmXke/
	 Sy078QxMzCEo4OvnujXO+U3sfBpEKA+u/0ExnSDvXJRn6aWa2n6QxdeM8agEwEk73p4yk
	 vZYnUii+Q3UxKjP0Z/UyoFlN2pSFHiPmXZ+Ux15xVABvPiQW/XUfQM7e3uRkNGsXWNdcN
	 UWZNuTyxYIPtERqlOXEsZac5OjxGrMGNUVGhfxucm/g1Li7Gkf0DevIi0zY9zobTjFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aBPeXHFw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.36
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB50606A31B;
	Tue,  3 Nov 2026 21:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DB50606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=aBPeXHFw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aj88lK4yWYJCfEUUZwE6bjHgNOn9u+SyuQB2eMpSAke1z1u2nXuDkAK6QG+LaTY9kEC0+BK7eAkaKoBP7cdb5Bl9vPDUqIFiZjb7LGr99Rv1IZgCTe4qv7jdWflMBqw1sL3FZfE6L9Y8CSeCRKuKJlGHqlifxm9LjW19YBYfJIR9ZLYDmPjEekwadtLQap0K+cILCBzSHuY/YQmCaWenUpl+P/6aCTyTBMADlqzpVVT6SfXO4/BdGUUhwX7xodwNo+8IpQinhPFAKz8/xD8RwZ7UagJ8HENRkk+zBJtfq9FoRW9gfP0VPdzzealIdcXL4tcK+g9uWboK/l4WiyOBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JCSeEmtweA3zHPtQ4UwFzjPhjSGHy5GvTCS39yDL5Y=;
 b=kAs1316YOxiA9fCECtRzUMH7776cii8Vn5E+OD6eah8qzyoONm7DDchN4MBT4xUnnao/b4VN4zdBSVkJ4JDCYwRfFfmSWRgmlm0MPC9wzIIhFN2t1SBmmzqGYVo0jLsq2IONqedQaIINQxcHPD4kMQrxvnBXxaP+Dlhq8ctU/OHR6ECjqzQE2r+KMEwhTk1JUJRd39tV7oZSovz05B4tjDleovLR2MnzNx+qi4u2lNOIK1cjKYQJW7QMW7GT61kb//4C6+Bhne/shhpzkRlnr36bta+Wvr4su1CwegeWpQGPsm0IadfBQkNmx+dK/fO90Ma3K1vgZ5rubtIc0qfzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JCSeEmtweA3zHPtQ4UwFzjPhjSGHy5GvTCS39yDL5Y=;
 b=aBPeXHFwuOxo8L+mIFDrGvigc+jHUAaC61O4CO3nI4Ijiogx57EjayjH0Mq/JudqsJAThk0G9Zz/tCbmkEHD4OVfEFubLkrV7OrAr2VqzKVqrj1lyLqknbPiMU8wq5TumWg4NmaklvmDcrpBifQdkIzIb8+/VVKog1Q+3mQE6iiVC/Q+QF4wBASb8xV0Kv1/UUiRza59vfdhAzRs7L8Sk/FUohhxZ9cAAU3NGuY5ofQceZD2kuoCmIqgBfKo2DV+UphN0SR+oBhR4Im5JkYFXBozWkBYzcJfN1vazq4y0/B7ZEf18wqxp5sOPAY6XW0TJSFRsMaxERhWz4dcVC36bQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by MI7PR04MB364121.eurprd04.prod.outlook.com (2603:10a6:290:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:24:36 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 21:24:36 +0000
From: Frank.Li@oss.nxp.com
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] ata: replace chan->device->dev with dmaengine_get_provider_device()
Date: Tue,  3 Nov 2026 16:24:27 -0500
Message-ID: <20261103212427.1769922-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|MI7PR04MB364121:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f0c27e-2c9c-4f64-df1d-08df39f0dc26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|23010399003|18002099003|261102123227099003|56012099006|10067099003|261009223027099003|261022105027099003|261021121427099003|261021123027099003|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Sm14oP3B000PCiObrGdbRS+gzl7yIXHwBQWtVpNnTh8vTOSHaJVk4z5XY25cM1eDz5BPcvK52NcEdB21wzdV0Nys1TeYUSurZcGzmsscd8pHwmuqJ60v59Vac5jkCFJuTF0TS11EDeV0bChXl+0ud1KjdQukJ8IseoxbvvLw85+GpqYgg3WrGfIeZhs4nBlSpqCyKyLFSoqD3jAYsilUdrBZv2hcKsEWgNuxafi4OUJZB1aBocKljVN8VW1pyBQ33qBrgntH5DJl29YBxXEnMzbf2VlULJVy57vDoTJsUf/RqzQurqI8+yOo9E0mSwsrlo00BXT+p2uG04oqmI54GTt9vIwtRebCTg41vcqAu/BHVDoG8VpPLOkljX5gCEzShwQxcy0XBJ0vufD4D28UqAD5+64dKm9ykA35x3tVgjxbq4iqgCP71kZd3E2aX99RCgNP7Fs4h5Oh+aQ5lsPJWD81LpNvXd0QwXQTMcqYX5zynm1T2WBhlIJLBWJ152b1h5d9tVVHXNImlQf6sha3FW2xM9jRayKiGqnYMdIUy0CHlj0VUG0I47CjiweyFH4Jf1+s4AMyKYtDyAXGt4kCvHrI9DCRNoQUtAawmM25C27Dto97gB4G6clemWHvZHI5yjdX8f3PoIce2E8E7NcwKPWpntBqt5QCcuuRDhdIgIE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(18002099003)(261102123227099003)(56012099006)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(11063799006)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jTVKmh9E28my7/KrQ387yBtS62jwmcq9eabIVT4mPjRkkWleY1EBWxXAsgl8?=
 =?us-ascii?Q?Apb8VhutB2lu3oEzycJeO9qWLOnmZbz0eO7yO+5fuzEfTGLRv1og0tycZJSi?=
 =?us-ascii?Q?bQb+ZOGg1d4ez7WPrdcmbLccALUK1VOXNb+zjEbPgoajBsNqXbpeZ3I4n71l?=
 =?us-ascii?Q?3JIARBJ/dWZCy+778Zwi8py+VME03tIXgH3hctR+jK3nO6whGE8ieSUfYode?=
 =?us-ascii?Q?4v3BhNmzNnh7kzGCijQVZ7Z3dL/qyRFOpGxdY/V4ZdMjGNViWwWRoxPGhG3f?=
 =?us-ascii?Q?C14rDCGOGJcXSuYfMpgZ8BiXodJOCSTmx2yEySqteqXo8rMDTDpAqWDvJUOq?=
 =?us-ascii?Q?OjiO4g+a0xgTZsLwC7bUz3SFSW4m7Xlf1SCoDMBT6WgTfz0oTrY0SgruiTNc?=
 =?us-ascii?Q?TonEtvxXPxtRnKmcSbaRpuab6OB7t2RIVbmi4B1e/K3PB2H8bgvbJo5DXqEX?=
 =?us-ascii?Q?SuT9lkeInO9XWzaMgcOH9aSDrPaIvoax2RvVkXmD/Ncqz0CXucUD7ff3TV3S?=
 =?us-ascii?Q?2OCb8PkTiLT3F7EeARIV5M9uH14M89ysUfHdgCS5wfVrL2pMTTxn2Wjwb4Ii?=
 =?us-ascii?Q?padVm8oqUUNQnlTzzm0BueP8O2J3HaFC85VbxaDr4IMp4m5ALkUqFlsa/Ufb?=
 =?us-ascii?Q?AHFUDdWYoEWu0VjvrFgj7Om97mzO9LKD02NuysaCczQfnIaAghYBS0kHrufe?=
 =?us-ascii?Q?+thmp4C2xo2DHia1O+atIUmDS9bc2/TBmkRmhHTcIBN0yR9I+g0+dpHrIyEB?=
 =?us-ascii?Q?J5WJj6g4l5f0Oie9m8EeXTJO/4FVUs/Mxwg3mTkmfGOK4td5fBDx0+3MdFmT?=
 =?us-ascii?Q?t5+16s7VnGuKo4h8aZNWehjn702etE2kzIMdNNMNWsW3yK5zifyq5T81JGEw?=
 =?us-ascii?Q?ioXLa7q037wZvhYTOElprwtvx6+GAxg+4QMQFrmqlK+DSIlPu3QeD/ygEJHp?=
 =?us-ascii?Q?+F3KiMAw6t+H36HP6TSLp5fqDe+pcBZWstH4p11Vptszg4qqUjmqVO/lwnwB?=
 =?us-ascii?Q?otSw1EVAsDzoF0EG6eg80OMkqjjgKnLm6thld2oIjwsU8+HeCIopV9k0QltJ?=
 =?us-ascii?Q?jTVVgSb73DqG7F8LfehO6QMU1w1BNN+/THzkovRZZfGEdvwDKKKB4fYQ9SuF?=
 =?us-ascii?Q?3Bqqt9UZVAclmQW6w3fScZP7eEYOMh9r43N96XpLnn0jC6adG0/GHM8HHd/d?=
 =?us-ascii?Q?ZeCl3IgX6FoLNyDDwxEDVKZEiL8x18pRKzRqyB0qd9IRvioztyXBLVTNW1D0?=
 =?us-ascii?Q?f9Gf12aoZ5hv3OMm67z/qwzVdszUmW93s9rTr5wVPr0UuXTh80LdyUpPI/G/?=
 =?us-ascii?Q?+xCWs8wfWNiOQdPnStP9RBcyMF8ureEdiWf2MPGvYRmDOnSjXVz1xwjj2OKj?=
 =?us-ascii?Q?45+Nj7HGW+eds5CUfHIBcvCmePvMtYJce5eurYsq5rzGtSGRLdLEBqb2RSDA?=
 =?us-ascii?Q?mSojvmYq2eUQc2NsU5YTY4ANlcVm1t90z5f1op3AARY3+fVAZocfmHyN96Ld?=
 =?us-ascii?Q?qWg1yw6ndGUJEGwf4pt/g3tBk9NE+fA1rX2TPgVOyjJfLyE16cK2f4O0QTgy?=
 =?us-ascii?Q?8zN9P+p9vPfyxS4h+XePmrD5hRbkyPsXrq4NEb1jbgmpk1PXk09ihVZItak+?=
 =?us-ascii?Q?1f5cwaJ0keb5KqP/Mif7K193yjgsaq2rYfdHrW1j6VJQS+43tvoQprdyhUBR?=
 =?us-ascii?Q?RLPFJE48N/pMivkwEMYK7tOObYRsXe0e9baKZvZyiOugZxnETutQuqSebzvZ?=
 =?us-ascii?Q?98PacaF7AtLMWAr5/1EzmhM3oqXsZLkP6YRx/fZKddziE0hT62xm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f0c27e-2c9c-4f64-df1d-08df39f0dc26
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:24:35.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuhIqNLhoHUNPkH+b9f7BCrzs6ijSCc5ItO3KqeuZRsrSsc243syKERWPwVtw2zClk7czIxqrUxqUejtIDyk6dOKO2s/v3+DpmpGVG97m1WVAIpIV91B+uzBHBmDleNf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR04MB364121

From: Frank Li <Frank.Li@nxp.com>

Use the dmaengine_get_provider_device() API instead of directly
accessing chan->device->dev to get the DMA provider device.

No functional change intended. Prepare make to struct dma_device private
to the DMA engine.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
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

