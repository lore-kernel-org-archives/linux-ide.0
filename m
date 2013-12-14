From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 2/2] drivers: ata: Mark the function as static in libahci.c
Date: Sat, 14 Dec 2013 19:40:21 +0530
Message-ID: <a4302d91071258c77de3e4086845adf630a3f8d6.1387029964.git.rashika.kheria@gmail.com>
References: <81391ee13d565f1db31247dfda803cd7123bb8a9.1387029964.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:47335 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab3LNOKb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Dec 2013 09:10:31 -0500
Content-Disposition: inline
In-Reply-To: <81391ee13d565f1db31247dfda803cd7123bb8a9.1387029964.git.rashika.kheria@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, josh@joshtriplett.org

This patch marks the function ahci_port_intr() and
ahci_hw_port_interrupt() as static in libahci.c because they are not
used outside this file.

Thus, it also eliminates the following warnings in libahci.c:
drivers/ata/libahci.c:1767:6: warning: no previous prototype for =E2=80=
=98ahci_port_intr=E2=80=99 [-Wmissing-prototypes]
drivers/ata/libahci.c:1800:6: warning: no previous prototype for =E2=80=
=98ahci_hw_port_interrupt=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 drivers/ata/libahci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c482f8c..36605ab 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1764,7 +1764,7 @@ static void ahci_handle_port_interrupt(struct ata=
_port *ap,
 	}
 }
=20
-void ahci_port_intr(struct ata_port *ap)
+static void ahci_port_intr(struct ata_port *ap)
 {
 	void __iomem *port_mmio =3D ahci_port_base(ap);
 	u32 status;
@@ -1797,7 +1797,7 @@ irqreturn_t ahci_thread_fn(int irq, void *dev_ins=
tance)
 }
 EXPORT_SYMBOL_GPL(ahci_thread_fn);
=20
-void ahci_hw_port_interrupt(struct ata_port *ap)
+static void ahci_hw_port_interrupt(struct ata_port *ap)
 {
 	void __iomem *port_mmio =3D ahci_port_base(ap);
 	struct ahci_port_priv *pp =3D ap->private_data;
--=20
1.7.9.5

