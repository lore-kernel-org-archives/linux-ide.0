Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30157C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbiAEFRm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:42 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:23804 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236210AbiAEFRl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:41 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmj3DKvz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359861; x=1643951862; bh=CgY3RkzyWg1tkW9rDS
        Qh9KBLMsuIxnB0eA2ytikTiQo=; b=eqZ/CotrMj+wtxuBGpsK7DFoWq607vscDw
        qY5eGqoI1sKH6WXQRsgpPQtTwi0Y2rNnGWX30KycFUiXytbF63mhTaG/2mI/rjhW
        xTZ9L6+epQoUd7HLR505NYMQ/RiY9uvODfzpyIV75NsXxvTRDEKE658dNpfrucg3
        mfVqmrHPDYbToyrzk43RE1ns48fgiLK2TLYJe2uRUCsT4+RmxwK7/KZVTg5R9Hb7
        04rtgTIGUzjuX5mDnOfzo1HfBt5HZqmhg9aBPGRw8Hb2X+sHvOHPcwHw2j3mmmiv
        TnmvhK7KEbR7/FrdPrVLDB1Bu9M8aBo2Rjk4MjycpCtmdr+JZQUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kP3kNSRl5HOD for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:41 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmh4w5vz1VSkV;
        Tue,  4 Jan 2022 21:17:40 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 02/22] ata: ahci_brcm: add compile test support
Date:   Wed,  5 Jan 2022 14:17:15 +0900
Message-Id: <20220105051735.1871177-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_BRCMSTB, BMIPS_GENERIC or ARCH_BCM_XXX.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 80bad7cba631..3bf38a328851 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -163,7 +163,7 @@ config SATA_AHCI_PLATFORM
 config AHCI_BRCM
 	tristate "Broadcom AHCI SATA support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP || \
-		   ARCH_BCM_63XX
+		   ARCH_BCM_63XX || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the AHCI SATA3 controller found on
--=20
2.31.1

