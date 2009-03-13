From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] pata-rb532-cf: platform_get_irq() failure ignored
Date: Fri, 13 Mar 2009 15:41:43 +0100
Message-ID: <200903131541.46648.florian@openwrt.org>
References: <49AD2ADA.5030109@gmail.com> <49AFC43A.3040206@garzik.org> <20090306164318.GF23767@nuty.nwl.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:46330 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbZCMOlz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Mar 2009 10:41:55 -0400
Received: by ewy25 with SMTP id 25so2575283ewy.37
        for <linux-ide@vger.kernel.org>; Fri, 13 Mar 2009 07:41:52 -0700 (PDT)
In-Reply-To: <20090306164318.GF23767@nuty.nwl.cc>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Jeff Garzik <jeff@garzik.org>, Roel Kluin <roel.kluin@gmail.com>, jgarzik@redhat.com, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi,

Le Friday 06 March 2009 17:43:18 Phil Sutter, vous avez =E9crit=A0:
> Hi,
>
> On Thu, Mar 05, 2009 at 07:23:22AM -0500, Jeff Garzik wrote:
> > Roel Kluin wrote:
> > >------------------------------>8-------------8<-------------------=
------
> > >-------- platform_get_irq() can return -ENXIO, but since 'irq' is =
an
> > > unsigned int, it
> > >does not show when the IRQ resource wasn't found.
> > >
> > >Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> > >---
> > >diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_=
cf.c
> > >index ebfcda2..fe8178c 100644
> > >--- a/drivers/ata/pata_rb532_cf.c
> > >+++ b/drivers/ata/pata_rb532_cf.c
> > >@@ -173,11 +173,12 @@ static __devinit int
> > > rb532_pata_driver_probe(struct platform_device *pdev)
> > > 		return -EINVAL;
> > > 	}
> > >
> > >-	irq =3D platform_get_irq(pdev, 0);
> > >-	if (irq <=3D 0) {
> > >+	ret =3D platform_get_irq(pdev, 0);
> > >+	if (ret <=3D 0) {
> > > 		dev_err(&pdev->dev, "no IRQ resource found\n");
> > > 		return -ENOENT;
> > > 	}
> > >+	irq =3D ret;
> > >
> > > 	gpio =3D irq_to_gpio(irq);
> >
> > ACK from Phil or Florian?
>
> That's fine for me, though I didn't test it (I managed to break my
> build-machine somehow, in an attempt to having the mainboard properly
> grounded).
>
> One could simplify the patch by making the variable 'irq' be signed
> instead of unsigned. This would also prevent "abusing" the variable
> 'ret'. What do you think?

I agree with this proposal, abusing the ret value is not that good. Wha=
t about the patch below :
--
=46rom: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH v2] pata-rb532-cf: platform_get_irq() failure ignored

platform_get_irq() can return -ENXIO, but since 'irq' is an
unsigned int, it does not show when the IRQ resource wasn't found.
Make irq an int so that we can use a single variable to test the
platform_get_irq() return value.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Phil Sutter <n0-1@freewrt.org>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
--
diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index ebfcda2..da05518 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -160,7 +160,7 @@ static void rb532_pata_setup_ports(struct ata_host =
*ah)
=20
 static __devinit int rb532_pata_driver_probe(struct platform_device *p=
dev)
 {
-	unsigned int irq;
+	int irq;
 	int gpio;
 	struct resource *res;
 	struct ata_host *ah;
