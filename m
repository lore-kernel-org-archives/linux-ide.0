Return-Path: <SRS0=UQRY=A6=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B85C433DF
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE692073A
	for <linux-ide@archiver.kernel.org>; Sun, 19 Jul 2020 06:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="NTpEgyiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgGSG7y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 19 Jul 2020 02:59:54 -0400
Received: from mail-am6eur05on2111.outbound.protection.outlook.com ([40.107.22.111]:50369
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgGSG7y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sun, 19 Jul 2020 02:59:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKZ9gxH5ekKNxC4C5/Z9HFn3ib30IjfsuUHA+kple5xuVkhk/QY5IBHFDhl0Ek230IG+4Jh2Ly3FkU9ZhkeS2IrBYe+wZbrxeKu2kLpelIvudKGx+1Qkpjel98DSg/bTen8Qdx8s45MnBpFhdhtOFVEHedvv/D9JKRfI6+lfRecRVnHlOCsohtSPrBZES3WAhc+a3kpTaummuHnFmppu0Hi9/57/NDNcSaP0eVqrKkmzkmAAotMn3rlqvwYFfzMA9ry/AZAa7yD1NUQ/WWZ/S+KYVGDA1/ZTSz5ZANbaDIh03YgDMdUuioXstUE7XXaHQPhdtr7/bPSFSGH2OVLTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDC2bRUORaPVhaon8cHIeQOHaHLqj3tuUgiiQ3+iI30=;
 b=ES5HUch/tEjC0LC58MtS5dbuZo3zfe3crF2TzavMnZWJdc7zuhxJllKc8FMaQmqEp6xhDhuWMRhRH/0ILoy4/kHRnHe5pbgP51eijsb2SmwzZOFm0gtQRLJ7BoRZa9HN2RZY5zObdapRAIkkkxNeYyccUXXjxKJ+DUYikVpLe5Q47QWJgLn8cRdsQy92bJtaH+i0iykz+uGALLmG3sQxkB/sfs4qI5a0RKCyFU8OsfdcHONGjScGYjYloobe4zLwbP90t5albvJwx8XSIVMRwIfBdH4uIL51sj0CdqJEgki9OKs+tgReWzZ+os3FcqefXuSXCuAY3vUu5x0w8aCnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDC2bRUORaPVhaon8cHIeQOHaHLqj3tuUgiiQ3+iI30=;
 b=NTpEgyiLywolHdJoLuWzgCzyQVLCWRL+DiNPval22kNnst7Yu44CI+wqdp8IfWvmRNfL3niJbzvqm3YpdrrL/vEoiJb5O6QZQ067TyXrkH/DzOGcs1IapfG5fBTzWqm6M23w0mkcR+shdhfGNBWZ1HXo0/rsZlm8vaR/GJcPszE=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=voleatech.de;
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11) by AM0PR05MB6690.eurprd05.prod.outlook.com
 (2603:10a6:20b:146::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Sun, 19 Jul
 2020 06:59:44 +0000
Received: from AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39]) by AM4PR0501MB2785.eurprd05.prod.outlook.com
 ([fe80::39a1:e237:5fef:6f39%11]) with mapi id 15.20.3195.025; Sun, 19 Jul
 2020 06:59:44 +0000
From:   sven.auhagen@voleatech.de
To:     linux-arm-kernel@lists.infradead.org
Cc:     miquel.raynal@bootlin.com, baruch@tkos.co.il,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        nadavh@marvell.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, jason@lakedaemon.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, axboe@kernel.dk, hdegoede@redhat.com,
        tglx@linutronix.de, marc.zyngier@arm.com, linux-ide@vger.kernel.org
