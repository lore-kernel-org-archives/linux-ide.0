Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6413909A6;
	Thu, 17 Sep 2026 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671820; cv=fail; b=JK7nISeI2PbudM0wVXED7QvFkrwD6XvASFGowRd6gadjChjydkfesFeSBypI0UviXCaZpuJ0XF6miByZf69ESxcgoQZ0RnpsRmHrG2SmGoww9rTsLSCT4qoCmeMMb8LZseQyGP1uD+s9CkrewO2SVFudmzfbn+bEmok4RfnMF78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671820; c=relaxed/simple;
	bh=LFcxubnsZxGHaq7fw+ZP6CfL5S2eMwTslVcWXtwk5KI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ConAeIRK+k2Y5CzNfw4kQhgjirp2oqAYRNdAKomvQf4aDSzX4QIwPsVi/c/nbYa8Uxf/OZu+jbL33LNlFWGTWIQDQbeWDbYBLt00q439hIsLyf8BaFnWdCCOEr/NiTaXzdXpENCG5JEBdObCuFRab2Qpo25jpChRkmMH8zhu4rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cYCZVlu1; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cYCZVlu1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWLU+fPdC8MPuW0nynJW3cEj6YboAh2UuwZpLQlc6rA3fzlrTkCsyh78pZdaIdskpdc4kZGpch9ALOhRypP/Y/FH7j7i4X5E2RoMwWpjbvzqOoe+i4D7/gHC3sGuS9KegG+bOEyUCzW2QMcx5mPghZFM63w+Q40mSwM5LUfVjvd8i0vITaPkX3r8P4VTRaBx7OKtAzSpg2XkgNDCMkKyXK0B7ifk8q+5VXnucrmvUh1sPtia2FLmWcydiUR6fx8AdGmtPfaY+mPOweprLEoLjFKDRlDLVE9r9J80401IPMGCW9a5CavE+jjCJhUgxixmjGgX3xHxayMg0pHIXmr8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZWP2w6yXvZuXtmKM8TA9KAgSs0L4s7MEoMqIZ0ZLTU=;
 b=YXxbCtXySE/WJ1BqrJMNCvHgyAGcHCAJRCSsO3HGDKtNrxzYO/BHC1ATXq/XRwr7MK18pc1PLLdV9xuasAfrUDDAAgFD+ZvWUjcIcAY3y4xqTWblS3PtdXzMFUT2UgtB+RKHC5FysS0RvGwU2kI9Um6FLtylo2RJaSzqKEnevOy7YDj/AoW/GA0srbmbpBT6Oqm0rlPwo2yzLyErpJd24HT5hdHrZcgIiLAhUpPMzxpn8aYTV5jjcHDWzslE/aJULZamRtFa+v/SSrFrgMll0kHEECQ9MDOjWA6V9ORNkV8NO3Yo/FLag1qYC6koyl0uFGD4OaNAqaHJJxGqffueyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZWP2w6yXvZuXtmKM8TA9KAgSs0L4s7MEoMqIZ0ZLTU=;
 b=cYCZVlu1gEXr2rw7REbyzVqc0Wq2AqEj3o6dHKdAQ0L2+QmLiSkm2JrjXxWzh0g64RZNOAtFUWPq2IQKjLLQghCRy73TxRdD70pRtlQ8YXQL5rxDRcKW6ZG7i8c4zXNN0y4tGllpw/3vZK9or119bdCE/7NhsPPRcYwz0a1O6jgvGy9qZxA9FYmFjpmRhhQ42uIYD7d17T4kkBEQF5e9WOkGaXOhKXyjZeyyC6rGd688PpFTbQJmHPt91uQHgZxanbUPBxaHuAIpV7Kv4AiCVHnH5cTQABVFyPTDavSPoyl4iv/Xbt6kk7ll2/cvoBo+QIZBQLPgM9ENhHEfJmIbBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Thu, 17 Sep
 2026 19:03:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 19:03:33 +0000
