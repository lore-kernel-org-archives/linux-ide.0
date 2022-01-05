Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B085C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbiAEFR7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:59 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:12138 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237444AbiAEFR5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:57 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmz5DB9z1VSkg
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359875; x=1643951876; bh=EIsFBs8LSmbGWA23Yi
        32jDDhU0n+cE0rx+RpDZpsmFg=; b=YAjKKzTgBU8nDx9+UZm//LY4Aed7sxnEeD
        XNOpz9hiJ8ozoHlyk+Ec+grgIsJwSaiiHCTeYzeC065BOz9/mh8IChm1FFt2lgsG
        e8+mqQ//XeUru7/aL9Kj1sDEJ7MboSs2Ev4+E17THE9YRXy/tixVT8G1V7vHZiNd
        50/UxH5X/eyWyd4ouzcGn3r9po03OtLL0ltL0azLeZdvSTCeKZhpj/vgi1jzOJF+
        3gB8L4G3JA7/okZ4UR10X7exTSayzN56yYFr5CmQuzINVG0k9A+fNz6V+/16/QU1
        Rsgw3zkrlNlHre3OLhy47D9urTVu9OlsJm4R2CtwP9qvsvSQImig==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2eja25CifmEr for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:55 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmy6l9Dz1VSkZ;
        Tue,  4 Jan 2022 21:17:54 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 21/22] ata: ahci_xgene: use correct type for port mmio address
Date:   Wed,  5 Jan 2022 14:17:34 +0900
Message-Id: <20220105051735.1871177-22-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Sparse complains about an incorrect type for port_mmio pointer
variables:

drivers/ata/ahci_xgene.c:196:41: warning: incorrect type in initializer
(different address spaces)
drivers/ata/ahci_xgene.c:196:41:    expected void *port_mmio
drivers/ata/ahci_xgene.c:196:41:    got void [noderef] __iomem *

Fix this by declaring port_mmio as "void __iomem *" instead of "void *".

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/ahci_xgene.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 4d8a186ec12a..68ec7e9430b2 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -193,7 +193,7 @@ static unsigned int xgene_ahci_qc_issue(struct ata_qu=
eued_cmd *qc)
 	struct xgene_ahci_context *ctx =3D hpriv->plat_data;
 	int rc =3D 0;
 	u32 port_fbs;
-	void *port_mmio =3D ahci_port_base(ap);
+	void __iomem *port_mmio =3D ahci_port_base(ap);
=20
 	/*
 	 * Write the pmp value to PxFBS.DEV
@@ -454,7 +454,7 @@ static int xgene_ahci_pmp_softreset(struct ata_link *=
link, unsigned int *class,
 	int pmp =3D sata_srst_pmp(link);
 	struct ata_port *ap =3D link->ap;
 	u32 rc;
-	void *port_mmio =3D ahci_port_base(ap);
+	void __iomem *port_mmio =3D ahci_port_base(ap);
 	u32 port_fbs;
=20
 	/*
@@ -499,7 +499,7 @@ static int xgene_ahci_softreset(struct ata_link *link=
, unsigned int *class,
 	struct ata_port *ap =3D link->ap;
 	struct ahci_host_priv *hpriv =3D ap->host->private_data;
 	struct xgene_ahci_context *ctx =3D hpriv->plat_data;
-	void *port_mmio =3D ahci_port_base(ap);
+	void __iomem *port_mmio =3D ahci_port_base(ap);
 	u32 port_fbs;
 	u32 port_fbs_save;
 	u32 retry =3D 1;
--=20
2.31.1

