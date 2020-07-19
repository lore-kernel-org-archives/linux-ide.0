Return-Path: <SRS0=UQRY=A6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3D7C433E1
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A880207DF
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="PbQkKV9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgGSG7v (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:59:51 -0400
Received: from mail-am6eur05on2111.outbound.protection.outlook.com ([40.107.22.111]:50369
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgGSG7v (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 19 Jul 2020 02:59:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC3aOkEmSOzZQVmpLvbF8V3uiOhpwAh+rwpQmZFn5SWZux0eeJIuQk+//0fZAp7puwBT0V0EziIfuolAuwPXp8VBFvTp0D57V8BQZAURdD/Eo+ZcLKIXRqsgBFeyLg/LOmfkDsu5U9rigD6ecQ70VVTw2HytbTWNDkt1ud0d+47305bFXnatANIF1CboEpWYYOZEawjUJtTZzhiZ3cOT0En55nPBENxJR4bhBk5vyWDEadzJknk7MsCkm+81MJxwxTpq839HMyCg4Z7F1l70Kzz68NgSBFN9JNuDAVzRJBVXdxm3OoS4gmvZ91+aZ9Ivx4kRRB5oB2omWZzV6wLUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+Ef1jiS7bnBOwc82JCPKqVF7C6Uh8tT0+WtVU/0TS4=;
 b=DYIyGWlpoCS3lgEJsqFVvKC9gYAvhvO2+G85x/aBPbW3pyo8LBR4B+/cdYW3ry2APymVa8virYkJsorx1cDIUCT5UOuY92fT8fOoz/zk6CRzheqKubtZ/XTcbue1pSWIsK7pXf/beaL7JNOjqSNmH1QMt+myvE/QIPQpq7+5vZj8TR3OdRtmuZbVrFatI1IgUOM7Pyaz5ntL0Qou2XWPgJACSPc1Qm0kkIuO9/aQx/snabM8COK67pYNfgJBx6puZbBLZuSIjyPTWJx9ndq6Hf4OOLywqPB3kiU8eXV6/Hm/WC4Ax0rbc7cgnmwpjlmcdmSV+c+5uFkJ0o2xBYIpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+Ef1jiS7bnBOwc82JCPKqVF7C6Uh8tT0+WtVU/0TS4=;
 b=PbQkKV9d4vN47TPUGuaFxAfAE38GzkByRwb6vLqIsnmUvtCAmQiLf8XCSOR/LxxkD8Ld4n1VQXHBJHkuXZlR0HIqutRT+8gl0S1ykkV8vL2jnKIegVUgX6h3Q7Lci6YcNTS3ad5eeT9WXJIpyPrromsqN4Z2ADar9ypJTFDWf9Y=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=voleatech.de;
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11) by AM0PR05MB6690.eurprd05.prod.outlook.com
 (2603:10a6:20b:146::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Sun, 19 Jul
 2020 06:59:46 +0000
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39]) by AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39%11]) with mapi id 15.20.3195.025; Sun, 19 Jul
 2020 06:59:46 +0000
From:   sven.auhagen@voleatech.de
To:     linux-arm-kernel@lists.infradead.org
Cc:     miquel.raynal@bootlin.com, baruch@tkos.co.il,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        nadavh@marvell.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, axboe@kernel.dk, hdegoede@redhat.com,
        tglx@linutronix.de, marc.zyngier@arm.com, linux-ide@vger.kernel.org
