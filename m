Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012058.outbound.protection.outlook.com [52.101.126.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026C3D666A;
	Fri, 10 Jul 2026 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681382; cv=fail; b=rTbceyQyiW5wuONgR0sKKpkF3gVYY1nETKOJ2k1xZXEeuUG45N0HqFfiM0O0caeNYhmAN1HDRrKTm98wN+CqCUjP4DEryH9KmA+mLoEF2WxOQ+pdmOWqV0G6QcoMps8IneSmFhO9oRgwBVkk1Vyrx/shVSXDANYLQ9sf3aVQQJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681382; c=relaxed/simple;
	bh=Jp+37HDAz0zvMfzYD8iaG0SxvZ6/hbqT3MoPOM+/eOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EMolU9S5XEsx1wak8811/l/CMYvkgmXNBvqE4Q197TXtjoJmrasw+NoJzUlwla9Q54PasAuWH2f1l+/SuuoIKC8w5IQUhfupIc0EKueN6N4vK/KB9E+9P1R4yzWvzhXq9QLTLVzqOdPJ3MfoNXoW1gcbo8SWbE0oFy04zT3syxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=D9ZEIDMP; arc=fail smtp.client-ip=52.101.126.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="D9ZEIDMP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djYIYeit2KlfEI+TLi/AJ6Akb9OfWllS7XHnUYGpWU+PakgyAH22nI/Gap7PKObagO3iCiXDVVAncjSf2jdujRrM3Q3dzi9JKAhCokrozrW1OF2IXHXu/hivsgGdHXTA6PVSsmsynv0+I89VFsnMlJWNXfV/7lpDWIxOOtwtHKe1MQRXN4HQRVC3qfQ7du4BRzRthuZf9IRMZpXYXZkwTlZwa+yqSzraqIvVQZC7LbUdD1pxYH7i4obHvnpSot4FeIYe1vDh7ENpZ/U6KT41xAKJ6ctgZcFhmiaB734Q4G++pJPDvVIoGuAyAGvhEDO9S+xNOM6dp7L/nSqmelyHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90ouZ0uBaxonnJ81fLwihVxvKM5wFhk6fNqo8mqmwnw=;
 b=xIlGL9hUQA2v7mlAJzBZSVMDI3bAYYl/R8KdXK3QHxUGQUFB9mNSVVwsiukMArnjivCOWWLMi3BQLH7Ccg5MrD32ZxqS6Dr9DBO2/Yk8CyPkSHofnCKgI7q+GUcULGQLB4fIKA1wc5BuucQJksLaN/RQ37WYQ9BQD1DWS6KsvxqSDIG4VLAcjXKwWvgTYfjm9N71evSoUskKof/y57rN7N1ErCyaoIA4asYsLWeCh5ZkaN5Fy8q8r/hYwW6raQFDePfjN2pWYhlrPfJ//dl0Nd3CvG5sM9zqG8hkxXc0zH9PpRYhmCrvgy1hs0F7hGok+Wl54+WZtcHZRHtbxa3WDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ouZ0uBaxonnJ81fLwihVxvKM5wFhk6fNqo8mqmwnw=;
 b=D9ZEIDMPNbdFyWFVN+oEDjfc80Ju4yV0QszznLN8W7H/j/gdNQ26SRKo+pxSrdymE/mlp6APH8rjOw2Rwjs9pvk1MdV1NV38e/c74KhunBuJ/vN/RzdnF/2ucW4YfcUDFlO86iL0CrB93mlwz/uORx4WS5H004owiVcvUQhhJ6aB1XruAdMmg8Z9/ZdYUL4KfIHQUKTvIpb/ql3lS/BxaYsS4BKY11ubI3EFNOyBdUgiXglAJ7o4AF6KmtDZLG5yVlOCkEX+J+jvrTu8YtM275499N7P/7Zi9miq9uxgN+tONu0u1WPalxlU+q64Vx0Oz0WUtug65Ki5+t9t57Kp8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KU4PR06MB8388.apcprd06.prod.outlook.com (2603:1096:d10:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 11:02:58 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 11:02:57 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH] ata: Remove redundant dev_err()
Date: Fri, 10 Jul 2026 19:02:46 +0800
Message-Id: <20260710110247.426444-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::16) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KU4PR06MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: b3343c2b-5fb2-4fc0-ada5-08dede72ccaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|52116014|1800799024|366016|38350700014|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mqAPX1GVr92JXzSm3EqW4v5euloFABVPSC18Sbu34NuBVvDkCv1t02HXTMTfP1gRrszUlbyWoVuKQ3U0md/2WFN9BY7VgVBDpJQMIQfY0tvJmclRoL5kbkDDm+FFhQiKfu2tbe8f8UpFWSCNBknubgkc1Ci/G+9pZ+jJ+42gMSibQ6k26lA3Chi9tmrXvx/nuk+q4AgIml9G9FN3u8/Ioq1s3QXDVllRZzqdlH2ZbXbyJAArmampcqE/8v1Utjd1X1jC5URzfSvGgQarjm6f49eZi+oGkPGR8N7x+JvCl7bs2T/FtvO8Ywlw+O8dtgAGm+Uz4Oo3A2A4fvREjoS9+RRfbqRq0miJhPTEh6GhRs56YDzdIJx33uRtgRaCuDPnAyxF7Tn2KwGcJvoNVhMCrHE09xGSV/5yVjQD0JlMZ+1O1D6Ieg+h9zpjD/PCiRLKUzWNqvytigKJ4t5ft+yE81Iznuyd/q4d26f3oHsQC28b9ySkWnjGe9g5pW87XdtpuwN8zfDmUNjmNNwGh3dGC02IO2ZeJ1fs0MvfiunR8uUWmuFKyDfki0dWAJLY3bx+iqB+cPldERntxKa2Z2cZND2GyaXgevawh1/ESS3bJVm8Y3aYhU4m6kKgcm4vGpbML+ArCdh0hfnpY/5+nZU9Z5s1zt0Roi6anTwy31MTHgoeaX6X8R3Nfvaai3us1otwrUFlx9Z7Z5hZjMAJ/jXuHly5FU8SADxICjDiIW8emCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(52116014)(1800799024)(366016)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bsaftIPGqHc+LeGWBWGSDQnqxSSK1ponyj0a4oMTrd4642xEUWCs4I2RpJQd?=
 =?us-ascii?Q?5WrElLS//6Bn/mXAJctKEe3AILQZnSG81AydRb/B/J2WTJKdgLMENEP10Tf9?=
 =?us-ascii?Q?j3GLSUHNs40y5b42A/EETlUU2bpUbqc6ghRIzTnI698YRrUFLVFJ4xgADpMu?=
 =?us-ascii?Q?2eKNXXgDqzkveXpEHSgrl8lwH9aeQUaFoZjDHHntxAkmQ0v+h++oS2WWMB0T?=
 =?us-ascii?Q?bwRAPP9VBbXF/WuOORZdqcmtAWS3G8zS5cD5cKhj0RYVBwOip9j2ktG9A/Cl?=
 =?us-ascii?Q?aN63eug5jCZ8rXWXTXJwwVY+m22X94rj+fRbn98Da1T0l3do2XqgWYfDfaA7?=
 =?us-ascii?Q?O1TMVhmHpk5C/QeEsS0pyohW5xub0a9p6P1KPfW1ky4tZHk7AzMQUZyCf934?=
 =?us-ascii?Q?flzzbGgPKy0wx4y+SAviahbPwoyeD4kOu3N/DFUXH6a1Eh5bq3B9UDDAA1+9?=
 =?us-ascii?Q?RIW3WUKWK6Btk4i7O93HYefSMDwJxnzJsDS0s1ncgeDJcmen3Eo4vwP69UIP?=
 =?us-ascii?Q?LMYTg+k1s1EGUFujYzE6/9g/iB1Tv8dKP+akeTYsW/CIHreTI5gv+RucSm0S?=
 =?us-ascii?Q?u4MI6MAZSKDf9pnM3H9hnh28wEe+Hxp4rvzfU8uByfnE6VT5XPw11Y5BpR4H?=
 =?us-ascii?Q?YsspkZ2+OULbPYKfWaIvsmBvz3CQpG0mpjwsIlVq+t5Is7YiMb07TmcT+NJk?=
 =?us-ascii?Q?sAvlwgYhCYrnIQKnog/vNVOwHG5fMgR7Jx8uFCMOgAYSUakQEYSULvyeWItK?=
 =?us-ascii?Q?S/TCi5UO5NqWMqiXKz1Dc0tg1l2i+cnHv+Z5Jbht8lazhE7gTuD24SGCPWnp?=
 =?us-ascii?Q?D0bQl1/6sCyNxkLr8fWKa/4CkOqYwOlfTYprG+wQdzWm+9IJcz02LcHfHLYZ?=
 =?us-ascii?Q?eU+CWUx++zfO6YwIwKmjSGgnfYj1dqnQ5RyLjbvPkQ7cNexgO7pjREu2oRDm?=
 =?us-ascii?Q?re5ujjTUPfJaArXWgLhD8c6tmsBCHpY1nzUIq9g3BFXu+xNh9GNCFntqeEnT?=
 =?us-ascii?Q?wSmeHZ847t/49KQCPco7uc+qPJxL/RPoQBk5pbdo4h7uCF/VSsuJDOQ3kuBC?=
 =?us-ascii?Q?3l68ynpBtGfyFK6AhqjaHBeBkGniypyhCNibfdeuZ30/TqnuoWF+LawiREtV?=
 =?us-ascii?Q?tL7y+blm9nGV8jrG8LibPXamE+dIJI5pFfdXhd5Xf/UogrfLOYWMEc3tmZ7j?=
 =?us-ascii?Q?pAPnESBL9X9bczCiAusD5FM7YwopYbHrVlLxduZWJihRfSHl1R+WTicIbP9V?=
 =?us-ascii?Q?IJZzs60fjaglaZ9NiSU6YWl0uqxkirSIH7Kk9NzT50G2M4e6GCYOUzVSZrJH?=
 =?us-ascii?Q?7rg4x79cZ8JRJdGFdnlTBOIQz2xz1dCfq52vpddxjsy2nz7/E+P2sAJDbSgT?=
 =?us-ascii?Q?E6fBe0d8adzlo2nYrQTT9fMGTOjOv9X040dM0lefzcn5IxunE2CbxEBfNYjN?=
 =?us-ascii?Q?A2lVVhX6krskLBG76vJsjVqn5zPVJf5Bu2o3EvtixzPYiwKcjsnDgVD2YqIL?=
 =?us-ascii?Q?CLtyp9znfSfsXDBsF3vg6BgTBZRo5YPRqATqXFtLrl+jC2XkoYepVMYA3Ovg?=
 =?us-ascii?Q?xqw0r4l3+cMwSjPoUTGpc6Sj4+hGt8vMFJx/pCeZGBQVM5CkgMuYTDUFJnbd?=
 =?us-ascii?Q?HIfcAo5vpJjhFgDxCCHiIMF2ihXg3pauJTb1vyWeXaZNinBduM9s27vWK4OQ?=
 =?us-ascii?Q?dVylH5gATuUfJEDROT3iIjNvc0yG41YSZpJ/0gXm72MTy2ynZzCvpPaXt6zR?=
 =?us-ascii?Q?64Rjsh9rbw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3343c2b-5fb2-4fc0-ada5-08dede72ccaf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 11:02:57.6966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqD1Bu39biTlvpQVuwos/IhhlVZQ8V+wq9c7ZiMc1bTMnrEPDYzK3ge9AcnwxaJzuvLGJ4AzKA71YWmwM+QM1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8388

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/ata/pata_mpc52xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 210a63283f62..1739743427cf 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -769,10 +769,8 @@ static int mpc52xx_ata_probe(struct platform_device *op)
 	task_irq = bcom_get_task_irq(dmatsk);
 	rv = devm_request_irq(&op->dev, task_irq, &mpc52xx_ata_task_irq, 0,
 				"ATA task", priv);
-	if (rv) {
-		dev_err(&op->dev, "error requesting DMA IRQ\n");
+	if (rv)
 		goto err2;
-	}
 	priv->dmatsk = dmatsk;
 
 	/* Init the hw */
-- 
2.34.1

