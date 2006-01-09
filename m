From: Dan Williams <dan.j.williams@gmail.com>
Subject: Re: [PATCH 2.6.14.3] Necessary evil to get sata_vsc to initialize with Intel iq3124h hba
Date: Mon, 9 Jan 2006 16:30:56 -0700
Message-ID: <e9c3a7c20601091530g7c5a5ac2vb0e2f24ed5198911@mail.gmail.com>
References: <20051214201049.GA20640@dwillia2-linux.ch.intel.com>
	 <20051218091904.GA39033@sgi.com>
	 <e9c3a7c20512271127v36eb56c9m54568a79784412e@mail.gmail.com>
	 <20060105075732.GA323621@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14267_31824057.1136849456492"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:7024 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751081AbWAIXa5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2006 18:30:57 -0500
Received: by zproxy.gmail.com with SMTP id 13so4293090nzn
        for <linux-ide@vger.kernel.org>; Mon, 09 Jan 2006 15:30:57 -0800 (PST)
In-Reply-To: <20060105075732.GA323621@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-ide@vger.kernel.org

------=_Part_14267_31824057.1136849456492
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Dan, please trim trailing whitespace from your patch, if you would.  Othe=
r
> than that, your patch to sata_vsc.c and Kconfig looks fine to me.  I'm no=
t sure
> about the patch to libata-scsi.c, but jgarzik can review that one.
>
> I checked both the Intel and Vitesse documentation, and they both indicat=
e
> that the error interrupts are masked by default.  Perhaps your PROM/BIOS
> software is enabling them.  Ours does not, and the sata_vsc driver doesn'=
t
> either.  Perhaps it should -- though since we're just ignoring them, that
> doesn't make much sense.  Maybe we should explicitly mask them off?  Or
> explicitly enable them, rather than leaving the chip in whatever state
> the PROM/BIOS leaves it.  Perhaps this patch is all you really need.
> Can you try it?
>
> --- linux-2.6.15/drivers/scsi/sata_vsc.c        2006-01-02 19:21:10.00000=
0000 -0800
> +++ linux-2.6.15-mask/drivers/scsi/sata_vsc.c   2006-01-04 23:55:16.00000=
0000 -0800
> @@ -108,9 +108,9 @@
>                 VSC_SATA_INT_MASK_OFFSET + ap->port_no;
>         mask =3D readb(mask_addr);
>         if (ctl & ATA_NIEN)
> -               mask |=3D 0x80;
> +               mask =3D 0x80;
>         else
> -               mask &=3D 0x7F;
> +               mask =3D 0;
>         writeb(mask, mask_addr);
>  }
>

Surprisingly, I still get the endless error interrupts with this patch appl=
ied.

I integrated this patch with the previous explicit clear patch, and
added debug prints to see when vsc_intr_mask_update is called relative
to the interrupt handler.  Below is the debug output, and attached is
the integrated patch with the interrupt mask changes (trimmed for
white space against 2.6.15).

Dan

libata version 1.20 loaded.
sata_vsc 0000:00:01.0: version 1.1
ata1: SATA max UDMA/133 cmd 0xEE0A0200 ctl 0xEE0A0229 bmdma 0xEE0A0270 irq =
25
ata2: SATA max UDMA/133 cmd 0xEE0A0400 ctl 0xEE0A0429 bmdma 0xEE0A0470 irq =
25
ata3: SATA max UDMA/133 cmd 0xEE0A0600 ctl 0xEE0A0629 bmdma 0xEE0A0670 irq =
25
ata4: SATA max UDMA/133 cmd 0xEE0A0800 ctl 0xEE0A0829 bmdma 0xEE0A0870 irq =
25
entering vsc_intr_mask_update
exiting vsc_intr_mask_update
vsc_sata_interrupt: clearing interrupt, status 83; sata err status 50002
ata1: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:=
007f
ata1: dev 0 ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_vsc
entering vsc_intr_mask_update
exiting vsc_intr_mask_update
vsc_sata_interrupt: clearing interrupt, status 8300; sata err status 50002
ata2: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:=
007f
ata2: dev 0 ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_vsc
entering vsc_intr_mask_update
exiting vsc_intr_mask_update
vsc_sata_interrupt: clearing interrupt, status 830000; sata err status 5000=
2
ata3: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:=
007f
ata3: dev 0 ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_vsc
ata4: no device found (phy stat 00000000)
scsi3 : sata_vsc
 Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 27.0
 Type:   Direct-Access                      ANSI SCSI revision: 05
 Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 27.0
 Type:   Direct-Access                      ANSI SCSI revision: 05
 Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 27.0
 Type:   Direct-Access                      ANSI SCSI revision: 05

