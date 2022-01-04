Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52689C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiADK7B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:59:01 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:8191 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231782AbiADK67 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:59 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNy6R5dz1VSkb
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293938; x=1643885939; bh=nj7oJlA+0Ay0qoDzOh
        +P6DuVUyVAtM2MHB0KNWNzBKI=; b=WxZXmYOc/ODGU/czRQivL/ktjq9WL7dROu
        cF/SIa+USnjVyQc4LYRyEESr9oFvoiLXDtNEmlz+Dz/pbmKQbEN5g/xSspz6OLxn
        zJrGH7Kv/nyZjzLQR+MWHcghirMnzzacBySIHOgaCJEzh6EqgNM8yX8z7i0jjG36
        fquh0HfUpQMcshkJNppSZ0P90hPbMVouJrhunHaDuEUxz97nCzkiQidZm45gXXep
        H7ygSDZFkP4DiyaKwg/m4KXvZNUSRvqXcWKrzZyj6FUMmCS0zOXXA++SxxBw7+v/
        OGkHZsDRD6BzR+ubqgTzUXxJPoT2va2JKb5EgTUPNbyGC6a3/Ghg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 55eByZ5kTEWN for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:58 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNy21g2z1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:58 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 21/22] ata: ahci_xgene: use correct type for port mmio address
Date:   Tue,  4 Jan 2022 19:58:42 +0900
Message-Id: <20220104105843.1730172-22-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
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

