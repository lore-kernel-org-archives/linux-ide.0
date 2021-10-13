Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9595C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 13 Oct 2021 03:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57C060F92
	for <linux-ide@archiver.kernel.org>; Wed, 13 Oct 2021 03:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhJMD1U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 23:27:20 -0400
Received: from mail-eopbgr1320100.outbound.protection.outlook.com ([40.107.132.100]:32000
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235482AbhJMD1S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 12 Oct 2021 23:27:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lntnSoOedEaDrbYOF5CV/8/n9V1Ze0nRSTi8+VsaBSTzTB++BYwT9wwK8pWEzBzpyD91Mn8ue/g0p7mOzSVQoptTnPb66svS5lmrlhCxQ3Kw98m9+j/fuuu/+KermfxIOLNjvXEfsu7KJ6T3sghvHBJJRKWGuN3W5lxh/Ws3buSTuLHI2n9MctCd3Mbqw9+N7JfrFfNNjMCLUW0hr88Yj3Cgcej9FDrBqezFU8b+a8r+edRc03szuyvjl4R1tor1M9Qu9xly9EqTApPZ2JohfDSSRDvK07G+nLREBLKtapuXQkp9E0wmRZoXwKfMseNUDG6dv4t/3F9UOb67NHwCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdnkKI5sjgGMYUhURPau85GDYzgdBORp9UjjsAtl63I=;
 b=bXYDQhch4PDc1HFcd2PNdarZRahom/kS8m02g0gUqy+hk17Q/7p0HzVfzV2eMLrDm2ZlC1b2mbELyo4HNZbajazjvEvuGLwOM+RNZh0HqBjBs2+KdxuqO84szf0EK6T9j+3n09Nj1BApyY/8eZRbClIACqwaH9TWVfOH28myDuC6fjnr2P9og8bd0O7ZNxUzqM6NnIguLsPvFSQn1621ala9sONWkkKgVaGsiyWmAAUH/h1sRD3V7RA3K5PjvjNtr8rHv2yYU+UcH7MdzGHmJOYWUfh+RCP+omr8HBVcmR1qfshLRYnXDxIGovgDU0SxMNRLoNHcKWxTJlGRYRYJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdnkKI5sjgGMYUhURPau85GDYzgdBORp9UjjsAtl63I=;
 b=hhgzMBT55NWy45cNKsEZH6OMO/wTcUxE1EuFhKjG/8Mk/VVUv+J3dlxPyuALn/X49fugkskEa+NmHktG13wra0R+b2okGiG8szOBgnziM1qsCRZJVNODRiEKWG9JKZ95z1SOFdOS0SnkTx8A0eH1TZUOazKueAln6VvQinoLK90=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3387.apcprd06.prod.outlook.com (2603:1096:100:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14; Wed, 13 Oct
 2021 03:25:13 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:25:13 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] ata: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:25:04 -0700
Message-Id: <1634095505-3849-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR04CA0059.apcprd04.prod.outlook.com (2603:1096:202:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 03:25:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c497b5b3-aac8-4acc-fb93-08d98df911ca
X-MS-TrafficTypeDiagnostic: SL2PR06MB3387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB338764CFEF0CA43F35CC58A4BDB79@SL2PR06MB3387.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcvnfryH+MFOSRkA3Jgt0EPEfv8znIctlXCRRERpPKeNu/3d0RvVfcvaAq/A7y0xDDWnd5b23T+TuNAthhK64V95X1sFTKDHalPiaQ232FrDMi8V8GkZw2Ntqybk02zOxdgDF/ZYrIkzNTZg454Hnxv8xHJ6fQ9bOPgQVpH7zwJdOOGG3I7e9GB8dZ85g9WB6hSpgrPnR7PGvkIcbF0T1qOrz0okU/cTzhXLWP3oLwy8D2ylfGWKCOJfeg90qVb4J6ktQEpQANjHsrgwV9mw1CXjpLqgZqciDanfLL0BVLys0AHb6J8nuUnlksv7OWzHGAHgP1yGp84EFEW8HJ7Y1YIrgwMQmEacIR+uVFJHGGu0lufCsIBQCDww8CJMvzPS+8hVGXT7ui/eIC3oHzuf5dT7oQuZmvi02i00kUci+8bQro58XnAI/rx/iYf/BzXMIznejWo3S6otp/ZeqYZdt+9smUOCugO+m2coQFuggHYjvJodsyybuUO1j9lQ8hjHiBEAdv8cx8fU+m7kREBRM+AgwLz2JTHDqKY2OgKDEIXZ4oaGk1UptThMhBHfuPRbqU3eF6aaejztzyt6nCyV5wtebzybXpqKXJoFCk/lb2PTcL9MAMQxbiXhRqBX15ftcG38rN/qBWfkOD/TiXB7eiHk8ib7TItOGMIN5yppY/a4Thg/6NxlwxeNuWfsyF5K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(86362001)(26005)(6486002)(316002)(38100700002)(5660300002)(66476007)(6666004)(83380400001)(4326008)(6506007)(38350700002)(66946007)(107886003)(508600001)(66556008)(2616005)(4744005)(8936002)(2906002)(52116002)(8676002)(6512007)(36756003)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dApUzDyOoS/7fY3cf458d6wF2jw7o+G4HUurDjmHRmvZvw0eobhhhbpvBtV3?=
 =?us-ascii?Q?f/tkCM1a6vvTnGBDdb9x0ays2v/S7dEOo2VcIgJnjjc0TLHrPwwVIRSSYj0c?=
 =?us-ascii?Q?vmBHY73NCFFL3CgCWmwkwzeGQqZvET3N2EtDkQlBYxU7wQD8mHP8FPq+wFQQ?=
 =?us-ascii?Q?EM+k8swBjUF+ccgVWpm0lqv/7l8UeIVr0wHM5uGgTk6IlCNJKr3myE/A0MRd?=
 =?us-ascii?Q?/AHRtlLAPdh4BoyXxhaq51nFuLPRgF0nQqQvVYum7LLovCLCB2xtzWNtdfLI?=
 =?us-ascii?Q?Dxp2yn7fwPX2ChOm/ZBCUFTADfvLS9f4Jg8trKG6/Kh2MPioxm8LtNbrBidI?=
 =?us-ascii?Q?jWAgVx78jD3FJFnBwJuQ4s1IbdE24IhUej38Dy0yPbvFT0oTnEzgVhBSnxf7?=
 =?us-ascii?Q?fF/Cj/soWLuMkrNCl9MY3p0tfJVkndyPe4dNJXWc8tgdbi4vgAFTaLGQDOag?=
 =?us-ascii?Q?2k3QZ4EynsmUbwYVtBC+IqA7aEVuAA4HsnMLrarmk1Jva8pqWQDV0BAPYEbb?=
 =?us-ascii?Q?4puZ1A2CGDMXvLl5dhruOWirPsAZnz84toZP6XN1F6dhkQWV8qUrKwATGDXJ?=
 =?us-ascii?Q?HOIcyBBZF+SI3Ieie+1du2FV8lUc53th43HjVT8G3w4LdXbZO6KzaCq0Q/an?=
 =?us-ascii?Q?J2BjcweA41H3w5r7K5SPtS//BZboch6lShAcPRLT3LjHiDggcHiJQzvyPtG+?=
 =?us-ascii?Q?hD6KMRtF1iBCn1pI63OEnHGtJXrvRFvsJBC9CKBOWVK83TJxyRL/GX80BZWI?=
 =?us-ascii?Q?/+U+ZML5U1X8+04Yv2PqYoqmljTv5KlxUfDpQ3gI+pHAr6a1n942hb3REviy?=
 =?us-ascii?Q?w5Qn8q1JQ7xp8p5Xlyf6v9l5KEGto3A3lIApObHgeUZkhEIknidE381qs8M1?=
 =?us-ascii?Q?gAt3p5fCocweTuqpOXHbEXZtUQ8UA8tURW9g8PjuzBbjDcwS9ugr8NQpN2PT?=
 =?us-ascii?Q?p+uIHzyLjUbJkzKjIALwJ0jXZba2tFI1e2Yrrzm1M71W0xbGL18PU0gnBiKv?=
 =?us-ascii?Q?b+7hnEtMnzhYAcu0iyWYiLJk7iL61ExAUZz/mbXV/YRiqOcB2LVahL+76W/C?=
 =?us-ascii?Q?wZZyLuLZkqoZiKrZsMXak1nsiRFsqNXSEH2nxZClMFDzxv7bprJL7PZfDx1n?=
 =?us-ascii?Q?suYYEwQFjU5PMfNPmbffJtg3cQ2V4prVZnN4COQBgjcV6iCZKiNzC2ncwU2r?=
 =?us-ascii?Q?3aogwR6loJHgVFPoOGhT/TvZCSyzb/ToqojS+5RrFZWoS2+3QZni6wz7opP/?=
 =?us-ascii?Q?7wGb5UC4IHQQiVW8+M67XHUSgvq7xOojKTePIePuIjyv6c8etSgDKwEaZmuN?=
 =?us-ascii?Q?B7jEQVYPQMU+z/A4TUvuvVti?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c497b5b3-aac8-4acc-fb93-08d98df911ca
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:25:13.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfIog7ej7W6RhkUCZSOp2GVhSYo+ei830xYkfsNjmPU8XgBIsfiXLh696B1trFKHTZBEFEwNXcMh+MicsLohHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3387
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the following coccicheck warning:
drivers/ata/libata-sata.c:830:8-16: WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/ata/libata-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 8adeab7..3e41cb1 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -827,7 +827,7 @@ static ssize_t ata_scsi_lpm_show(struct device *dev,
 	if (ap->target_lpm_policy >= ARRAY_SIZE(ata_lpm_policy_names))
 		return -EINVAL;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 			ata_lpm_policy_names[ap->target_lpm_policy]);
 }
 DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
-- 
2.7.4

