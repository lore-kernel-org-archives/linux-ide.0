From: Tejun Heo <tj@kernel.org>
Subject: Re: Long delays while hibernating
Date: Fri, 25 Dec 2009 23:56:44 +0900
Message-ID: <4B34D2AC.8040908@kernel.org>
References: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com>	 <4B31CAF9.8070104@kernel.org>	 <74fd948d0912230550i639f7c05m9a6e5c9996479c01@mail.gmail.com>	 <4B331C16.4080901@kernel.org>	 <74fd948d0912240634h621de8b6l746470556da3eb7f@mail.gmail.com> <74fd948d0912240759n72e8c141y6b75f1ee7caadf60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080808000707090109050602"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36864 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754623AbZLYOyw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Dec 2009 09:54:52 -0500
In-Reply-To: <74fd948d0912240759n72e8c141y6b75f1ee7caadf60@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080808000707090109050602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 12/25/2009 12:59 AM, Pedro Ribeiro wrote:
> I just noticed that this patch is for ata_piix. I don't have this
> module loaded, as I have an ICH9 chip. The module used is ahci. Here
> is the output of lsmod:
> http://pastebin.com/m5468985b

Oh... Can you please try this one then?

Thanks.

-- 
tejun

--------------080808000707090109050602
Content-Type: text/x-patch;
 name="insomnia.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="insomnia.patch"

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b8bea10..dadf8b2 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2980,6 +2980,35 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 {}
 #endif
 
+#ifdef CONFIG_PM
+static void ahci_insomnia_workaround(struct ata_host *host)
+{
+	static const struct dmi_system_id sysids[] = {
+		{
+			.ident = "ThinkPad T400",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "7417PLU"),
+			},
+		},
+
+		{ }	/* terminate list */
+	};
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+
+	if (pdev->bus->number != 0 || pdev->devfn != PCI_DEVFN(0x1f, 2) ||
+	    !dmi_check_system(sysids))
+		return;
+
+	dev_printk(KERN_INFO, &pdev->dev, "BIOS may access controller "
+		   "after suspend, setting INSOMNIA\n");
+	host->flags |= ATA_HOST_INSOMNIA;
+}
+#else
+static inline void ahci_insomnia_workaround(struct ata_host *host)
+{}
+#endif
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -3156,6 +3185,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* apply gtf filter quirk */
 	ahci_gtf_filter_workaround(host);
 
