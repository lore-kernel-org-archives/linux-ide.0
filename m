Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9DAC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  3 May 2022 20:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiECUTg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 May 2022 16:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbiECUTE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2022 16:19:04 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 580BE286D0
        for <linux-ide@vger.kernel.org>; Tue,  3 May 2022 13:15:30 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8DDDCBC1;
        Tue,  3 May 2022 23:10:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 8DDDCBC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651608646;
        bh=7CTWWsQq5BGbHxa3gecG+HZy701Eady0L2z+YEQxjgA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=iv+Yneqbnx4VNpFTBiyO6Dc1bay8jUqaUKy847sXXB991/BFofgvxem2f1OoUEgO5
         C0s66k7116m8rhHWsWLMCqJecVBhFNnCxJJQQEQA96mUtJBKnrUYhVnN4jgqNytdmI
         PIXZqmEC/90NsydzPWt3nBXv6bz8bF2Vt54GANFo=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 May 2022 23:10:12 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 13/23] ata: libahci: Extend port-cmd flags set with port capabilities
Date:   Tue, 3 May 2022 23:09:28 +0300
Message-ID: <20220503200938.18027-14-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503200938.18027-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Currently not all of the Port-specific capabilities listed in the
PORT_CMD-enumeration. Let's extend that set with the Cold Presence
Detection and Mechanical Presence Switch attached to the Port flags [1] so
to closeup the set of the platform-specific port-capabilities flags.  Note
these flags are supposed to be set by the platform firmware if there is
one. Alternatively as we are about to do they can be set by means of the
OF properties.

While at it replace PORT_IRQ_DEV_ILCK with PORT_IRQ_DEV_MPS and fix the
comment there. In accordance with [2] that IRQ flag is supposed to
indicate the state of the signal coming from the Mechanical Presence
Switch.

[1] Serial ATA AHCI 1.3.1 Specification, p.27
[2] Serial ATA AHCI 1.3.1 Specification, p.7

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/ata/ahci.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 7d834deefeb9..f501531bd1b3 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -138,7 +138,7 @@ enum {
 	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
 
 	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
-	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
+	PORT_IRQ_DMPS		= (1 << 7), /* mechanical presence status */
 	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
 	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
 	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
@@ -166,6 +166,8 @@ enum {
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
 	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
 	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
+	PORT_CMD_CPD		= (1 << 20), /* Cold Presence Detection */
+	PORT_CMD_MPSP		= (1 << 19), /* Mechanical Presence Switch */
 	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
 	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
@@ -181,6 +183,9 @@ enum {
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
+	PORT_CMD_CAP		= PORT_CMD_HPCP | PORT_CMD_MPSP |
+				  PORT_CMD_CPD | PORT_CMD_ESP | PORT_CMD_FBSCP,
+
 	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
-- 
2.35.1

