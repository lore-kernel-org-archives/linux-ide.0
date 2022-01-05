Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6613C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiAEFRq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:46 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:7815 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237430AbiAEFRq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:46 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmn6qGgz1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359865; x=1643951866; bh=SHM5XKXMkUGbJAc/Sx
        8gaDN366RztoRkk6InG242bt8=; b=syqBsUz/3oxPKVBlrLRgGXAAKAEzSmVs38
        h8/PfYgy4qcI7BDwY/D6I4HfLBcmKoIbJd3heXSnf+wvICSL0F0hKqE9jtONrZbt
        hAY+aSmfN2gNn6qx7TVy3WRbyiGOwvfeUFTOnLywXpEoJ8L2YypVzShGgFqv/tSW
        EXnp0jF/2w+aMBMrieSR6o68g/2ZfIyKiyRA7AvbgPhVYerNm2M2zfq+vsYFmMN9
        qAjQaIjEj8RiYnZ7dc89OemaaNKsgOH0hYx9UDorr5bRFCwos3KJ2hJ99vamrrp4
        +LVvGVJ/XuNijjXofpjftz3pajkAzwy/6hUw5IRhaxfdCebBQxWg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N1JqCqshsbPs for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:45 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmn1QY0z1VSkX;
        Tue,  4 Jan 2022 21:17:45 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 08/22] ata: ahci_sunxi: add compile test support
Date:   Wed,  5 Jan 2022 14:17:21 +0900
Message-Id: <20220105051735.1871177-9-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_SUNXI.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 237124624db4..db3f65ae1ed5 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -253,7 +253,7 @@ config AHCI_OCTEON
=20
 config AHCI_SUNXI
 	tristate "Allwinner sunxi AHCI SATA support"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the Allwinner sunxi SoC's
--=20
2.31.1

