From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC] Port of pdc202xx_new driver to libata
Date: Fri, 22 Oct 2004 10:32:09 +0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <003d01c4b7df$5624d160$7301a8c0@tw.ibm.com>
References: <00bb01c4b10c$4b2ab330$7301a8c0@tw.ibm.com> <58cb370e04101312321c78f3b8@mail.gmail.com> <416D88FA.1050200@pobox.com> <001901c4b4fd$88204bc0$294bbf09@tw.ibm.com> <4173F6AC.7090409@pobox.com> <001601c4b749$04f49550$7301a8c0@tw.ibm.com> <417841F6.4060809@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_003A_01C4B822.62C282D0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:30200 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S271171AbUJVCcS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Oct 2004 22:32:18 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_003A_01C4B822.62C282D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Jeff:

  Attached please find the patch, thanks.

Albert

Signed-off-by: Albert Lee<albertcc@tw.ibm.com>

----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Albert Lee" <albertcc@tw.ibm.com>
Cc: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>; "IDE Linux"
<linux-ide@vger.kernel.org>
Sent: Friday, October 22, 2004 7:10 AM
Subject: Re: [PATCH/RFC] Port of pdc202xx_new driver to libata


> Albert Lee wrote:
> > Hi, Jeff:
> >
> >  Please see my reply below.
> > I'll resend the patch according to your review/comments later.
> > Thanks for your patience for newbie like me. :-)
>
> Note that I applied your patch... so please just send a follow-up patch,
> diff'd against the latest libata-dev patch/BK.
>
> http://marc.theaimsgroup.com/?t=109782787200002&r=1&w=2&n=4
>
> Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

------=_NextPart_000_003A_01C4B822.62C282D0
Content-Type: application/octet-stream;
	name="pdc2027x-2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pdc2027x-2.diff"

diff -Nru libata-pdc2-2.6/drivers/scsi/pata_pdc2027x.c =
libata-pdc2-2.6-mod/drivers/scsi/pata_pdc2027x.c=0A=
--- libata-pdc2-2.6/drivers/scsi/pata_pdc2027x.c	2004-10-21 =
17:17:40.000000000 +0800=0A=
+++ libata-pdc2-2.6-mod/drivers/scsi/pata_pdc2027x.c	2004-10-21 =
17:28:06.990919600 +0800=0A=
@@ -29,10 +29,8 @@=0A=
 #include <asm/io.h>=0A=
 =0A=
 #define DRV_NAME	"pata_pdc2027x"=0A=
-#define DRV_VERSION	"0.52"=0A=
+#define DRV_VERSION	"0.53"=0A=
 #undef PDC_DEBUG=0A=
-#undef PDC_20276_QUIRK=0A=
-#undef PDC_20270_QUIRK=0A=
 =0A=
 #ifdef PDC_DEBUG=0A=
 #define PDPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, =
__FUNCTION__, ## args)=0A=
@@ -59,7 +57,7 @@=0A=
  * These tables are only used when the controller is in 133MHz clock.=0A=
  * If the controller is in 100MHz clock, the ASIC hardware will =0A=
  * set the timing registers automatically when "set feature" command =0A=
- * issued to the device. However, if the controller clock is 133MHz, =0A=
+ * is issued to the device. However, if the controller clock is 133MHz, =0A=
  * the following tables must be used.=0A=
  */=0A=
 static struct pdc2027x_pio_timing {=0A=
@@ -554,16 +552,6 @@=0A=
 {=0A=
 	long pll_clock;=0A=
 =0A=
-	/* Enable the ROM */=0A=
-	/*=0A=
-	if (pdev->resource[PCI_ROM_RESOURCE].start) {=0A=
-		pci_write_config_dword(pdev, PCI_ROM_ADDRESS,=0A=
-			pdev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);=0A=
-		printk(KERN_INFO DRV_NAME ": ROM enabled at 0x%08lx\n",=0A=
-		       pdev->resource[PCI_ROM_RESOURCE].start);=0A=
-	}=0A=
-	*/=0A=
-=0A=
 	/*=0A=
 	 * Detect PLL input clock rate.=0A=
 	 * On some system, where PCI bus is running at non-standard clock rate.=0A=
@@ -604,58 +592,6 @@=0A=
 	if (!printed_version++)=0A=
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");=0A=
 =0A=
-#ifdef PDC_20276_QUIRK=0A=
-	/*=0A=
-	 * Skip Promise PDC20276 attached to I2O RAID controller =0A=
-	 */=0A=
-	if ((pdev->device =3D=3D PCI_DEVICE_ID_PROMISE_20276) &&=0A=
-	    (pdev->bus->self) &&=0A=
-	    (pdev->bus->self->vendor =3D=3D PCI_VENDOR_ID_INTEL) &&=0A=
-	    ((pdev->bus->self->device =3D=3D PCI_DEVICE_ID_INTEL_I960) ||=0A=
-	     (pdev->bus->self->device =3D=3D PCI_DEVICE_ID_INTEL_I960RM))) {=0A=
-		printk(KERN_INFO DRV_NAME ": Skipping Promise PDC20276 "=0A=
-		       "attached to I2O RAID controller.\n");=0A=
-		return -ENODEV;=0A=
-	}=0A=
-#endif=0A=
-=0A=
-#ifdef PDC_20270_QUIRK=0A=
-	/*=0A=
-	 * Special IRQ handling for Promise PDC20270 attached to the =0A=
-	 * DEC DC21150 PCI south bridge.  (DC21150 PCI bridge can be found =0A=
-	 * on Compaq ProLiant 800 and ProLiant 1600 servers.) =0A=
-	 * FIXME: Not tested yet on libata.=0A=
-	 */=0A=
-	if ((pdev->device =3D=3D PCI_DEVICE_ID_PROMISE_20270) &&=0A=
-	    (pdev->bus->self) &&=0A=
-	    (pdev->bus->self->vendor =3D=3D PCI_VENDOR_ID_DEC) &&=0A=
-	    (pdev->bus->self->device =3D=3D PCI_DEVICE_ID_DEC_21150)) {=0A=
-		struct pci_dev *findev =3D NULL;=0A=
-=0A=
-		if (PCI_SLOT(pdev->devfn) & 2) {=0A=
-			/* This pdc20270 is in PCI slot with bit 1 set.=0A=
-			 * Find the other pdc20270 in PCI slot with bit 1 cleared.=0A=
-			 * If found, override my IRQ setting to irq of that device.=0A=
-			 */=0A=
-			//d->extra =3D 0; // No extra DMA address on pdc20270=0A=
-					   =0A=
-			while ((findev =3D pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) =
!=3D NULL) {=0A=
-				if ((findev->vendor =3D=3D pdev->vendor) &&=0A=
-				    (findev->device =3D=3D pdev->device) &&=0A=
-				    (!(PCI_SLOT(findev->devfn) & 2))) {=0A=
-					=0A=
-					if (pdev->irq !=3D findev->irq) {=0A=
-						// Override the IRQ setting=0A=
-						pdev->irq =3D findev->irq;=0A=
-						break;=0A=
-					}=0A=
-				}=0A=
-			}=0A=
-		}=0A=
-=0A=
-	}=0A=
-#endif=0A=
-=0A=
 	rc =3D pci_enable_device(pdev);=0A=
 	if (rc)=0A=
 		return rc;=0A=

------=_NextPart_000_003A_01C4B822.62C282D0--

