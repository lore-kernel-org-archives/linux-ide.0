From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: mm snapshot broken-out-2007-01-26-00-36.tar.gz uploaded
Date: Sat, 27 Jan 2007 17:03:19 +0100
Message-ID: <45BB77C7.5090202@googlemail.com>
References: <200701260837.l0Q8blBr011622@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:32547 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbXA0QDd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Jan 2007 11:03:33 -0500
Received: by ug-out-1314.google.com with SMTP id 44so929134uga
        for <linux-ide@vger.kernel.org>; Sat, 27 Jan 2007 08:03:31 -0800 (PST)
In-Reply-To: <200701260837.l0Q8blBr011622@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Tejun Heo <teheo@novell.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

akpm@osdl.org napisa=C5=82(a):
> The mm snapshot broken-out-2007-01-26-00-36.tar.gz has been uploaded =
to
>=20
>    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-20=
07-01-26-00-36.tar.gz
>=20

drivers/ata/sata_inic162x.c: In function =E2=80=98inic_pci_device_resum=
e=E2=80=99:
drivers/ata/sata_inic162x.c:652: warning: ignoring return value of =E2=80=
=98ata_pci_device_do_resume=E2=80=99, declared with attribute warn_unus=
ed_result
drivers/ata/sata_inic162x.c: In function =E2=80=98inic_init_one=E2=80=99=
:
drivers/ata/sata_inic162x.c:727: error: =E2=80=98SA_SHIRQ=E2=80=99 unde=
clared (first use in this function)
drivers/ata/sata_inic162x.c:727: error: (Each undeclared identifier is =
reported only once
drivers/ata/sata_inic162x.c:727: error: for each function it appears in=
=2E)
make[2]: *** [drivers/ata/sata_inic162x.o] B=C5=82=C4=85d 1
make[1]: *** [drivers/ata] B=C5=82=C4=85d 2
make: *** [drivers] B=C5=82=C4=85d 2

SA_SHIRQ was removed. IRQF_SHARED should be used instead?

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

--- linux-work-clean/drivers/ata/sata_inic162x.c	2007-01-26 16:47:31.00=
0000000 +0100
+++ linux-work/drivers/ata/sata_inic162x.c	2007-01-27 16:53:26.00000000=
0 +0100
@@ -724,7 +724,7 @@ static int inic_init_one(struct pci_dev
 	probe_ent->n_ports		=3D NR_PORTS;

 	probe_ent->irq =3D pdev->irq;
-	probe_ent->irq_flags =3D SA_SHIRQ;
+	probe_ent->irq_flags =3D IRQF_SHARED;

 	probe_ent->mmio_base =3D mmio_base;

