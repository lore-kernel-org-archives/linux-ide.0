Return-Path: <SRS0=HNFi=DO=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5C9C41604
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2844D216C4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="F+bWtBW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgJGPqR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:46:17 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com ([40.107.8.90]:50658
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728759AbgJGPqR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Oct 2020 11:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl1EhKxcRVRYlI3VXf/fFbxLXrWG0UutQkQPcJaNlObCnbSgQnESzEkZipVl4Nd76zpJuVPWgrIYrrZe/kHpDZAo3Ax6E5AoyW/LgggABqWMnV5Ms5sSbPZ1G0zt5xqeNPrnmxv7BANP3QJAomSk1iO1+05cyMBaUwOkW+3hEIS9XGPlUVqr/5RduNGswabAqVDOhP6GIlDrbeUUNZYl36HilsHAApYTGA8c9aCFOOByw+lMvyRzqzrvT+4Evlde3Qhuuv48uELK7JKE6KfOhIzCWj2dQUKHMoM62Yw8a+qtwySfe7/jut6BsH+iJIiOyXKTPr5zlMLI0sFekBXksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JUyw11InmqgqknormzmcFzgA3E43go6O/wijs8CNdY=;
 b=MDJO4dCUGqleWi/Q6ymDe/o2TYCjWlx85WrGyC+hlTD6fsPeP365F/Id2KmrtWaSx0SC0lsntTSLHPM5F/InOwaNvL3wj0uGf5syiCFy3zlc+nZP9x/1gakD3lPsXpePo5dYb2PdAhYvEnNaRAP5oHw8EV/8FBEewseDT0feFNcBC9qkwHLqNMffbhV6j99nx8LlHqDZirC3Sdjtd3l7KjGsa5BNYDRYgGZOl6N6MqsWY4UFO4xn/hWK6byr8auif3Sxqok2UeKfyQzRKlDbVPJHd3Qmi8XUwfe3Z02z+64AXBeTG5JQ3LOFni3cYUQJRysTCne3vhqVdYAjs1ri/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JUyw11InmqgqknormzmcFzgA3E43go6O/wijs8CNdY=;
 b=F+bWtBW2AeVb/4BT5MK9O4TXuR0BHuMyC81LwtlLZNOM0qB3ju39X/JXFMa2JmHjV/qi/oVV2Z8ox1hKvOvXfB/y8qKfOvfDTdZUSuCFMKchB/E+Y9e8Idz9GvpgGSuRZLeCX26tJoqFigp457krx3+ghfi3+le0U/6maf0RLVs=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR0502MB4018.eurprd05.prod.outlook.com (2603:10a6:208:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 15:46:03 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 15:46:03 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 6/7] dt-bindings: ata: Update ahci_mvebu bindings
Date:   Wed,  7 Oct 2020 17:45:53 +0200
Message-Id: <20201007154554.66650-7-sven.auhagen@voleatech.de>
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
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 15:46:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e053e57-84f3-4f37-d06f-08d86ad818c8
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4018:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB40183CA45E7F45ACF9971421EF0A0@AM0PR0502MB4018.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIlhzq8MbAPF2C5tmcQj1MHCE9m6Kr9xKeqPUbXCe5eT5a7ksFroRK29tuyPmvjEY3I4t97bKNLL8A3RhWlCii35U+D6TgdCMKhXK1Xy1X15+vRkGQlI/705khHa4cCzVLBQatxVi2up98q+kBLXPtXneQ7WUVKRDIOJW1ttdg/ABIbhUJY7u3GpDxp/8Pts7SIUmGUE5NirS33qcxziwN/hqUT/HNUgdIcWZNPVXYx6558uB5TODiVvefQ+RVVsGRLhjtTtzvLgYwytHO5UUVGbcpRreu+qBXEEDh7cprfnBEyDXUrdzHAwhQP5TlBl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(346002)(366004)(8936002)(956004)(5660300002)(66556008)(4744005)(83380400001)(478600001)(66946007)(316002)(16526019)(2906002)(6666004)(66476007)(1076003)(4326008)(2616005)(26005)(86362001)(6486002)(36756003)(7416002)(6512007)(9686003)(8676002)(15650500001)(6506007)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: E2lhBawG/1nT88GF5X5apebyPTUyI4b3tSDSEQMSO7LELIFf2+jbZ+qY1cUYYWwga/DRzISZlx/bu1gjIWGV4onDTiM6+LJ4EePBtomr6uwte1TOHw4a8SCi4BnNNuWly6eGiTXJr9Nwh2p+vROyta1X6jZhtlddN8/4qGAcdRD1uN/8cbLMY1+4z1AQ93sgpLf3+EBVinChq5khdDExzB/Cz7AFwSzcLo3PKZmsweSKedf4SGbfNxxys/w/f2SNZLxpIPE754fWY9JSzI2l+TvX4IqCH3dCdjpkaH/WgE+HZCnQhTLdZH7dTAdCmq0qeTX2/mdXIN7hB8L1cU70jOzn0hidpv4fobqojY7TnSwZ4+csUDxcGTKPAlms3IlTei3D7bktmsD+9oL71KcbCWtiBr2nummDeZdgX6zqEc023SJDchfzAd6UjC+4cAmR+YTX9Pz1ybrSJydpXmPinY2TfklNXpTb0EFcj+05HEDE9KuFusV9fkkKmYTEMv9yXrhcUtQwLPAML4UjFx29qBu35QO7kqNP42lrsFR+CSqYraLpp4SycZulDPYm3pwsYy69PfnDAYalyIqiYXcy2Vs3+xEDnKK5ZvmtMo8W1tktLc6E9btlki9Hdcrwvnad3+GuV837gZ2nyanmQT2FkA==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e053e57-84f3-4f37-d06f-08d86ad818c8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 15:46:03.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OW+2pELxshCzDfPfkN1JPsMZ2VExxu38CLk/xH940gzhKunwrFETi2lxmLrEjbNgPzmPEXFRcdlpmAZh9wKvtMDOfjF1SS56tSvZ4dyJr/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4018
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Update bindings with the already in use Armada 8k compatible.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 83d715cbcecd..78d9d413a5c6 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -15,6 +15,7 @@ Required properties:
   - "ibm,476gtr-ahci"
   - "marvell,armada-380-ahci"
   - "marvell,armada-3700-ahci"
+  - "marvell,armada-8k-ahci"
   - "snps,dwc-ahci"
   - "snps,spear-ahci"
   - "generic-ahci"
-- 
2.20.1