Subject: [PATCH v5 2/7] ata: ahci: mvebu: Support A8k compatible
Date:   Sun, 19 Jul 2020 08:59:37 +0200
Message-Id: <20200719065942.24693-3-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200719065942.24693-1-sven.auhagen@voleatech.de>
References: <20200719065942.24693-1-sven.auhagen@voleatech.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::40) To AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SvensMacBookAir.sven.lan (109.193.235.168) by AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Sun, 19 Jul 2020 06:59:45 +0000
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
X-Originating-IP: [109.193.235.168]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e650aaf-0823-4948-9466-08d82bb15249
X-MS-TrafficTypeDiagnostic: AM0PR05MB6690:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6690384CD49B5F38B91B961EEF7A0@AM0PR05MB6690.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnxDqcPxuxe6CFsxFfUNLcIGQhzMwYsPnSECckGpnQN3zTzz3lVlEmEChdAY6owMYc6uajUwkCLqxEjxTNt1Sazkr8Hw6ZF6/sxq3lGHUaph4EfWwGQRQ4mTTaEWrlaSQpkzGEMccSF6qSfago0JBVqu+7pP9g9+Re6rhSgdXCq5o2ezkERD2MF4JuyJJxyoTpcmb9X9CUYL4YgTiVopaHe34dt4qADhAOWYB4KTe+yZvXhQyl8AZYf8wdYaWe/ntGhOZmXMoK34uNMuc4cAfY9ostLpYqeAiwTjagfU4hEajZNLZoaiBgaIGFFH9DDKkaoD+SSMeYfTDCzcD31IdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0501MB2785.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39830400003)(396003)(376002)(346002)(136003)(2616005)(4326008)(6916009)(7416002)(86362001)(508600001)(1076003)(956004)(316002)(16526019)(6486002)(6512007)(9686003)(186003)(66556008)(66476007)(6506007)(6666004)(52116002)(8676002)(2906002)(26005)(36756003)(66946007)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +CXDN8UyCtUfDPDkKttO8uqTGidpcYIvGRRf1HQjZvf5Qw+80sQdPtTgwAuJiXBnhaxkW+6SxRObF5bMN94r7ivn3qORhgNd6KZ1dj6V486D60Y4TlBxDeCdXi/Ti+lX2BJx2GVNGCdKCjdrHwnIrYvcZOQyCHVL5nz2l4S8VJCim7eog0YCG4Af0rXb2tiDG3GRBwQvzmBL7iwi+fUodptXbOg12+g9duLh/Vq+db0n8uG2+cUkTlktduz82VVUf2ZbCvuEPB/vaif85adrcSSYZ6FNLecpP/xnJZ4K/q4bY29aPA9gp2AkpO/qxqFgeroXzDH2HN0VeIV6GXr6aFLtEhjVskOj4j4ewf6gfbfc8ucx27+vapdKTLiaFSza3JTLjDy3xM/Bd1BjnsKsxLRMxMEMZAhCT8k32lt6W4tp9uHfoCBwGVRxgYy/YZyQ+j04LT0zpeJt6Kgg3xSOVDice2+fv5SqnOcGuMhbOrkbWZjr2M5uESdqpW5aV8F0
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e650aaf-0823-4948-9466-08d82bb15249
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0501MB2785.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 06:59:46.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gKn86Le5ku3lhzJ8Nt0XCAmI3oB3RMkP5qfiWTMGkN/sTJCotyB51fHTi/+mqlT84mHu8IoaGmvABm2jFxc5tdmcvmqJ/6gQ5TSDV+ipww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6690
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

The ahci_platform.c driver was historically the one bound to the A8k
AHCI compatible string, but before adding a quirk for this compatible,
it is probably cleaner to put all Marvell EBU code in one place: the
ahci_mvebu.c driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_mvebu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 43bb2db59698..1cdc126882eb 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -96,6 +96,11 @@ static int ahci_mvebu_armada_3700_config(struct ahci_host_priv *hpriv)
 	return 0;
 }
 
+static int ahci_mvebu_armada_8k_config(struct ahci_host_priv *hpriv)
+{
+	return 0;
+}
+
 /**
  * ahci_mvebu_stop_engine
  *
@@ -230,6 +235,10 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
 	.host_flags = AHCI_HFLAG_SUSPEND_PHYS,
 };
 
+static const struct ahci_mvebu_plat_data ahci_mvebu_armada_8k_plat_data = {
+	.plat_config = ahci_mvebu_armada_8k_config,
+};
+
 static const struct of_device_id ahci_mvebu_of_match[] = {
 	{
 		.compatible = "marvell,armada-380-ahci",
@@ -239,6 +248,10 @@ static const struct of_device_id ahci_mvebu_of_match[] = {
 		.compatible = "marvell,armada-3700-ahci",
 		.data = &ahci_mvebu_armada_3700_plat_data,
 	},
+	{
+		.compatible = "marvell,armada-8k-ahci",
+		.data = &ahci_mvebu_armada_8k_plat_data,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
-- 
2.24.3 (Apple Git-128)