From: Frank.Li@oss.nxp.com
To: Viresh Kumar <vireshk@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org (open list:LIBATA PATA ARASAN COMPACT FLASH CONTROLLER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] ata: pata_arasan_cf: use standard DMA engine API
Date: Thu, 17 Sep 2026 15:03:14 -0400
Message-ID: <20260917190315.1188379-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:510:323::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 02722374-a76b-4402-a8fd-08df14ee5e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	q20es7zWl90fKYJdVjmbKmRLg3dz6kgFWuB9O5xzQjKqEp12wNAV6aCLY9mPAvjwXsjSxnmEHC3QyrI2ByRuwgW5+WVrXq6EtVhEehKo/wz+pzYCe5k7oNo4nA0UVw/noM/jRlvbQoTxWpQCVoFmBpea1/vDYEhdDlTFDF8C1f40GrRjRpat9nArEEO3OLLCvjAlGEjPDTIIIgaJO54+RabbSnll3bEsLSDUS7jVcdE2IxDcwTbXp6+n4mVpWLwSwK2WE1cbR6VRCi+9ORqDRbFvl1c12OGa7iZsChL1dM5BDoE6+QE+KIao6HFOPJCzmOv3Wc1meUDh/V1cml7ves4XF+eRNNcuPeGkTTHl9aoBjA0a92ruL1qY5qc63OGb6qSUJ8TcEFAj+nKq66IfnDf4/d3KR9uvo4QdqvF7a/FWKQXo3eOz93plu7Y7xke3j/Fc54g4QxYONVIhiN/qfwIUep9EyI1Cg4ZVl8dtoEXsQcwuj2bZwMouEd1OAE+E6Cj8NQ2pKHHZ0dwJLq+y7peqr1oHcXD6eNx7Y6wxDK7FvYKi5Ns0/p3pDmPQN9mYgNHBeBvzdtZmG71zZf4R5cv8MtIwg+APRzbOrh5oa7sQSv7nCAD/XGlzWEBmjDsLPwW5MUs/ZzI5HrMm7WlAe20SqE2kqb9yXMUZF8ojU8w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1CyyF0815kEgoMp+DjG/LojU893HI6m3IMUcO/BZcXr1gpIpW5/Psg/ANPX?=
 =?us-ascii?Q?MsYO6Hjs5X1lFKMVTxY000lXUuPjQxoVQNuDsUtJoKkBCi/tMkv287fgkz/A?=
 =?us-ascii?Q?uLPcKtO6Q8QcmhtCzf0MvT0hOZO5epRl/uyioi1pPq40+HDojry7inGldc/p?=
 =?us-ascii?Q?AxcUpv6tRvjJIwMKBYZEcT48oDfRGYI42XHzmfZ7hZ8h/HK6Y9B5D9R6x291?=
 =?us-ascii?Q?swF5rYB0tWoSUAPZXlq8/nNtRc8au9SJNIg2v4nIyOv2jbadptz4HEPptILK?=
 =?us-ascii?Q?tKoNAFBc6OUVpjzFSfaZz7AxJP018LFocTTZg+4OKHeVE0UIxKqjBZ8+pPOB?=
 =?us-ascii?Q?qQv+Dr3fapJ8M6Zi7Y1hJqmBxNcxGl78wP89MJbCEPSZUfxSaNMVuRbKC9Xc?=
 =?us-ascii?Q?aK1yM4WL/GEwUUcllkKllmIZEEiyD2fiXzGI1BzhgzAb3Kh6GIcLxDyUnsS4?=
 =?us-ascii?Q?Wz/8XffwThLGokShnJhJbrebMbDUqxNpY7YSjoFHPy1MqJw3+hIVYE9WW8jc?=
 =?us-ascii?Q?pyfPsicjFXl+4qjPdrFRgrpHceswCgXKUYcUh1U3ULnH1ZexrAhNJOrBzROo?=
 =?us-ascii?Q?LUdwaUwgtBiGqe4V2Z1+ZZSgioDN9GvluGMSpBjjGiR5GbYJRBnQgvVRBWSm?=
 =?us-ascii?Q?sgvOop81angWIKNW5TDQF2R1Up3/4FXxK92llPtMjELdMTxLPeCZJkUZrEyh?=
 =?us-ascii?Q?/qJElkk1FD1m3w3Xh14Kl2AOJ1D7L6Ar7sgbIkAAOpCUzEomgje0QhktWXhC?=
 =?us-ascii?Q?A2cfx+tBEh0Zq6FB8a3AbqII6SumyPwtj6/cHrRhgWsKIsp0pLu1mZRk3mM0?=
 =?us-ascii?Q?6NP7o8fHyXcb/8J3Kl1xyFzZZVyXjb/0cVWphp+RbQnnRMPnzocW5LztNkOh?=
 =?us-ascii?Q?F2SUBT8isiRpGutW3vozLtVDJPBqcm5+SrhHyjEK4+UvXwZilUna2B8SkRtz?=
 =?us-ascii?Q?kLVgWyj2XJYKoXW6Xxi50yV9dzY1ZP+ZtZvFhxU3Qq+MYDsXEQ4bNKuCe/Sg?=
 =?us-ascii?Q?ZEydOZi2RRa2RNUG9rwy1xHGeCI5+5DPlwUoZUCtJH6i/kDNAa7rbAJYmIqQ?=
 =?us-ascii?Q?tt4ZfkXXgeFN9nuO75oKscxRBB7U9bX01Xy5uZ3bEbj+qFBYe4SjBStXVoD5?=
 =?us-ascii?Q?mkOUKra+Mdxe5rZMKw4Qch9C0fe3siivaCuF617fkOLXkvUw59gdpkYV+AXu?=
 =?us-ascii?Q?2RQ8XQJe0Ct3AC93SgIGTkMER4WJWYRYpUBI1snkukebRUhQHlZ216L6tYdQ?=
 =?us-ascii?Q?uSgVAqdDRyu5LOzzCwhDdW/hSXhD5XVzSivQF0mXetnVLuw0vWW+y9o2TcHd?=
 =?us-ascii?Q?VrUmcidDEqZPadOHXNSfLjMou3mIgYzDR5FuPkV0jQWu3kx40YFmUZAgGEjG?=
 =?us-ascii?Q?fJv5Q5C3YlW85MW9C3E/+uhZlEpgprxzpozRNM48CrxrqklrVVGiYPujnr8b?=
 =?us-ascii?Q?uflDnW2tfHUrPxoYEUhVnm/T7CCbZ3rYLOcucPlrtBHZfr1XpO1CYKUexIRn?=
 =?us-ascii?Q?3alDqi+GkEqFWU5u6BQ79IJ16uwNJOEkxf1/mrZ+CvPPOgECqAkaHuXdLIwy?=
 =?us-ascii?Q?MmLCGdl1LjcC6lv6V335XOcMnOe3/dGTXh+3DVr5Df4htMyFFQdkZyOHCyfz?=
 =?us-ascii?Q?oqNSwgBH5e5VPz9iiKJWrkJH4NU3xRp83gfo7YZDCA0KOxA9DoF39BmfT+HT?=
 =?us-ascii?Q?fx5ZRGFi6wx7FcDxP1MBg1oEkwWvvdxFNveP0STaeh7NenIXeG5L6y0n2iDz?=
 =?us-ascii?Q?1mzfADNrvLNlFOyjXbgFrgNU6yClUC5JmTlw4ZUAubgEq4MW0oow?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02722374-a76b-4402-a8fd-08df14ee5e74
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:03:33.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOKKRQ7HHfwhirwUpsMSyF3q1OveUDx78s0A/7cy9oQoz+kosi2YfejQbRl5G19wRCUjingZH9RTPRkRad+QGY4/6PMOi11gNkuarMUgnpq9p36jrC26CSnCAG8rN/AE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

