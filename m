From: Tejun Heo <htejun@gmail.com>
Subject: Re: Hotplug drives on vt8251 with ahci module
Date: Fri, 23 Jun 2006 12:52:35 +0900
Message-ID: <449B6583.1090303@gmail.com>
References: <200606210942.33578.boac@wanadoo.nl> <44995139.30808@gmail.com> <200606221500.25056.boac@wanadoo.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040200090103070907080706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:59702 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751233AbWFWDw0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jun 2006 23:52:26 -0400
Received: by nz-out-0102.google.com with SMTP id l1so666004nzf
        for <linux-ide@vger.kernel.org>; Thu, 22 Jun 2006 20:52:25 -0700 (PDT)
In-Reply-To: <200606221500.25056.boac@wanadoo.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, boac@wanadoo.nl

This is a multi-part message in MIME format.
--------------040200090103070907080706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[CC'ing Bastiaan Jacques]

Hello, Aalderd.

Aalderd Bouwman wrote:
> The same turn on/off action with rmmod ahci will work properly I think:
> (I have test that action 3 times)

Great.

> As you see the disconnect of a drive is detected.
> Is the message: 'failed to recover some devices' correct?
> This message apears twice.

AFAICS, libata EH is behaving as expected.  The problem, again, is that 
more often than not, the via controller seems to lock up after certain 
events.  In the message you just posted, ata14 fails to recover after 
power-on.

Hmmm.. Looking at the log, it occurs to me that it might be because the 
controller can't receive D2H FIS after hardreset.  Can you try the 
attached patch?

Bastiaan, I'm shooting in the dark, so please don't hesitate to step in.

-- 
tejun

--------------040200090103070907080706
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index e261b37..fe12927 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -164,6 +164,7 @@ enum {
 
 	/* ap->flags bits */
 	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
+	AHCI_FLAG_NO_HRST_D2H_FIS	= (1 << 25),
 };
 
 struct ahci_cmd_hdr {
@@ -277,7 +278,8 @@ static const struct ata_port_info ahci_p
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_SKIP_D2H_BSY |
-				  AHCI_FLAG_RESET_NEEDS_CLO,
+				  AHCI_FLAG_RESET_NEEDS_CLO |
+				  AHCI_FLAG_NO_HRST_D2H_FIS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
@@ -703,14 +705,18 @@ static int ahci_hardreset(struct ata_por
 	tf.command = 0xff;
 	ata_tf_to_fis(&tf, d2h_fis, 0);
 
-	rc = sata_std_hardreset(ap, class);
-
-	ahci_start_engine(ap);
+	if (!(ap->flags & AHCI_FLAG_NO_HRST_D2H_FIS)) {
+		rc = sata_std_hardreset(ap, class);
+		ahci_start_engine(ap);
 
-	if (rc == 0 && ata_port_online(ap))
-		*class = ahci_dev_classify(ap);
-	if (*class == ATA_DEV_UNKNOWN)
-		*class = ATA_DEV_NONE;
+		if (rc == 0 && ata_port_online(ap))
+			*class = ahci_dev_classify(ap);
+		if (*class == ATA_DEV_UNKNOWN)
+			*class = ATA_DEV_NONE;
+	} else {
+		rc = sata_do_hardreset(ap);
+		ahci_start_engine(ap);
+	}
 
 	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 89c3fbe..9d6ed7e 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2517,6 +2517,46 @@ int sata_phy_resume(struct ata_port *ap,
 	return sata_phy_debounce(ap, params);
 }
 
+int sata_do_hardreset(struct ata_port *ap)
+{
+	u32 scontrol;
+	int rc;
+
+	if (sata_set_spd_needed(ap)) {
+		/* SATA spec says nothing about how to reconfigure
+		 * spd.  To be on the safe side, turn off phy during
+		 * reconfiguration.  This works for at least ICH7 AHCI
+		 * and Sil3124.
+		 */
+		if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
+			return rc;
+
+		scontrol = (scontrol & 0x0f0) | 0x302;
+
+		if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
+			return rc;
+
+		sata_set_spd(ap);
+	}
+
+	/* issue phy wake/reset */
+	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
+		return rc;
+
+	scontrol = (scontrol & 0x0f0) | 0x301;
+
+	if ((rc = sata_scr_write_flush(ap, SCR_CONTROL, scontrol)))
+		return rc;
+
+	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
+	 * 10.4.2 says at least 1 ms.
+	 */
+	msleep(1);
+
+	/* bring phy back */
+	return sata_phy_resume(ap, sata_deb_timing_eh);
+}
+
 static void ata_wait_spinup(struct ata_port *ap)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
@@ -2670,44 +2710,16 @@ int ata_std_softreset(struct ata_port *a
  */
 int sata_std_hardreset(struct ata_port *ap, unsigned int *class)
 {
-	u32 scontrol;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
-	if (sata_set_spd_needed(ap)) {
-		/* SATA spec says nothing about how to reconfigure
-		 * spd.  To be on the safe side, turn off phy during
-		 * reconfiguration.  This works for at least ICH7 AHCI
-		 * and Sil3124.
-		 */
-		if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
-			return rc;
-
-		scontrol = (scontrol & 0x0f0) | 0x302;
-
-		if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
-			return rc;
-
-		sata_set_spd(ap);
-	}
-
-	/* issue phy wake/reset */
-	if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
-		return rc;
-
-	scontrol = (scontrol & 0x0f0) | 0x301;
-
-	if ((rc = sata_scr_write_flush(ap, SCR_CONTROL, scontrol)))
+	/* reset the phy */
+	rc = sata_do_hardreset(ap);
+	if (rc) {
+		ata_port_printk(ap, KERN_ERR, "COMRESET failed (%d)\n", rc);
 		return rc;
-
-	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
-	 * 10.4.2 says at least 1 ms.
-	 */
-	msleep(1);
-
-	/* bring phy back */
-	sata_phy_resume(ap, sata_deb_timing_eh);
+	}
 
 	/* TODO: phy layer with polling, timeouts, etc. */
 	if (ata_port_offline(ap)) {
@@ -5833,6 +5845,7 @@ EXPORT_SYMBOL_GPL(sata_phy_resume);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
+EXPORT_SYMBOL_GPL(sata_do_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6b3c3af..533ed44 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -631,6 +631,7 @@ extern void ata_bus_reset(struct ata_por
 extern int sata_set_spd(struct ata_port *ap);
 extern int sata_phy_debounce(struct ata_port *ap, const unsigned long *param);
 extern int sata_phy_resume(struct ata_port *ap, const unsigned long *param);
+extern int sata_do_hardreset(struct ata_port *ap);
 extern int ata_std_prereset(struct ata_port *ap);
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
diff --git a/patches/series b/patches/series
index 9415c25..84b70e4 100644

--------------040200090103070907080706--
