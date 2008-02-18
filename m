From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH] next-20080218 build failure at pmac_ide_macio_attach ()
Date: Mon, 18 Feb 2008 19:31:59 +0530
Message-ID: <20080218140159.GA31310@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754879AbYBROC1@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au, apw@shadowen.org
List-Id: linux-ide@vger.kernel.org

Hi,

The next-20080218 kernel build fails on the powerpc(s)

drivers/ide/ppc/pmac.c: In function =E2=80=98pmac_ide_macio_attach=E2=80=
=99:
drivers/ide/ppc/pmac.c:1094: error: conversion to non-scalar type reque=
sted
drivers/ide/ppc/pmac.c: In function =E2=80=98pmac_ide_pci_attach=E2=80=99=
:
drivers/ide/ppc/pmac.c:1232: error: conversion to non-scalar type reque=
sted
make[3]: *** [drivers/ide/ppc/pmac.o] Error 1
make[2]: *** [drivers/ide/ppc] Error 2
make[1]: *** [drivers/ide] Error 2
make: *** [drivers] Error 2

I Have tested this patch for build failure only.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
--- linux-2.6.25-rc1/drivers/ide/ppc/pmac.c	2008-02-18 18:41:48.0000000=
00 +0530
+++ linux-2.6.25-rc1/drivers/ide/ppc/~pmac.c	2008-02-18 19:20:37.000000=
000 +0530
@@ -1091,7 +1091,7 @@ pmac_ide_macio_attach(struct macio_dev *
 	int irq, rc;
 	hw_regs_t hw;
=20
-	pmif =3D (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
+	pmif =3D (struct pmac_ide_hwif*)kzalloc(sizeof(*pmif), GFP_KERNEL);
 	if (pmif =3D=3D NULL)
 		return -ENOMEM;
=20
@@ -1229,7 +1229,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 		return -ENODEV;
 	}
=20
-	pmif =3D (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
+	pmif =3D (struct pmac_ide_hwif*)kzalloc(sizeof(*pmif), GFP_KERNEL);
 	if (pmif =3D=3D NULL)
 		return -ENOMEM;
=20
--=20
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
