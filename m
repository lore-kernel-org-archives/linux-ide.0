From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 4/6] PalmLD IDE
Date: Sat, 16 Aug 2008 16:30:09 +0200
Message-ID: <200808161630.09508.marek.vasut@gmail.com>
References: <200808132252.23732.marek.vasut@gmail.com> <20080816090803.GI5946@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xRupIJPRERTkMDI"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:59288 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbYHPO00 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Aug 2008 10:26:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1180634fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 16 Aug 2008 07:26:24 -0700 (PDT)
In-Reply-To: <20080816090803.GI5946@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Eric Miao <eric.y.miao@gmail.com>, linux-ide@vger.kernel.org, bzolnier@gmail.com

--Boundary-00=_xRupIJPRERTkMDI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dne Saturday 16 of August 2008 11:08:03 Russell King - ARM Linux napsal(a):
> On Wed, Aug 13, 2008 at 10:52:23PM +0200, Marek Vasut wrote:
> > This patch adds palmld ide channel support, same as previous patch, I
> > think this can be merged since it wont break anything.
>
> I think this one also needs review by the Linux ATA folk.  Mention to
> them that it's part of a patchset for ARM and that you'd prefer it
> to be merged into the ARM tree.
>
> > +static const char drvname[] = "pata_palmld";
> > +MODULE_ALIAS("platform: "drvname);
>
> Have you tried building this as a module?  Also, IIRC, there isn't
> supposed to be a space after the colon...

Ok, I fixed the issues and CCed linux-ide and the maintainer.

Thanks


--Boundary-00=_xRupIJPRERTkMDI
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0004-PalmLD-IDE-support.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0004-PalmLD-IDE-support.patch"

=46rom 8881f9cbf66a3050de328f6c020f864ca04c1e9b Mon Sep 17 00:00:00 2001
=46rom: Marek <marek.vasut@gmail.com>
Date: Sat, 16 Aug 2008 16:25:34 +0200
Subject: [PATCH] PalmLD: IDE support
 Support for Palm LifeDrive's internal harddrive

=2D--
 drivers/ata/Kconfig       |    9 +++
 drivers/ata/Makefile      |    1 +
 drivers/ata/pata_palmld.c |  145 +++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 155 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ata/pata_palmld.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ae84949..8e43d11 100644
=2D-- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -533,6 +533,15 @@ config PATA_OPTIDMA
=20
 	  If unsure, say N.
=20
+config PATA_PALMLD
+	tristate "Palm LifeDrive PATA support"
+	depends on MACH_PALMLD
+	help
+	  This option enables support for Palm LifeDrive's internal ATA
+	  port via the new ATA layer.
+
+	  If unsure, say N.
+
 config PATA_PCMCIA
 	tristate "PCMCIA PATA support"
 	depends on PCMCIA
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 674965f..2b393c9 100644
=2D-- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_PATA_MPC52xx)	+=3D pata_mpc52xx.o
 obj-$(CONFIG_PATA_MARVELL)	+=3D pata_marvell.o
 obj-$(CONFIG_PATA_MPIIX)	+=3D pata_mpiix.o
 obj-$(CONFIG_PATA_OLDPIIX)	+=3D pata_oldpiix.o
+obj-$(CONFIG_PATA_PALMLD)	+=3D pata_palmld.o
 obj-$(CONFIG_PATA_PCMCIA)	+=3D pata_pcmcia.o
 obj-$(CONFIG_PATA_PDC2027X)	+=3D pata_pdc2027x.o
 obj-$(CONFIG_PATA_PDC_OLD)	+=3D pata_pdc202xx_old.o
diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
new file mode 100644
index 0000000..f0693f8
=2D-- /dev/null
+++ b/drivers/ata/pata_palmld.c
@@ -0,0 +1,145 @@
+/*
+ * drivers/ata/pata_palmld.c
+ *
+ * Driver for IDE channel in Palm LifeDrive
+ *
+ * Based on research of:
+ *		Alex Osborne <ato@meshy.org>
+ *
+ * Rewrite for mainline:
+ *		Marek Vasut <marek.vasut@gmail.com>
+ *
+ * Rewritten version based on pata_ixp4xx_cf.c:
+ * ixp4xx PATA/Compact Flash driver
+ * Copyright (C) 2006-07 Tower Technologies
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/libata.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+
+#include <scsi/scsi_host.h>
+#include <mach/palmld.h>
+
+#define DRV_NAME "pata_palmld"
+
+static struct scsi_host_template palmld_sht =3D {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+static struct ata_port_operations palmld_port_ops =3D {
+	.inherits		=3D &ata_sff_port_ops,
+	.sff_data_xfer		=3D ata_sff_data_xfer_noirq,
+	.cable_detect		=3D ata_cable_40wire,
+};
+
+static __devinit int palmld_pata_probe(struct platform_device *pdev)
+{
+	struct ata_host *host;
+	struct ata_port *ap;
+	void __iomem *mem;
+	int ret;
+
+	/* allocate host */
+	host =3D ata_host_alloc(&pdev->dev, 1);
+	if (!host)
+		return -ENOMEM;
+
+	/* remap drive's physical memory address */
+	mem =3D devm_ioremap(&pdev->dev, PALMLD_IDE_PHYS, 0x1000);
+	if (!mem)
+		return -ENOMEM;
+
+	/* request and activate power GPIO, IRQ GPIO */
+	ret =3D gpio_request(GPIO_NR_PALMLD_IDE_PWEN, "HDD PWR");
+	if (ret)
+		goto err1;
+	ret =3D gpio_direction_output(GPIO_NR_PALMLD_IDE_PWEN, 1);
+	if (ret)
+		goto err2;
+
+	ret =3D gpio_request(GPIO_NR_PALMLD_IDE_IRQ, "HDD IRQ");
+	if (ret)
+		goto err2;
+	ret =3D gpio_direction_input(GPIO_NR_PALMLD_IDE_IRQ);
+	if (ret)
+		goto err3;
+
+	/* we'd better wait for drive's ready signal here
+	  (if we knew where it will come from) */
+	msleep(300);
+
+	/* setup the ata port */
+	ap =3D host->ports[0];
+	ap->ops	=3D &palmld_port_ops;
+	ap->pio_mask =3D ATA_PIO4;
+	ap->flags |=3D ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY | ATA_FLAG_NO_ATAPI;
+
+	/* memory mapping voodoo */
+	ap->ioaddr.cmd_addr =3D mem + 0x10;
+	ap->ioaddr.altstatus_addr =3D mem + 0xe;
+	ap->ioaddr.ctl_addr =3D mem + 0xe;
+
+	/* start the port */
+	ata_sff_std_ports(&ap->ioaddr);
+
+	/* activate host */
+	return ata_host_activate(host, gpio_to_irq(GPIO_NR_PALMLD_IDE_IRQ),
+					ata_sff_interrupt, IRQF_TRIGGER_RISING,
+					&palmld_sht);
+err3:
+	gpio_free(GPIO_NR_PALMLD_IDE_IRQ);
+err2:
+	gpio_free(GPIO_NR_PALMLD_IDE_PWEN);
+err1:
+	return ret;
+}
+
+static __devexit int palmld_pata_remove(struct platform_device *dev)
+{
+	struct ata_host *host =3D platform_get_drvdata(dev);
+
+	ata_host_detach(host);
+
+	gpio_free(GPIO_NR_PALMLD_IDE_PWEN);
+	gpio_free(GPIO_NR_PALMLD_IDE_IRQ);
+
+	return 0;
+}
+
+static struct platform_driver palmld_pata_platform_driver =3D {
+	.driver	 =3D {
+		.name   =3D DRV_NAME,
+		.owner  =3D THIS_MODULE,
+	},
+	.probe		=3D palmld_pata_probe,
+	.remove		=3D __devexit_p(palmld_pata_remove),
+};
+
+static int __init palmld_pata_init(void)
+{
+	return platform_driver_register(&palmld_pata_platform_driver);
+}
+
+static void __exit palmld_pata_exit(void)
+{
+	platform_driver_unregister(&palmld_pata_platform_driver);
+}
+
+MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION("PalmLD PATA driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
+
+module_init(palmld_pata_init);
+module_exit(palmld_pata_exit);
=2D-=20
1.5.6


--Boundary-00=_xRupIJPRERTkMDI--
