Return-Path: <SRS0=HNFi=DO=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B6C41604
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF7421707
	for <linux-ide@archiver.kernel.org>; Wed,  7 Oct 2020 15:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=voleatech.de header.i=@voleatech.de header.b="joX22BX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgJGPqC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:46:02 -0400
Received: from mail-eopbgr80101.outbound.protection.outlook.com ([40.107.8.101]:61507
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728038AbgJGPqC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Oct 2020 11:46:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNlCGsdVdZPPvLcePMrXQkVcbSfH7rEA+v2DbH2BKFq+ikdref8Z3QCwzCb5JN1Pu7MLgKDhwXvYiL6pyMDIkF9fFr/HLtNyqfXg5xIByhvqkC38oDIPsi3YwYWwTuXDUhHuz7a/NMAIfdV3GUQAZvok7sXKIux7a10unCqNrKBDhR1k4rDMUfKuks17MsFjeMPLcK5D0ZAPArGHpG8HLVFowF01TXTDDGrTLOcjixBQTjg/q+I0jPGNE/ypo/TNEtdYf5iZQZKlBL4odZjXbiHsya9IMe03zQnHBsLODtOBDB2Cudft3CpYIR55jNEUQgVWCAv3EFXZSJk5pK5EEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwfdcP/0jT0RpQRvdLRM9h+fw1+Hx9cS8jnjXNBogkw=;
 b=Mqco5pMG0hNhqSFOHQr4lDaZ1rNBLBvQvqoZWJxChtjS7SzFTyo/lgVXRs9XTPGyHBk3zAxqcS0lKDfLjlYSjNRegxzovTbBLl61NF6dtxxRwrllLkoA3IJzWosR8tuM3UCg3Tc/XdQ6+8rl2/EdAH7KODfHQeIgFIoYzyH945O/jnVRahrKfN+3FPKfsXRyybpjhL0cmdxZvYjZbjXhFfFf0OQil1ldmi6yKtwWXzhtZVNxPeFoemp04KZybcuNKx9OUUFJsjU49iy9UblL1Z/fktOmaQrQc2xkHy7HpjQCkBNTEU5HiNWnEHXotjqxt/0DS0ERpLi8ePwTmOQdCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voleatech.de; dmarc=pass action=none header.from=voleatech.de;
 dkim=pass header.d=voleatech.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voleatech.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwfdcP/0jT0RpQRvdLRM9h+fw1+Hx9cS8jnjXNBogkw=;
 b=joX22BX8NSYbI8NIY4PV9zZmYZ+HNa1f5KdCRN3r94dlRjOtiMg02URWyND0w9qRKPWD9C1Jnz+VwE1x+CTZpc+XQh3cwEJAhAFRCHPZePCnV4gEOXHfWfhbuBaWGveg8+8vm0bwXNOTjXJ0ezIU8S67ujw0VsvMGxoPrmuYSCk=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=voleatech.de;
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com (2603:10a6:20b:1d4::23)
 by AM0PR0502MB4018.eurprd05.prod.outlook.com (2603:10a6:208:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 15:45:57 +0000
Received: from AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4]) by AM8PR05MB7251.eurprd05.prod.outlook.com
 ([fe80::f132:2cc:34f2:5e4%7]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 15:45:57 +0000
From:   sven.auhagen@voleatech.de
To:     axboe@kernel.dk, hdegoede@redhat.com, robh+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, gregory.clement@bootlin.com
Cc:     linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: [PATCH 0/7] Armada8k enable per-port SATA interrupts and drop a hack in the IRQ subsystem
Date:   Wed,  7 Oct 2020 17:45:47 +0200
Message-Id: <20201007154554.66650-1-sven.auhagen@voleatech.de>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.193.235.168]
X-ClientProxiedBy: AM0PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:208:1::24) To AM8PR05MB7251.eurprd05.prod.outlook.com
 (2603:10a6:20b:1d4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from svensmacbookair.sven.lan (109.193.235.168) by AM0PR04CA0047.eurprd04.prod.outlook.com (2603:10a6:208:1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 15:45:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c43fa48-84a4-44b5-57e8-08d86ad814da
X-MS-TrafficTypeDiagnostic: AM0PR0502MB4018:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB40180CEBBA70F8EC4D66AA75EF0A0@AM0PR0502MB4018.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0HOwznS1ZFy4qZUnztqCZlpfnAHq5Oy3ZYHedE1USiezDEk0Mf2O0Wo4BPZB8YNSW7KoAj2bSSozm/xleoyxpKEubiPnNH2R9PSrCsGvb+Aj3WvUmvUr1coLrcP46LjQqV6a2PpKw1tkCL4q49C0ynOq9wXKGahlW0TfV9NVx9cHCTrO/MoSqxVb/G899IOD82W+C002MMuOrpA4RAd5UKULlj3jpnU9tt0Khm8XEA4wjUm8og1wY+EnwXP4r9FwlM5p8Cq9WbedqYMM7gWC/f9j0VtUFWXAM4KGp8YippN4TgLrvfd55gowPzAEjUEFahqEhLyJg29O/UMwvEmu3JXpKiORoJtKrwiCrmV947C8ldL6BrukyA4Y4mzFE/D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB7251.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(136003)(376002)(346002)(366004)(8936002)(956004)(5660300002)(66556008)(83380400001)(478600001)(66946007)(316002)(16526019)(2906002)(6666004)(66476007)(1076003)(4326008)(2616005)(26005)(86362001)(6486002)(36756003)(7416002)(66574015)(6512007)(9686003)(8676002)(6506007)(186003)(52116002)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: KZdSsYvQ3Dz/bPCGCSHCerQ4fDIZes6gP08/q7gRhliBTd2NmyxdazW2rFFQroBM43z94+k4ez6RyQmGadK1jKA/TDjTdfjhxhfoZR5G3HrEUwrWwkLJBqjIzSZ/zPyGf8KZyDObsv00GgKWxCTH9I2bMEGyxBa+rwjDL+yPbssa/G5UK2hCGfORkcfNTF4BQX+LyxxoG3TNbsWutq6qXXuINb566SGaaBjwWI+exz5LwYa80c46kag/5U6r4FqlECDtIIRstywUcpp7uqufGfEboVhweUppQiLEmG/t7w8+M1o97zzudw0BwpFAo8Shg3mxGbTmdtUO8BQy95Q37tUx5K/Z/YIqlBDIUL/u6LnrWa4/fjVjQug++ZnLC+ECTuewuVDgLKINuaq3L3aaTLQ0sfq0rzPDsPZ99eEXAYqyy0zZWgyIsCMTdzGS1daNDSQe5DB+LFph/IuF1WW1oYR2wjSkQz6Oc767dM2lw3D95LoPwuh44kdHZRYRTYW0t7olUxiPoZ4U26lqOt4fUP294Ajqc0XGSbXT3ahWisjI2sechCnd/7Si9f2Q0c5///1Wb2UhkIbK0P1nrPvxHg4P1LKhnyFzbR3OnqtD7T/Ed/SiF+16OkmcOyBYW1BddYx69+Dz7/E9M0VwNGA8PA==
X-OriginatorOrg: voleatech.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c43fa48-84a4-44b5-57e8-08d86ad814da
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB7251.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 15:45:57.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b82a99f6-7981-4a72-9534-4d35298f847b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtccK/TR3h34pgULO45sIuOACA4E/J3m06Q7pYbwTjf3R+8tr2fRwjz4SnVrj53Gt5tjsqswv2/IqpPnZIG15SgjcuLiLA5YMyBFNrn72WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB4018
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

Hello,

I am resubmitting this patch series since I did not get a feedback
the past 8 weeks.

There were already 4 versions of this series from Miquèl.
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
2.20.1

