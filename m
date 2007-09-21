From: "Peer Chen" <peerchen@gmail.com>
Subject: [PATCH] ahci: enable GHC.AE bit before set GHC.HR
Date: Fri, 21 Sep 2007 13:28:01 +0800
Message-ID: <200709211327569648280@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:47127 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbXIUF2H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 01:28:07 -0400
Received: by wa-out-1112.google.com with SMTP id v27so862868wah
        for <linux-ide@vger.kernel.org>; Thu, 20 Sep 2007 22:28:07 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: jeff <jeff@garzik.org>, akpm <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

According to the description of section 5.2.2.1 and 10.1.2 of AHCI spec=
ification rev1_1/rev1_2, GHC.HR shall only be set to =A1=AE1=A1=AF
by software when GHC.AE is set to =A1=AE1=A1=AF.

Signed-off-by: Peer Chen <peerchen@gmail.com>
---
--- linux-2.6.23-rc7/drivers/ata/ahci.c.orig	2007-09-20 11:01:55.000000=
000 -0400
+++ linux-2.6.23-rc7/drivers/ata/ahci.c	2007-09-20 11:07:31.000000000 -=
0400
@@ -834,6 +834,10 @@ static int ahci_reset_controller(struct=20
 	void __iomem *mmio =3D host->iomap[AHCI_PCI_BAR];
 	u32 tmp;
=20
+        /* turn on AHCI mode before controller reset*/
+        writel(HOST_AHCI_EN, mmio + HOST_CTL);
+        (void) readl(mmio + HOST_CTL);  /* flush */
+
 	/* global controller reset */
 	tmp =3D readl(mmio + HOST_CTL);
 	if ((tmp & HOST_RESET) =3D=3D 0) {
-
 			=09
--------------
Peer Chen
2007-09-21