------=_Part_14267_31824057.1136849456492
Content-Type: text/x-patch; name=sata_vsc_intel-2.6.15.patch;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sata_vsc_intel-2.6.15.patch"

[PATCH] Clear Intel 31244 error interrupts in the sata_vsc driver
* This patch represents the result of the following thread:
http://marc.theaimsgroup.com/?t=113459121300006&r=1&w=2

Signed-off-by: Dan Williams <dan.j.williams@intel.com>

--- linux-2.6.15/drivers/scsi/sata_vsc.c	2006-01-09 16:07:17.000000000 -0700
+++ linux-2.6/drivers/scsi/sata_vsc.c	2006-01-09 16:12:48.000000000 -0700
@@ -81,6 +81,22 @@
 /* Port stride */
 #define VSC_SATA_PORT_OFFSET		0x200
 
+/* Error interrupt status bit offsets */
+#define VSC_SATA_INT_ERROR_CRC		(1 << 6)
+#define VSC_SATA_INT_ERROR_T		(1 << 5)
+#define VSC_SATA_INT_ERROR_P		(1 << 4)
+#define VSC_SATA_INT_ERROR_R		(1 << 3)
+#define VSC_SATA_INT_ERROR_E		(1 << 2)
+#define VSC_SATA_INT_ERROR_M		(1 << 1)
+#define VSC_SATA_INT_PHY_CHANGE	(1 << 0)
+#define VSC_SATA_INT_ERROR (VSC_SATA_INT_ERROR_CRC  + VSC_SATA_INT_ERROR_T + \
+			     VSC_SATA_INT_ERROR_P    + VSC_SATA_INT_ERROR_R + \
+			     VSC_SATA_INT_ERROR_E    + VSC_SATA_INT_ERROR_M + \
+			     VSC_SATA_INT_PHY_CHANGE)
+
+#define is_vsc_sata_int_err(port_idx, int_status) \
+	 (int_status & (VSC_SATA_INT_ERROR << (8 * port_idx)))
+
 
 static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
@@ -102,15 +118,15 @@
 static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
 {
 	void __iomem *mask_addr;
-	u8 mask;
-
+	u8 mask;
+
 	mask_addr = ap->host_set->mmio_base +
 		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
 	mask = readb(mask_addr);
 	if (ctl & ATA_NIEN)
-		mask |= 0x80;
+		mask = 0x80;
 	else
-		mask &= 0x7F;
+		mask = 0;
 	writeb(mask, mask_addr);
 }
 
@@ -206,8 +222,28 @@
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 					handled += ata_host_intr(ap, qc);
+				} else if (is_vsc_sata_int_err(i, int_status)) {
+					/*
+					 * On some chips (i.e. Intel 31244), an error
+					 * interrupt will sneak in at initialization
+					 * time (phy state changes).  Clearing the SCR
+					 * error register is not required, but it prevents
+					 * the phy state change interrupts from recurring
+					 * later.
+					 */
+					u32 err_status;
+					err_status = vsc_sata_scr_read(ap, SCR_ERROR);
+					printk(KERN_DEBUG "%s: clearing interrupt, "
+					       "status %x; sata err status %x\n",
+					       __FUNCTION__,
+					       int_status, err_status);
+					vsc_sata_scr_write(ap, SCR_ERROR, err_status);
+					/* Clear interrupt status */
+					ata_chk_status(ap);
+					handled++;
+				}
 			}
 		}
 	}
--- linux-2.6.15/drivers/scsi/Kconfig	2006-01-09 16:07:14.000000000 -0700
+++ linux-2.6/drivers/scsi/Kconfig	2005-12-29 11:05:06.000000000 -0700
@@ -586,10 +586,10 @@
 	  If unsure, say N.
 
 config SCSI_SATA_VITESSE
-	tristate "VITESSE VSC-7174 SATA support"
+	tristate "VITESSE VSC-7174 / INTEL 31244 SATA support"
 	depends on SCSI_SATA && PCI
 	help
-	  This option enables support for Vitesse VSC7174 Serial ATA.
+	  This option enables support for Vitesse VSC7174 and Intel 31244 Serial ATA.
 
 	  If unsure, say N.
 

------=_Part_14267_31824057.1136849456492--