Subject: [PATCH v5 0/7] Armada8k enable per-port SATA interrupts and drop a hack in the IRQ subsystem
Date:   Sun, 19 Jul 2020 08:59:35 +0200
Message-Id: <20200719065942.24693-1-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::40) To AM4PR0501MB2785.eurprd05.prod.outlook.com
 (2603:10a6:200:5d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SvensMacBookAir.sven.lan (109.193.235.168) by AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Sun, 19 Jul 2020 06:59:43 +0000
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
X-Originating-IP: [109.193.235.168]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 829e2d92-2c73-4d8e-9a0a-08d82bb1513f
X-MS-TrafficTypeDiagnostic: AM0PR05MB6690:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6690AFA12C509D30B9B8D16BEF7A0@AM0PR05MB6690.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSDCe4Li0+s20Cj4PIRiqDqFnLg8Zh8oCGkcR3QvxoVXVP3HU6haZUcHkRt+ftE6s2GWKi2SBNq0EHW0wM8kYL9hbVGPQrzHkBp0sJqhWtVvL6im8VgQTUkOSZU8zLfuUgT+msMSCwasvw/DTJ0Hpp1wFGr0Yxs5h8lmqkuWvv5jv+OjTWFQ//Jd9OpjyZQ8CN7ODUedX7zUGBmBi+/E+8LCIPeEQLe+MaM7RtPtTipJ6lTRnWLcqS8D8VYsKEHb0YgMrgHQtEB8Jx8/OEkPWhsZ0JCadCxtgKVV2FFAATmY6d32p1H2CEPS0kBaw299jX67U0V7U0HukzMW8Dhm2Iqe9FypZxvnR4Tx3xOSiZ3qWieS060ovHuyYnLc0ZYI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0501MB2785.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39830400003)(396003)(376002)(346002)(136003)(2616005)(4326008)(66574015)(6916009)(7416002)(86362001)(508600001)(1076003)(956004)(316002)(16526019)(6486002)(6512007)(9686003)(186003)(66556008)(66476007)(6506007)(6666004)(52116002)(8676002)(2906002)(26005)(36756003)(66946007)(83380400001)(5660300002)(8936002)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: uE/gcCtDJBQJpHi3YMeS5tQUwM5OPn25PL10wFY+w79QOf7Q84C5uCS9Gl5nqUQtxL7l+ro2HzhVCptxsc3Cs7eZJDafD4EbLnAb76uPqy2W/aOLC2Za4qpLeu9nCW//0v4eMawuYanhKHUXIa8A8py1yqFvYLJMiVfClGf07yOnVAx9kJH8bR2C1Kv0nzy7zjO6Q+jML0JoEWYt3AdrQScf9OXdo4Il1loC+K5+tnfLTuwwoTtK1JUgOMnyKSD+B+GrronYZQlY8noRSihvm0GPM+t9zSlvrzM3J0uYBr6dNpdGyA7R/bKlNgcGaklkroZ8MAYIw5truIIx7NTFhjXWHJaxT0JNJXjsKCDRu2ekYxmRazRezZ/juZ8juUPDVz36xhkEr8ILiVP4IY+T+ssLfNiJopI/h5fhEfNmLnI4CbPFR4ABRnC/ZHSLiNjok8Hf8uBVBgp9P6PfaBjpqjTrXRncfbAViAAx7AUKoFwDzRPHNT+eonh18KwHtTMs
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 829e2d92-2c73-4d8e-9a0a-08d82bb1513f
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0501MB2785.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 06:59:44.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVviVxHv8gpJ6IvdXM6jOr2muKSQr8Z/C3e5CrPv+JJTqNMRvGNofGiFtT9FCHgT98A1Z+N4LaOxqy787LJkBaRjQejec36knymFX8SKjz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6690
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

Hello,

there were already 4 versions of this series from Miquèl.
I talked to Miquèl and I fixed up the last comments from v4.
I am looking for feedback if this patch series is now ready to be merged
and what should be further changed.

Here is the original cover letter:

Some time ago, when the initial support for Armada CP110 was
contributed, the SATA core was not able to handle per-port
interrupts. Despite the hardware reality, the device tree only
represents one main interrupt for the two ports. Having both SATA
ports enabled at the same time has been achieved by a hack in the ICU
driver(1) that faked the use of the two interrupts, no matter which
SATA port was in use.

Now that the SATA core is ready to handle more than one interrupt,
this series adds support for it in the libahci_platform code. The
CP110 device tree must be updated to reflect the two SATA ports
available and their respective interrupts. To do not break DT backward
compatibility, the ahci_platform driver now embeds a special quirk
which checks if the DT is valid (only for A8k compatible) and, if
needed, creates the two missing sub-nodes, and assign them the
relevant "reg" and "interrupts" properties, before removing the main
SATA node "interrupts" one.

(1) The ICU is an irqchip aggregating the CP110 (south-bridge)
interrupts into MSIs for the AP806 (north-bridge).

Best
Sven

Changes in v5
=============
* Rebase on top of v5.8-rc3
* Move code to ahci mvebu and use custom functions

Changes in v4
=============
* Rebase on top of v5.2-rc1
* s/ARM64/arm64/ in the DT change commit title.

Changes in v3
=============
* Removed useless locking when acking the SATA host IRQ_STAT bit.
* As spotted by Hans, do not enable the AHCI_HFLAG_MULTI_MSI flag only
  if more than one port is enabled, DTs might declare only one
  interrupt and have multiple ports. Added Hans' Reviewed-by tag.
* Added Rob's Reviewed-by tags.
* Added explicit references to the 'Device Tree' being the culprit
  for the hacks which are being treated in patch "ata: ahci: mvebu:
  Add support for A8k legacy bindings" as suggested by Marc.
* Modified all DTs to avoid enabling/disabling the SATA ports
  independently, which does not work. Either both ports are enabled, or
  none. Tested on MacchiatoBin that all three availabe ports on the
  board are functional.

Changes in v2
=============
* In the AHCI world, the 'irq' is now an '*irqs' array, I ensured it
  is allocated even when not using *_platform drivers.
* Moved the whole logic from the generic ahci_platform.c driver to the
  Marvell's ahci_mvebu.c driver.
* Dropped the whole DT manipulation quirk.
* Instead used a hack to configure both interrupts when using the
  deprecated bindings, this hack is a8k specific but there is a flag
  that is passed to the core during the ahci_platform_get_resources()
  to indicate that the number of ports must be forced to 2 no matter
  the number of child nodes.
* The A8k based Clearfog-GT actually uses the SATA IP (Baruch's info)
  so do not remove the SATA node from the DT. Instead, change the DTS
  to fit the new bindings (the board only uses the second port at
  offset 1).
* Added bindings documentation about the A8k AHCI compatible (existing
  in DTs, missing in the doc).
* SATA Sub-nodes representing ports already are documented, I just
  added a mention that they can also have an interrupts property which
  is mutually exclusive with the root SATA node.

Miquel Raynal (5):
  ata: ahci: mvebu: Rename a platform data flag
  ata: ahci: mvebu: Support A8k compatible
  irqchip/irq-mvebu-icu: Remove the double SATA ports interrupt hack
  dt-bindings: ata: Update ahci bindings with possible per-port
    interrupts
  dt-bindings: ata: Update ahci_mvebu bindings

Sven Auhagen (2):
  ata: ahci: mvebu: Add support for A8k legacy DT bindings
  arm64: dts: marvell: armada-cp110: Switch to per-port SATA interrupts

 .../devicetree/bindings/ata/ahci-platform.txt |   7 +
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +-
 drivers/ata/ahci.h                            |   3 +
 drivers/ata/ahci_mvebu.c                      | 254 +++++++++++++++++-
 drivers/ata/libahci.c                         |   3 +-
 drivers/ata/libahci_platform.c                |   3 +
 drivers/irqchip/irq-mvebu-icu.c               |  18 --
 include/linux/ahci_platform.h                 |   1 +
 8 files changed, 265 insertions(+), 30 deletions(-)

-- 
2.24.3 (Apple Git-128)

