From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Fwd: [BUG] sata_via doesn't detect anymore my disks (broken between rc1 and rc3)]
Date: Fri, 25 Aug 2006 22:55:40 +0900
Message-ID: <20060825135540.GE21866@htj.dyndns.org>
References: <m2wt98bio1.fsf@vador.mandriva.com> <m2sljwbil7.fsf@vador.mandriva.com> <44E37BD4.8010709@pobox.com> <m23bbva9cs.fsf@vador.mandriva.com> <44E46E0E.4060703@gmail.com> <m2fyfv7a8s.fsf@vador.mandriva.com> <44EB32AD.1080305@gmail.com> <m2fyfnciky.fsf@vador.mandriva.com> <m2d5aprtw0.fsf@vador.mandriva.com> <44EEEA29.1010008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:36891 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932284AbWHYNzs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 09:55:48 -0400
Received: by py-out-1112.google.com with SMTP id n25so1249567pyg
        for <linux-ide@vger.kernel.org>; Fri, 25 Aug 2006 06:55:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <44EEEA29.1010008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Fri, Aug 25, 2006 at 09:16:41PM +0900, Tejun Heo wrote:
> Thierry Vignaud wrote:
> >Thierry Vignaud <tvignaud@mandriva.com> writes:
> >
> >>>Can you please test two patches attached in this mail?  Just quick
> >>>result will be enough.  If both don't work, I'll go ahead and
> >>>create a third one - which emulates the old phy hardreset exactly
> >>>as I did for softreset of vt6420.
> >>I'll.
> >>
> >>As, I've tested that using:
> >>- ata_std_prereset + ata_std_softreset didn't work
> >>- vt6420_prereset + ata_std_softreset worked
> >>- vt6420_prereset w/o ata_std_softreset didn't work
> >>
> >>I simple interdiff between your two patches makes me think the odds're
> >>higher the second will succeed but you've done some extra changes
> >>since your previous patch.
> >>I'll you tell you more about this tomorrow.
> >
> >none of both these patches worked :-(
> 
> The second didn't work?  But you said the following one liner worked.
> 
> --- drivers/ata/sata_via.c.tv6	2006-08-20 16:37:41.000000000 +0200
> +++ drivers/ata/sata_via.c	2006-08-20 17:20:23.000000000 +0200
> @@ -244,7 +244,7 @@
> 
>  static void vt6421_error_handler(struct ata_port *ap)
>  {
> -	return ata_bmdma_drive_eh(ap, ata_std_prereset, NULL,
> +	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
>  				  sata_std_hardreset, ata_std_postreset);
>  }
> 
> The second patch is essentially identical to what you did the one liner. 
>  Can you please check it once more?  I'll prepare old-sequence 
> hardreset in the meantime.

Okay, here's the old-sequence hardreset patch.  This should have the
highest chance of working.  This patch should be applied on top of the
vt6420 patch.

Thanks.

Index: work-c3/drivers/scsi/sata_via.c
===================================================================
--- work-c3.orig/drivers/scsi/sata_via.c	2006-08-25 22:53:32.000000000 +0900
+++ work-c3/drivers/scsi/sata_via.c	2006-08-25 22:53:34.000000000 +0900
@@ -75,6 +75,7 @@ static int svia_init_one (struct pci_dev
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void vt6420_error_handler(struct ata_port *ap);
+static void vt6421_error_handler(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
@@ -159,15 +160,12 @@ static const struct ata_port_operations 
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
+	.error_handler		= vt6421_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
-	.scr_read		= svia_scr_read,
-	.scr_write		= svia_scr_write,
-
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
 	.host_stop		= ata_host_stop,
@@ -203,35 +201,28 @@ static void svia_scr_write (struct ata_p
 }
 
 /**
- *	vt6420_prereset - prereset for vt6420
+ *	svia_link_resume - custom link resume
  *	@ap: target ATA port
  *
- *	SCR registers on vt6420 are pieces of shit and may hang the
- *	whole machine completely if accessed with the wrong timing.
- *	To avoid such catastrophe, vt6420 doesn't provide generic SCR
- *	access operations, but uses SStatus and SControl only during
- *	boot probing in controlled way.
- *
- *	As the old (pre EH update) probing code is proven to work, we
- *	strictly follow the access pattern.
+ *	SCR registers on these controllers are pieces of shit and may
+ *	hang the whole machine completely or cause device detection
+ *	failure if accessed with the wrong timing.  To avoid such
+ *	catastrophe, generic SCR access operations aren't provided,
+ *	but SStatus and SControl are used only during boot probing in
+ *	controlled way.
  *
  *	LOCKING:
- *	Kernel thread context (may sleep)
+ *	Kernel thread context (may sleep).
  *
  *	RETURNS:
- *	0 on success, -errno otherwise.
+ *	1 if link is online, 0 otherwise.
  */
-static int vt6420_prereset(struct ata_port *ap)
+static int svia_link_resume(struct ata_port *ap)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
 	unsigned long timeout = jiffies + (HZ * 5);
 	u32 sstatus, scontrol;
 	int online;
 
-	/* don't do any SCR stuff if we're not loading */
-	if (!ATA_PFLAG_LOADING)
-		goto skip_scr;
-
 	/* Resume phy.  This is the old resume sequence from
 	 * __sata_phy_reset().
 	 */
@@ -258,13 +249,37 @@ static int vt6420_prereset(struct ata_po
 	/* SStatus is read one more time */
 	svia_scr_read(ap, SCR_STATUS);
 
-	if (!online) {
-		/* tell EH to bail */
-		ehc->i.action &= ~ATA_EH_RESET_MASK;
-		return 0;
+	return online;
+}
+
+/**
+ *	vt6420_prereset - prereset for vt6420
+ *	@ap: target ATA port
+ *
+ *	Prereset for vt6420.  SCR registers on vt6420 can lock the
+ *	whole system up if accessed with the wrong timing.  Allow
+ *	controlled SCR access only for link resume while loading.
+ *	This keeps the code act almost identically to pre-EH code.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on sucees, -errno otherwise.
+ */
+static int vt6420_prereset(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+
+	/* resume PHY iff we're loading */
+	if (ap->flags & ATA_PFLAG_LOADING) {
+		if (!svia_link_resume(ap)) {
+			/* tell EH to bail */
+			ehc->i.action &= ~ATA_EH_RESET_MASK;
+			return 0;
+		}
 	}
 
- skip_scr:
 	/* wait for !BSY */
 	ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 
@@ -277,6 +292,64 @@ static void vt6420_error_handler(struct 
 				  NULL, ata_std_postreset);
 }
 
+/**
+ *	vt6421_hardreset - hardreset for vt6421
+ *	@ap: target ATA port
+ *	@class: resulting class of attached device
+ *
+ *	Hardreset for vt6421.  vt6421 fails to detect attached device
+ *	if SCR registers are accessed with the wrong timing.  Allow
+ *	controlled SCR access only during hardreset.  This keeps the
+ *	code act almost identically to pre-EH code.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int vt6421_hardreset(struct ata_port *ap, unsigned int *class)
+{
+	struct ata_taskfile tf;
+
+	/* issue reset */
+	svia_scr_write(ap, SCR_CONTROL, 0x301);
+	svia_scr_read(ap, SCR_CONTROL); /* flush */
+	msleep(1);
+
+	/* resume link */
+	if (!(svia_link_resume(ap))) {
+		*class = ATA_DEV_NONE;
+		return 0;
+	}
+
+	/* wait for device to become ready */
+	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+		ata_port_printk(ap, KERN_ERR,
+				"COMRESET failed (device not ready)\n");
+		return -EIO;
+	}
+
+	/* classify */
+	memset(&tf, 0, sizeof(tf));
+	ap->ops->dev_select(ap, 0);
+	ata_tf_read(ap, &tf);
+
+	*class = ata_dev_classify(&tf);
+	if (*class == ATA_DEV_UNKNOWN)
+		*class = ATA_DEV_NONE;
+	else if ((*class == ATA_DEV_ATA) && (ata_chk_status(ap) == 0))
+		*class = ATA_DEV_NONE;
+
+	return 0;
+}
+
+static void vt6421_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, NULL, NULL, vt6421_hardreset,
+				  ata_std_postreset);
+}
+
 static const unsigned int svia_bar_sizes[] = {
 	8, 4, 8, 4, 16, 256
 };

