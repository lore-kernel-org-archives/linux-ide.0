From: =?ISO-8859-15?Q?Michael_K=FChn?= <breiteseite1337@googlemail.com>
Subject: [PATCH] drivers/ata/ahci.c, kernel 2.6.23.10
Date: Sat, 15 Dec 2007 16:31:02 +0100
Message-ID: <4763F336.7050206@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:43879 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbXLOOb7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Dec 2007 09:31:59 -0500
Received: by fk-out-0910.google.com with SMTP id z23so395448fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 15 Dec 2007 06:31:57 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: torvalds@linux-foundation.org, lkml@rtr.ca

This patch remove a unused variable in the ahci_port_intr function and
therewith a compiler warning.

Signed-off-by: Michael K=FChn <breiteseite1337@googlemail.com>


--- linux-2.6.23.10/drivers/ata/ahci.c  2007-12-14 19:01:59.000000000 +=
0100
+++ linux-2.6.23.10.new/drivers/ata/ahci.c      2007-12-15
01:03:41.000000000 +0100
@@ -1430,7 +1430,6 @@
 {
        void __iomem *port_mmio =3D ap->ioaddr.cmd_addr;
        struct ata_eh_info *ehi =3D &ap->eh_info;
-       struct ahci_port_priv *pp =3D ap->private_data;
        u32 status, qc_active;
        int rc;