+	/* need to set insomnia? */
+	ahci_insomnia_workaround(host);
+
 	/* initialize adapter */
 	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
 	if (rc)
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 19136a7..5ef948d 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -125,9 +125,6 @@ enum {
 	RV			= -3, /* reserved */
 
 	PIIX_AHCI_DEVICE	= 6,
-
-	/* host->flags bits */
-	PIIX_HOST_BROKEN_SUSPEND = (1 << 24),
 };
 
 enum piix_controller_ids {
@@ -173,10 +170,6 @@ static int piix_sidpr_scr_read(struct ata_link *link,
 			       unsigned int reg, u32 *val);
 static int piix_sidpr_scr_write(struct ata_link *link,
 				unsigned int reg, u32 val);
-#ifdef CONFIG_PM
-static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
-static int piix_pci_device_resume(struct pci_dev *pdev);
-#endif
 
 static unsigned int in_module_init = 1;
 
@@ -300,8 +293,8 @@ static struct pci_driver piix_pci_driver = {
 	.probe			= piix_init_one,
 	.remove			= piix_remove_one,
 #ifdef CONFIG_PM
-	.suspend		= piix_pci_device_suspend,
-	.resume			= piix_pci_device_resume,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
 #endif
 };
 
@@ -963,7 +956,7 @@ static int piix_sidpr_scr_write(struct ata_link *link,
 }
 
 #ifdef CONFIG_PM
-static int piix_broken_suspend(void)
+static void piix_insomnia_workaround(struct ata_host *host)
 {
 	static const struct dmi_system_id sysids[] = {
 		{
@@ -1091,14 +1084,15 @@ static int piix_broken_suspend(void)
 	static const char *oemstrs[] = {
 		"Tecra M3,",
 	};
+	struct pci_dev *pdev = to_pci_dev(host->dev);
 	int i;
 
 	if (dmi_check_system(sysids))
-		return 1;
+		goto apply;
 
 	for (i = 0; i < ARRAY_SIZE(oemstrs); i++)
 		if (dmi_find_device(DMI_DEV_TYPE_OEM_STRING, oemstrs[i], NULL))
-			return 1;
+			goto apply;
 
 	/* TECRA M4 sometimes forgets its identify and reports bogus
 	 * DMI information.  As the bogus information is a bit
@@ -1113,76 +1107,18 @@ static int piix_broken_suspend(void)
 	    dmi_match(DMI_BOARD_VENDOR, "TOSHIBA") &&
 	    dmi_match(DMI_BOARD_NAME, "Portable PC") &&
 	    dmi_match(DMI_BOARD_VERSION, "Version A0"))
-		return 1;
-
-	return 0;
-}
-
-static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	unsigned long flags;
-	int rc = 0;
-
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
-
-	/* Some braindamaged ACPI suspend implementations expect the
-	 * controller to be awake on entry; otherwise, it burns cpu
-	 * cycles and power trying to do something to the sleeping
-	 * beauty.
-	 */
-	if (piix_broken_suspend() && (mesg.event & PM_EVENT_SLEEP)) {
-		pci_save_state(pdev);
-
-		/* mark its power state as "unknown", since we don't
-		 * know if e.g. the BIOS will change its device state
-		 * when we suspend.
-		 */
-		if (pdev->current_state == PCI_D0)
-			pdev->current_state = PCI_UNKNOWN;
-
-		/* tell resume that it's waking up from broken suspend */
-		spin_lock_irqsave(&host->lock, flags);
-		host->flags |= PIIX_HOST_BROKEN_SUSPEND;
-		spin_unlock_irqrestore(&host->lock, flags);
-	} else
-		ata_pci_device_do_suspend(pdev, mesg);
-
-	return 0;
-}
-
-static int piix_pci_device_resume(struct pci_dev *pdev)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	unsigned long flags;
-	int rc;
-
-	if (host->flags & PIIX_HOST_BROKEN_SUSPEND) {
-		spin_lock_irqsave(&host->lock, flags);
-		host->flags &= ~PIIX_HOST_BROKEN_SUSPEND;
-		spin_unlock_irqrestore(&host->lock, flags);
-
-		pci_set_power_state(pdev, PCI_D0);
-		pci_restore_state(pdev);
+		goto apply;
 
-		/* PCI device wasn't disabled during suspend.  Use
-		 * pci_reenable_device() to avoid affecting the enable
-		 * count.
-		 */
-		rc = pci_reenable_device(pdev);
-		if (rc)
-			dev_printk(KERN_ERR, &pdev->dev, "failed to enable "
-				   "device after resume (%d)\n", rc);
-	} else
-		rc = ata_pci_device_do_resume(pdev);
+	return;
 
-	if (rc == 0)
-		ata_host_resume(host);
-
-	return rc;
+apply:
+	dev_printk(KERN_INFO, &pdev->dev, "BIOS may access controller "
+		   "after suspend, setting INSOMNIA\n");
+	host->flags |= ATA_HOST_INSOMNIA;
 }
+#else
+static inline void piix_insomnia_workaround(struct ata_host *host)
+{ }
 #endif
 
 static u8 piix_vmw_bmdma_status(struct ata_port *ap)
@@ -1604,6 +1540,9 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 		host->ports[1]->mwdma_mask = 0;
 		host->ports[1]->udma_mask = 0;
 	}
+
+	piix_insomnia_workaround(host);
+
 	host->flags |= ATA_HOST_PARALLEL_SCAN;
 
 	pci_set_master(pdev);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 22ff51b..3c7a1f3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6381,21 +6381,62 @@ int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
 #ifdef CONFIG_PM
 void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	unsigned long flags;
+
 	pci_save_state(pdev);
-	pci_disable_device(pdev);
 
-	if (mesg.event & PM_EVENT_SLEEP)
-		pci_set_power_state(pdev, PCI_D3hot);
+	/*
+	 * Some braindamaged ACPI suspend implementations expect the
+	 * controller to be awake on entry; otherwise, it burns cpu
+	 * cycles and power trying to do something to the sleeping
+	 * beauty.
+	 */
+	if ((host->flags & ATA_HOST_INSOMNIA) &&
+	    (mesg.event & PM_EVENT_SLEEP)) {
+		/*
+		 * Mark its power state as "unknown", since we don't
+		 * know if e.g. the BIOS will change its device state
+		 * when we suspend.
+		 */
+		if (pdev->current_state == PCI_D0)
+			pdev->current_state = PCI_UNKNOWN;
+
+		/* tell resume that it's waking up from insomnia */
+		spin_lock_irqsave(&host->lock, flags);
+		host->flags |= ATA_HOST_IN_INSOMNIA;
+		spin_unlock_irqrestore(&host->lock, flags);
+	} else {
+		pci_disable_device(pdev);
+
+		if (mesg.event & PM_EVENT_SLEEP)
+			pci_set_power_state(pdev, PCI_D3hot);
+	}
 }
 
 int ata_pci_device_do_resume(struct pci_dev *pdev)
 {
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	unsigned long flags;
 	int rc;
 
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 
-	rc = pcim_enable_device(pdev);
+	if (host->flags & ATA_HOST_IN_INSOMNIA) {
+		spin_lock_irqsave(&host->lock, flags);
+		host->flags &= ~ATA_HOST_IN_INSOMNIA;
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		/*
+		 * PCI device wasn't disabled during suspend.  Use
+		 * pci_reenable_device() to avoid affecting the enable
+		 * count.
+		 */
+		rc = pci_reenable_device(pdev);
+	} else
+		rc = pcim_enable_device(pdev);
+
 	if (rc) {
 		dev_printk(KERN_ERR, &pdev->dev,
 			   "failed to enable device after resume (%d)\n", rc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6a9c4dd..8b60fed 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -243,9 +243,11 @@ enum {
 	ATA_QCFLAG_EH_SCHEDULED = (1 << 18), /* EH scheduled (obsolete) */
 
 	/* host set flags */
-	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host only */
-	ATA_HOST_STARTED	= (1 << 1),	/* Host started */
-	ATA_HOST_PARALLEL_SCAN	= (1 << 2),	/* Ports on this host can be scanned in parallel */
+	ATA_HOST_SIMPLEX	= (1 << 0), /* Host is simplex, one DMA channel per host only */
+	ATA_HOST_STARTED	= (1 << 1), /* Host started */
+	ATA_HOST_PARALLEL_SCAN	= (1 << 2), /* Ports on this host can be scanned in parallel */
+	ATA_HOST_INSOMNIA	= (1 << 3), /* Don't power down on suspend */
+	ATA_HOST_IN_INSOMNIA	= (1 << 4), /* Insomnia in progress */
 
 	/* bits 24:31 of host->flags are reserved for LLD specific flags */
 

--------------080808000707090109050602--
