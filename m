From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [Fwd: [BUG] sata_via doesn't detect anymore my disks (broken between rc1 and rc3)]
Date: Fri, 25 Aug 2006 16:02:29 +0200
Message-ID: <m2ejv4oqve.fsf@vador.mandriva.com>
References: <44D98E7E.3060208@pobox.com> <44E29AEF.8030606@gmail.com>
	<20060816051408.GI6371@htj.dyndns.org>
	<m2wt98bio1.fsf@vador.mandriva.com> <m2sljwbil7.fsf@vador.mandriva.com>
	<44E37BD4.8010709@pobox.com> <m23bbva9cs.fsf@vador.mandriva.com>
	<44E46E0E.4060703@gmail.com> <m2fyfv7a8s.fsf@vador.mandriva.com>
	<44EB32AD.1080305@gmail.com> <m2fyfnciky.fsf@vador.mandriva.com>
	<m2d5aprtw0.fsf@vador.mandriva.com> <44EEEA29.1010008@gmail.com>
	<m2irkgor60.fsf@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:29961 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP id S932328AbWHYOCb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 10:02:31 -0400
In-Reply-To: <m2irkgor60.fsf@vador.mandriva.com> (Thierry Vignaud's message of "Fri, 25 Aug 2006 15:56:07 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

--=-=-=

Thierry Vignaud <tvignaud@mandriva.com> writes:

> > > none of both these patches worked :-(
> > 
> > The second didn't work?  But you said the following one liner
> > worked.
> 
> Worked on top of *your original patch*.
> 
> What's more,
>  
> > +	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
> >   				  sata_std_hardreset, ata_std_postreset);
> 
> is different from:
> 
> +	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
> +				  NULL, ata_std_postreset);
> 
> Note also that I tested my one liner on top of 2.6.18-rc4-mm1 + your
> patch whereas I tested your latest patches on top of 2.6.18-rc4-mm2
>                                                                //\\
> 
> Can this make a difference?
> 
> > The second patch is essentially identical to what you did the one
> > liner. Can you please check it once more?  I'll prepare old-sequence
> > hardreset in the meantime.

an btw, "the second patch is essentially identical to what you did the
one liner" doesn't *accuratly* describe the differences between your
last week patch and the second of other day patch.  There're actually
a *little* more than my one-liner :-) :

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=s.diff

--- ./sata_via.c.1	2006-08-25 15:59:10.000000000 +0200
+++ ./sata_via.c	2006-08-25 15:59:20.000000000 +0200
@@ -135,9 +135,6 @@
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
-	.scr_read		= svia_scr_read,
-	.scr_write		= svia_scr_write,
-
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
 	.host_stop		= ata_host_stop,
@@ -206,30 +203,69 @@
 	outl(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
+/**
+ *	vt6420_prereset - prereset for vt6420
+ *	@ap: target ATA port
+ *
+ *	SCR registers on vt6420 are pieces of shit and may hang the
+ *	whole machine completely if accessed with the wrong timing.
+ *	To avoid such catastrophe, vt6420 doesn't provide generic SCR
+ *	access operations, but uses SStatus and SControl only during
+ *	boot probing in controlled way.
+ *
+ *	As the old (pre EH update) probing code is proven to work, we
+ *	strictly follow the access pattern.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
 static int vt6420_prereset(struct ata_port *ap)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	unsigned long timeout = jiffies + (HZ * 5);
-	u32 sstatus;
+	u32 sstatus, scontrol;
+	int online;
 
-	/* if we're about to do hardreset, nothing more to do */
-	if (ehc->i.action & ATA_EH_HARDRESET)
-		return 0;
+	/* don't do any SCR stuff if we're not loading */
+	if (!ATA_PFLAG_LOADING)
+		goto skip_scr;
 
-	/* Resume phy.  SCR registers in vt6420 are super-fragile and
-	 * can cause system lock up depending on how it's accessed.
-	 * Use the old resume sequence from __sata_phy_reset().
+	/* Resume phy.  This is the old resume sequence from
+	 * __sata_phy_reset().
 	 */
-	sata_scr_write_flush(ap, SCR_CONTROL, 0x300);
+	svia_scr_write(ap, SCR_CONTROL, 0x300);
+	svia_scr_read(ap, SCR_CONTROL); /* flush */
 
 	/* wait for phy to become ready, if necessary */
 	do {
 		msleep(200);
-		sata_scr_read(ap, SCR_STATUS, &sstatus);
-		if ((sstatus & 0xf) != 1)
+		if ((svia_scr_read(ap, SCR_STATUS) & 0xf) != 1)
 			break;
 	} while (time_before(jiffies, timeout));
 
+	/* open code sata_print_link_status() */
+	sstatus = svia_scr_read(ap, SCR_STATUS);
+	scontrol = svia_scr_read(ap, SCR_CONTROL);
+
+	online = (sstatus & 0xf) == 0x3;
+
+	ata_port_printk(ap, KERN_INFO,
+			"SATA link %s 1.5 Gbps (SStatus %X SControl %X)\n",
+			online ? "up" : "down", sstatus, scontrol);
+
+	/* SStatus is read one more time */
+	svia_scr_read(ap, SCR_STATUS);
+
+	if (!online) {
+		/* tell EH to bail */
+		ehc->i.action &= ~ATA_EH_RESET_MASK;
+		return 0;
+	}
+
+ skip_scr:
 	/* wait for !BSY */
 	ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
 
@@ -239,13 +275,13 @@
 static void vt6420_error_handler(struct ata_port *ap)
 {
 	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
-				  sata_std_hardreset, ata_std_postreset);
+				  NULL, ata_std_postreset);
 }
 
 static void vt6421_error_handler(struct ata_port *ap)
 {
-	return ata_bmdma_drive_eh(ap, ata_std_prereset, NULL,
-				  sata_std_hardreset, ata_std_postreset);
+	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
+				  NULL, ata_std_postreset);
 }
 
 static const unsigned int svia_bar_sizes[] = {

--=-=-=--
