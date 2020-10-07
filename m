Return-Path: <SRS0=HNFi=DO=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BB6C47095
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F72215A4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="fva/x/uT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgJGPqF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:46:05 -0400
Received: from mail-eopbgr80101.outbound.protection.outlook.com ([40.107.8.101]:61507
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728728AbgJGPqF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Oct 2020 11:46:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URH7zX8Pibcj5x57KZC5W/KRisbzdoMfjj9YFuK9jRCNs+h2AuGWWFoaW2lxrnYAbYu2hZLP/HVUkp6P+iJFiR9VEN6qmo+UGdLJvvX8ufzRAP8rKIZsLmLiGzLfDSNlTItMrVXvkuMjhj4YRUuWaNUWzieZ6Cw9pUBQnpDkSuWHXClcIJwuryNEJVTPFOUlfBWqn38R1nxV/vdBq2dzM5Jteo68OI2BR75xO4KmsFGJ2q29U2vs8c23N+vu/fq2vUCNabtVefqDq996YkZhei9sJ+G6D2Xh63OOXZHQqH+MQF/eNgYG8wo0OphCg492I9bkE2WdERcblwA4c2B+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82bTvlLCQFALA7Jx2meyRx3MnVXs2cX237ufwYzgfJg=;
 b=dIgeKya7Yy2UHbzGPvT9AFmYKxvpWOP7zYUNYO9n3Ez8/kG7xV0NPGgDAYL4C5/yeA0Qh9pjuxeT1nqvCh1et6N40rtkkq4dChxCsPraur+iSj7+EJcgbjGksqUW5XK4FBXZx7UUihHyWWs29Lcjh3VFGk+kc34ui3Oj909PoghZDyt9DfqeXJ3Cm22mfHraP26WXe7wG8xMThZQbpqy7eWT6V0Pb1kDflhd5j1fF8gIboq0etGrB4Jp9y5HAtrHmToF2pZzSFSjuURpnyNciF30lRiQ0Go6koeOrw7m0+kYRALONqC6vqiNOW6rHZTIcv8iYjfEYbmy5Bep7oF4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82bTvlLCQFALA7Jx2meyRx3MnVXs2cX237ufwYzgfJg=;
 b=fva/x/uT0JO66Wc9f+yHrQVUi8PRK6PlfhKW234+2+ZqA3kqh1esst6tJ2cNq2H9Tp8zNIyjIgJPHmvBrfFDtfj+P4UvFPKgr2Ea4OU5nTFMAnN4uPTfk34769vkAHf56GPlnJtAqVQP0wgKHHDKzBNgMfF12MEV8iklnhthaFY=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR0502MB4018.eurprd05.prod.outlook.com (2603:10a6:208:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 15:45:58 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 15:45:58 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 1/7] ata: ahci: mvebu: Rename a platform data flag
Date:   Wed,  7 Oct 2020 17:45:48 +0200
Message-Id: <20201007154554.66650-2-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20201007154554.66650-1-sven.auhagen@voleatech.de>
References: <20201007154554.66650-1-sven.auhagen@voleatech.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM0PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:208:1::24) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 15:45:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 948f65a9-5e9f-41af-fdd3-08d86ad8159f
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4018:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB4018746948FBE721E013671EEF0A0@AM0PR0502MB4018.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLmcRLLibBw4XFSoXnvmsdaOQkCxNIQzV3DY4Zde3AcWvp5f5wn3MFH99mSGEaIolwtZrh32e0Y/zc3qzCnvTUQpY2DGhSe9jxiXSqA6YyFPUZxgjVsqvnJ4OGkzytIqcfXl8AdzB6j1r6rdIrLhEgG+PQurQKiPP6AvqQSVqE2Fg/42rdPdYtvIWqoSM+Ir3rh3EvHB6eU2ZuCfuR1xXbGrepu1AXtgTOpcZTu9tMi6V6YDw/Ioz57nY9V+XteR1beOuv3qnWqyRH3APcHkJsPN8gAtkpro41PzydhVlgroELz0HC0keonyJLAVSzNpcJcT6sINBN7SELNUQPLdow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(136003)(376002)(346002)(366004)(8936002)(956004)(5660300002)(66556008)(83380400001)(478600001)(66946007)(316002)(16526019)(2906002)(6666004)(66476007)(1076003)(4326008)(2616005)(26005)(86362001)(6486002)(36756003)(7416002)(6512007)(9686003)(8676002)(6506007)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xn2e+hwz/QnpAeIQPsqdlvASBQ7MuXmlHcJui7j1BYmXCm1ztBPADz9Rwzf3U9eo64FE/RmDaj+Ba4ug3bTOYipH8lqPbMomVElqV3N2yfkO4BjAvSSBRFeogPULGs7R2uVZS8dFkbNYFIY6/A4jMe16HcwplmfwL6JGT+EDAdmWcmwtmPTT3lY2EyRj5Evig3lUasHBZA6b55mSOaypkr5iLVJ4uESm7ScV/qRo1pqZeRIWZfD/Ac8WvJdL5ib9J7ggbr69UD7Wqu06ozTprNHjocb1o+jYc1BKoVTR34Xv92i4GupAhmuPfHeE7rMLYOh/s/alqTQSSWIDi63lEMcDruUtof8rBqEpY8YY0lS8Jw+YVG01Y65DzJlwCKpOqSCSZuzQZMpA6lB9ZBJH7m3b+lUCUq3I4S+Odqx8sqEi1Ts5woY2YfbIypAPSYSzpFcU3VMIlhBpz3vEIswOynvIoPlXVWtBWWJG9ThnHNR0MGdrM+Zf3uxifbTFfURdb1EKHkiwt3/mOU1FkUNgWWpi1CgXLBcACx3vfkyV6tGwaTLq01jbiDTf6y46GRc5bMwAZ5PWSvfAUgnBiEnNIF/Mu00T1Om0qWI89lcF0IVQZOjxnsV9axXSy0ZE36m22mirrQ6F6CbI4BOKorMTMQ==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 948f65a9-5e9f-41af-fdd3-08d86ad8159f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 15:45:58.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZJg5GZzThJTITqL+MwVRvMiudLNMru6aaA265dC+TZNZ1yb78v0uCp4l4RK69uAC7UjRJWxxvjZlGbid6Ne95/vqWgnPI9KzN06/dosY6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4018
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Before adding more entries in the platform data structure, rename the
flags entry to be more precise and name it host_flags.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index d4bba3ace45d..43bb2db59698 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -30,7 +30,7 @@
 
 struct ahci_mvebu_plat_data {
 	int (*plat_config)(struct ahci_host_priv *hpriv);
-	unsigned int flags;
+	unsigned int host_flags;
 };
 
 static void ahci_mvebu_mbus_config(struct ahci_host_priv *hpriv,
@@ -196,7 +196,7 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-	hpriv->flags |= pdata->flags;
+	hpriv->flags |= pdata->host_flags;
 	hpriv->plat_data = (void *)pdata;
 
 	rc = ahci_platform_enable_resources(hpriv);
@@ -227,7 +227,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_380_plat_data = {
 
 static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
 	.plat_config = ahci_mvebu_armada_3700_config,
-	.flags = AHCI_HFLAG_SUSPEND_PHYS,
+	.host_flags = AHCI_HFLAG_SUSPEND_PHYS,
 };
 
 static const struct of_device_id ahci_mvebu_of_match[] = {
-- 
2.20.1