From: Frank Li <Frank.Li@nxp.com>

DMA engine consumers must not call the channel's callback function pointers
directly. Use the standard dmaengine wrapper APIs instead.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/ata/pata_arasan_cf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index e05a4847e0371..a652a1b57338c 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -400,7 +400,7 @@ dma_xfer(struct arasan_cf_dev *acdev, dma_addr_t src, dma_addr_t dest, u32 len)
 	unsigned long flags = DMA_PREP_INTERRUPT;
 	int ret = 0;
 
-	tx = chan->device->device_prep_dma_memcpy(chan, dest, src, len, flags);
+	tx = dmaengine_prep_dma_memcpy(chan, dest, src, len, flags);
 	if (!tx) {
 		dev_err(acdev->host->dev, "device_prep_dma_memcpy failed\n");
 		return -EAGAIN;
@@ -408,7 +408,7 @@ dma_xfer(struct arasan_cf_dev *acdev, dma_addr_t src, dma_addr_t dest, u32 len)
 
 	tx->callback = dma_callback;
 	tx->callback_param = acdev;
-	cookie = tx->tx_submit(tx);
+	cookie = dmaengine_submit(tx);
 
 	ret = dma_submit_error(cookie);
 	if (ret) {
@@ -416,7 +416,7 @@ dma_xfer(struct arasan_cf_dev *acdev, dma_addr_t src, dma_addr_t dest, u32 len)
 		return ret;
 	}
 
-	chan->device->device_issue_pending(chan);
+	dma_async_issue_pending(chan);
 
 	/* Wait for DMA to complete */
 	if (!wait_for_completion_timeout(&acdev->dma_completion, TIMEOUT)) {
-- 
2.43.0

