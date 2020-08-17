Return-Path: <SRS0=rcVg=B3=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A04FC433DF
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 09:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A42A2072D
	for <linux-ide@archiver.kernel.org>; Mon, 17 Aug 2020 09:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYPufWNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHQJZB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgHQJY6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Aug 2020 05:24:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726FAC061389;
        Mon, 17 Aug 2020 02:24:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e4so7533863pjd.0;
        Mon, 17 Aug 2020 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qDU7evRHorEkBFC6YMyW9dsgR5ISEayX5tN2gn+nLmw=;
        b=OYPufWNcy92dfiCZ/5mX2l32e/6c3c5UVRrUYIM4U5kN+JGZs2GKL0nAcZrAQFnEKD
         dQKj1GaWA/Oy7xlf1l/h6yX1eGLSZLRVTzFjDcK/ZJ5MGtDxkPkui+tq/AD3HdoecZ/K
         pUyt4GwtzqJkSpb159krG3lQST3HqpFLrGZDghiGw4ngPkEmkgRrjrth6CHh6kMGJptR
         Tw3Fb2a446KG1hB7WkwSIgUlIJr8PMT7c4X0inpz3pRNSt981IdvsYrI2FY69oucDNAZ
         UifG+B8XIv21dVEoBZMN0Z3CreTGxWjz2dwIlaT4DjJyZq1GHVwGl31Y7FIpHGGFXfa6
         QpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qDU7evRHorEkBFC6YMyW9dsgR5ISEayX5tN2gn+nLmw=;
        b=RUhroLvyvMe39UBSxGib41+iCZzTAc3uSu3IjvfJopJiNVHONwCq/lbn6k9qxdwVro
         SD+GqoHTSObVsmNSjWPuQLR6SW3LtDDRJUIawrtwwETvGFAf0ce5EZdz0KR0ins35SSX
         BQfrSjma3nj3ygpL6oyB9A69aKAITKJFHrKJGoZRRuFmyjkM+9s/tzgHyambAgw0lKXL
         lTq8jzW7brT7x2QC0W3Qo64YzZq66YZCCZypl8HsuPUEWMrX/hJnt4N0E/UG5/3pXEJo
         JvgkVUbv3AlanHQ5oasxczRcFRBL56iFN9SdC34aOHNloVJ+gFeWvaRYui7z9Q9L2PjK
         bILA==
X-Gm-Message-State: AOAM530PyL1QVnprpzddvD9zq5lAWQ3LF7t0q3OcV/5Bl1M20q0bw8Si
        tNnHLfKf3JlsM1S5ICh8XnU=
X-Google-Smtp-Source: ABdhPJx2J/hl1yIYBswMVsSrAny/YRpcB8IU5H1dvjE4G/1ZBG44F6PNc11UvmzcLBxSTlMEZVkCLw==
X-Received: by 2002:a17:902:8c8a:: with SMTP id t10mr10498783plo.112.1597656297387;
        Mon, 17 Aug 2020 02:24:57 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o10sm16593830pjo.55.2020.08.17.02.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:24:56 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Slaby <jslaby@suse.cz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3] ata: use generic power management
Date:   Mon, 17 Aug 2020 14:52:45 +0530
Message-Id: <20200817092245.10478-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Drivers should do only device-specific jobs. But in general, drivers using
legacy PCI PM framework for .suspend()/.resume() have to manage many PCI
PM-related tasks themselves which can be done by PCI Core itself. This
brings extra load on the driver and it directly calls PCI helper functions
to handle them.

Switch to the new generic framework by updating function signatures and
define a "struct dev_pm_ops" variable to bind PM callbacks. Also, remove
unnecessary calls to the PCI Helper functions along with the legacy
.suspend & .resume bindings.

The ata_pci_device_suspend() and ata_pci_device_resume(), declared in
include/linux/libata.h and defined in drivers/ata/libata-core.c, are
external and were exported. Those were then used by other source files.

Now,
- ata_pci_device_suspend() had a "pm_message_t" type parameter
  as per legacy PCI PM framework that got deprecated in generic.
- Rename the callback as ata_pci_device_suspend_late() and preserve the
  parameter.
- Define 3 new callbacks as:
	* ata_pci_device_suspend()
	* ata_pci_device_freeze()
	* ata_pci_device_hibernate()
  which in turn call ata_pci_device_suspend_late() by passing appropriate
  value for "pm_message_t" type parameter.
- Bind the callbacks in "struct dev_pm_ops" type variable
  "ata_pci_device_pm_ops" and export it.

There are 2 categories of drivers using include/linux/libata.h, with
special case:
	1) - Using ata_pci_device_suspend/resume()
	2) - Using ata_pci_device_suspend() and define their own .resume()

Category 1 - Simply use "ata_pci_device_pm_ops" variable.
Category 2 - Define a new macro "ATA_SIMPLE_DEV_PM_OPS" in
	     include/linux/libata.h which binds:
		* ata_pci_device_suspend() with .suspend
		* ata_pci_device_freeze() with .freeze
		* ata_pci_device-hibernate() with .poweroff
	     and driver's callback with .resume, .thaw & .restore

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/ata/acard-ahci.c        | 63 ++++++++++++++++++---------
 drivers/ata/ata_generic.c       |  5 +--
 drivers/ata/ata_piix.c          | 69 +++++++++++++++---------------
 drivers/ata/libata-core.c       | 75 +++++++++++++++------------------
 drivers/ata/pata_acpi.c         |  5 +--
 drivers/ata/pata_ali.c          | 19 +++------
 drivers/ata/pata_amd.c          | 17 +++-----
 drivers/ata/pata_artop.c        | 20 +++------
 drivers/ata/pata_atiixp.c       |  5 +--
 drivers/ata/pata_atp867x.c      | 18 +++-----
 drivers/ata/pata_cmd640.c       | 19 +++------
 drivers/ata/pata_cmd64x.c       | 20 +++------
 drivers/ata/pata_cs5520.c       | 41 +++---------------
 drivers/ata/pata_cs5530.c       | 18 +++-----
 drivers/ata/pata_cs5535.c       |  5 +--
 drivers/ata/pata_cs5536.c       |  5 +--
 drivers/ata/pata_cypress.c      |  5 +--
 drivers/ata/pata_efar.c         |  5 +--
 drivers/ata/pata_hpt366.c       | 19 +++------
 drivers/ata/pata_hpt3x3.c       | 20 +++------
 drivers/ata/pata_it8213.c       |  5 +--
 drivers/ata/pata_it821x.c       | 22 +++-------
 drivers/ata/pata_jmicron.c      |  5 +--
 drivers/ata/pata_marvell.c      |  5 +--
 drivers/ata/pata_mpiix.c        |  5 +--
 drivers/ata/pata_netcell.c      |  5 +--
 drivers/ata/pata_ninja32.c      | 17 +++-----
 drivers/ata/pata_ns87410.c      |  5 +--
 drivers/ata/pata_ns87415.c      | 20 +++------
 drivers/ata/pata_oldpiix.c      |  5 +--
 drivers/ata/pata_opti.c         |  5 +--
 drivers/ata/pata_optidma.c      |  5 +--
 drivers/ata/pata_pdc2027x.c     | 21 +++------
 drivers/ata/pata_pdc202xx_old.c |  5 +--
 drivers/ata/pata_piccolo.c      |  5 +--
 drivers/ata/pata_radisys.c      |  5 +--
 drivers/ata/pata_rdc.c          |  5 +--
 drivers/ata/pata_rz1000.c       | 20 +++------
 drivers/ata/pata_sc1200.c       |  5 +--
 drivers/ata/pata_sch.c          |  5 +--
 drivers/ata/pata_serverworks.c  | 20 +++------
 drivers/ata/pata_sil680.c       | 20 +++------
 drivers/ata/pata_sis.c          | 20 +++------
 drivers/ata/pata_sl82c105.c     | 20 +++------
 drivers/ata/pata_triflex.c      | 33 ++++-----------
 drivers/ata/pata_via.c          | 22 +++-------
 drivers/ata/sata_inic162x.c     | 16 +++----
 drivers/ata/sata_mv.c           | 21 +++------
 drivers/ata/sata_nv.c           | 21 +++------
 drivers/ata/sata_sil.c          | 22 +++-------
 drivers/ata/sata_sil24.c        | 21 +++------
 drivers/ata/sata_sis.c          |  5 +--
 drivers/ata/sata_via.c          | 24 +++--------
 include/linux/libata.h          | 32 +++++++++++---
 54 files changed, 321 insertions(+), 604 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 2a04e8abd397..34eafabe7e49 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -61,10 +61,11 @@ static bool acard_ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
 static int acard_ahci_port_start(struct ata_port *ap);
 static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 
-#ifdef CONFIG_PM_SLEEP
-static int acard_ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
-static int acard_ahci_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int acard_ahci_pci_device_suspend_late(struct device *dev, pm_message_t mesg);
+static int __maybe_unused acard_ahci_pci_device_suspend(struct device *dev);
+static int __maybe_unused acard_ahci_pci_device_hibernate(struct device *dev);
+static int __maybe_unused acard_ahci_pci_device_freeze(struct device *dev);
+static int __maybe_unused acard_ahci_pci_device_resume(struct device *dev);
 
 static struct scsi_host_template acard_ahci_sht = {
 	AHCI_SHT("acard-ahci"),
@@ -97,28 +98,35 @@ static const struct pci_device_id acard_ahci_pci_tbl[] = {
 	{ }    /* terminate list */
 };
 
+static const struct dev_pm_ops acard_ahci_pci_device_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= acard_ahci_pci_device_suspend,
+	.resume		= acard_ahci_pci_device_resume,
+	.freeze		= acard_ahci_pci_device_freeze,
+	.thaw		= acard_ahci_pci_device_resume,
+	.poweroff	= acard_ahci_pci_device_hibernate,
+	.restore	= acard_ahci_pci_device_resume,
+#endif
+};
+
 static struct pci_driver acard_ahci_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= acard_ahci_pci_tbl,
 	.probe			= acard_ahci_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= acard_ahci_pci_device_suspend,
-	.resume			= acard_ahci_pci_device_resume,
-#endif
+	.driver.pm		= &acard_ahci_pci_device_pm_ops,
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int acard_ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int acard_ahci_pci_device_suspend_late(struct device *dev, pm_message_t mesg)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	u32 ctl;
 
 	if (mesg.event & PM_EVENT_SUSPEND &&
 	    hpriv->flags & AHCI_HFLAG_NO_SUSPEND) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"BIOS update required for suspend/resume\n");
 		return -EIO;
 	}
@@ -134,19 +142,33 @@ static int acard_ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg
 		readl(mmio + HOST_CTL); /* flush */
 	}
 
-	return ata_pci_device_suspend(pdev, mesg);
+	return 0;
 }
 
-static int acard_ahci_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused acard_ahci_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	acard_ahci_pci_device_suspend_late(dev, PMSG_SUSPEND);
+	return ata_pci_device_suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused acard_ahci_pci_device_hibernate(struct device *dev)
+{
+	acard_ahci_pci_device_suspend_late(dev, PMSG_HIBERNATE);
+	return ata_pci_device_hibernate(dev);
+}
 
-	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
+static int __maybe_unused acard_ahci_pci_device_freeze(struct device *dev)
+{
+	acard_ahci_pci_device_suspend_late(dev, PMSG_FREEZE);
+	return ata_pci_device_freeze(dev);
+}
+
+static int __maybe_unused acard_ahci_pci_device_resume(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	int rc;
+
+	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_reset_controller(host);
 		if (rc)
 			return rc;
@@ -158,7 +180,6 @@ static int acard_ahci_pci_device_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#endif
 
 static void acard_ahci_pci_print_info(struct ata_host *host)
 {
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 9ff545ce8da3..7e50f51d447a 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -241,10 +241,7 @@ static struct pci_driver ata_generic_pci_driver = {
 	.id_table	= ata_generic,
 	.probe 		= ata_generic_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(ata_generic_pci_driver);
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 3ca7720e7d8f..288c772b4855 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -822,8 +822,7 @@ static bool piix_irq_check(struct ata_port *ap)
 	return ap->ops->bmdma_status(ap) & ATA_DMA_INTR;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int piix_broken_suspend(void)
+static int __maybe_unused piix_broken_suspend(void)
 {
 	static const struct dmi_system_id sysids[] = {
 		{
@@ -983,8 +982,9 @@ static int piix_broken_suspend(void)
 	return 0;
 }
 
-static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int piix_pci_device_suspend_late(struct device *dev, pm_message_t mesg)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ata_host *host = pci_get_drvdata(pdev);
 	unsigned long flags;
 	int rc = 0;
@@ -999,8 +999,6 @@ static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	 * beauty.
 	 */
 	if (piix_broken_suspend() && (mesg.event & PM_EVENT_SLEEP)) {
-		pci_save_state(pdev);
-
 		/* mark its power state as "unknown", since we don't
 		 * know if e.g. the BIOS will change its device state
 		 * when we suspend.
@@ -1012,44 +1010,41 @@ static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 		spin_lock_irqsave(&host->lock, flags);
 		host->flags |= PIIX_HOST_BROKEN_SUSPEND;
 		spin_unlock_irqrestore(&host->lock, flags);
-	} else
-		ata_pci_device_do_suspend(pdev, mesg);
+	}
 
 	return 0;
 }
 
-static int piix_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused piix_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
+	return piix_pci_device_suspend_late(dev, PMSG_SUSPEND);
+}
+
+static int __maybe_unused piix_pci_device_hibernate(struct device *dev)
+{
+	return piix_pci_device_suspend_late(dev, PMSG_HIBERNATE);
+}
+
+static int __maybe_unused piix_pci_device_freeze(struct device *dev)
+{
+	return piix_pci_device_suspend_late(dev, PMSG_FREEZE);
+}
+
+static int __maybe_unused piix_pci_device_resume(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 	unsigned long flags;
-	int rc;
 
 	if (host->flags & PIIX_HOST_BROKEN_SUSPEND) {
 		spin_lock_irqsave(&host->lock, flags);
 		host->flags &= ~PIIX_HOST_BROKEN_SUSPEND;
 		spin_unlock_irqrestore(&host->lock, flags);
+	}
 
-		pci_set_power_state(pdev, PCI_D0);
-		pci_restore_state(pdev);
-
-		/* PCI device wasn't disabled during suspend.  Use
-		 * pci_reenable_device() to avoid affecting the enable
-		 * count.
-		 */
-		rc = pci_reenable_device(pdev);
-		if (rc)
-			dev_err(&pdev->dev,
-				"failed to enable device after resume (%d)\n",
-				rc);
-	} else
-		rc = ata_pci_device_do_resume(pdev);
-
-	if (rc == 0)
-		ata_host_resume(host);
+	ata_host_resume(host);
 
-	return rc;
+	return 0;
 }
-#endif
 
 static u8 piix_vmw_bmdma_status(struct ata_port *ap)
 {
@@ -1752,15 +1747,23 @@ static void piix_remove_one(struct pci_dev *pdev)
 	ata_pci_remove_one(pdev);
 }
 
+static const struct dev_pm_ops piix_pci_device_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= piix_pci_device_suspend,
+	.resume		= piix_pci_device_resume,
+	.freeze		= piix_pci_device_freeze,
+	.thaw		= piix_pci_device_resume,
+	.poweroff	= piix_pci_device_hibernate,
+	.restore	= piix_pci_device_resume,
+#endif
+};
+
 static struct pci_driver piix_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= piix_pci_tbl,
 	.probe			= piix_init_one,
 	.remove			= piix_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= piix_pci_device_suspend,
-	.resume			= piix_pci_device_resume,
-#endif
+	.driver.pm		= &piix_pci_device_pm_ops,
 };
 
 static int __init piix_init(void)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b1cd4d97bc2a..39782a441968 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5097,6 +5097,7 @@ void ata_sas_port_resume(struct ata_port *ap)
 	ata_port_resume_async(ap, PMSG_RESUME);
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_resume);
+#endif
 
 /**
  *	ata_host_suspend - suspend host
@@ -5123,7 +5124,6 @@ void ata_host_resume(struct ata_host *host)
 	host->dev->power.power_state = PMSG_ON;
 }
 EXPORT_SYMBOL_GPL(ata_host_resume);
-#endif
 
 const struct device_type ata_port_type = {
 	.name = "ata_port",
@@ -6007,63 +6007,54 @@ int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
 }
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
 
-#ifdef CONFIG_PM
-void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int ata_pci_device_suspend_late(struct device *dev, pm_message_t mesg)
 {
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	if (mesg.event & PM_EVENT_SLEEP)
-		pci_set_power_state(pdev, PCI_D3hot);
+	return ata_host_suspend(host, mesg);
 }
-EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
 
-int ata_pci_device_do_resume(struct pci_dev *pdev)
+int ata_pci_device_suspend(struct device *dev)
 {
-	int rc;
-
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
-	rc = pcim_enable_device(pdev);
-	if (rc) {
-		dev_err(&pdev->dev,
-			"failed to enable device after resume (%d)\n", rc);
-		return rc;
-	}
-
-	pci_set_master(pdev);
-	return 0;
+	return ata_pci_device_suspend_late(dev, PMSG_SUSPEND);
 }
-EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
+EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 
-int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
-{
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc = 0;
 
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
+int ata_pci_device_hibernate(struct device *dev)
+{
+	return ata_pci_device_suspend_late(dev, PMSG_HIBERNATE);
+}
+EXPORT_SYMBOL_GPL(ata_pci_device_hibernate);
 
-	ata_pci_device_do_suspend(pdev, mesg);
 
-	return 0;
+int ata_pci_device_freeze(struct device *dev)
+{
+	return ata_pci_device_suspend_late(dev, PMSG_FREEZE);
 }
-EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
+EXPORT_SYMBOL_GPL(ata_pci_device_freeze);
 
-int ata_pci_device_resume(struct pci_dev *pdev)
+int ata_pci_device_resume(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc == 0)
-		ata_host_resume(host);
-	return rc;
+	ata_host_resume(host);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_pci_device_resume);
-#endif /* CONFIG_PM */
+
+const struct dev_pm_ops ata_pci_device_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ata_pci_device_resume,
+	.freeze		= ata_pci_device_freeze,
+	.thaw		= ata_pci_device_resume,
+	.poweroff	= ata_pci_device_hibernate,
+	.restore	= ata_pci_device_resume,
+#endif
+};
+EXPORT_SYMBOL_GPL(ata_pci_device_pm_ops);
+
 #endif /* CONFIG_PCI */
 
 /**
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index fa2bfc344a97..2a9b4a6df80f 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -266,10 +266,7 @@ static struct pci_driver pacpi_pci_driver = {
 	.id_table		= pacpi_pci_tbl,
 	.probe			= pacpi_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(pacpi_pci_driver);
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 0b122f903b8a..0bb937f6ae90 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -590,20 +590,14 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ata_pci_bmdma_init_one(pdev, ppi, &ali_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ali_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused ali_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-	ali_init_chipset(pdev);
+	ali_init_chipset(to_pci_dev(dev));
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id ali[] = {
 	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5228), },
@@ -612,15 +606,14 @@ static const struct pci_device_id ali[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(ali_pci_device_pm_ops, ali_reinit_one);
+
 static struct pci_driver ali_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= ali,
 	.probe 		= ali_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ali_reinit_one,
-#endif
+	.driver.pm	= &ali_pci_device_pm_ops,
 };
 
 static int __init ali_init(void)
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 987967f976cb..1d14f90e593d 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -575,15 +575,10 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &amd_sht, hpriv, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int amd_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused amd_reinit_one(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
 		amd_clear_fifo(pdev);
@@ -594,7 +589,6 @@ static int amd_reinit_one(struct pci_dev *pdev)
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id amd[] = {
 	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_COBRA_7401),		0 },
@@ -622,15 +616,14 @@ static const struct pci_device_id amd[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(amd_pci_device_pm_ops, amd_reinit_one);
+
 static struct pci_driver amd_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= amd,
 	.probe 		= amd_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= amd_reinit_one,
-#endif
+	.driver.pm	= &amd_pci_device_pm_ops,
 };
 
 module_pci_driver(amd_pci_driver);
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 6bd2228bb6ff..eb58001d0d53 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -423,32 +423,24 @@ static const struct pci_device_id artop_pci_tbl[] = {
 	{ }	/* terminate list */
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int atp8xx_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused atp8xx_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	atp8xx_fixup(pdev);
+	atp8xx_fixup(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
+
+static ATA_SIMPLE_DEV_PM_OPS(atp8xx_pci_device_pm_ops, atp8xx_reinit_one);
 
 static struct pci_driver artop_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= artop_pci_tbl,
 	.probe			= artop_init_one,
+	.driver.pm		= &atp8xx_pci_device_pm_ops,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= atp8xx_reinit_one,
-#endif
 };
 
 module_pci_driver(artop_pci_driver);
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index c68aa3f585f2..1c6caf97e3b3 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -303,10 +303,7 @@ static struct pci_driver atiixp_pci_driver = {
 	.id_table	= atiixp,
 	.probe 		= atiixp_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.resume		= ata_pci_device_resume,
-	.suspend	= ata_pci_device_suspend,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(atiixp_pci_driver);
diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index e01a3a6e4d46..cc2092638379 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -513,22 +513,15 @@ static int atp867x_init_one(struct pci_dev *pdev,
 	return rc;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int atp867x_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused atp867x_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
 	atp867x_fixup(host);
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static struct pci_device_id atp867x_pci_tbl[] = {
 	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867A),	0 },
@@ -536,15 +529,14 @@ static struct pci_device_id atp867x_pci_tbl[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(atp867x_pci_device_pm_ops, atp867x_reinit_one);
+
 static struct pci_driver atp867x_driver = {
 	.name 		= DRV_NAME,
 	.id_table 	= atp867x_pci_tbl,
 	.probe 		= atp867x_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= atp867x_reinit_one,
-#endif
+	.driver.pm	= &atp867x_pci_device_pm_ops,
 };
 
 module_pci_driver(atp867x_driver);
diff --git a/drivers/ata/pata_cmd640.c b/drivers/ata/pata_cmd640.c
index d0bcabb58b44..c79ad34c8936 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -232,35 +232,28 @@ static int cmd640_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_sff_init_one(pdev, ppi, &cmd640_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cmd640_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused cmd640_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-	cmd640_hardware_init(pdev);
+	cmd640_hardware_init(to_pci_dev(dev));
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id cmd640[] = {
 	{ PCI_VDEVICE(CMD, 0x640), 0 },
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(cmd640_pci_device_pm_ops, cmd640_reinit_one);
+
 static struct pci_driver cmd640_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= cmd640,
 	.probe 		= cmd640_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= cmd640_reinit_one,
-#endif
+	.driver.pm	= &cmd640_pci_device_pm_ops,
 };
 
 module_pci_driver(cmd640_pci_driver);
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index 3134eaec9e3d..1c02987d2d47 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -488,22 +488,15 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &cmd64x_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cmd64x_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused cmd64x_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	cmd64x_fixup(pdev);
+	cmd64x_fixup(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id cmd64x[] = {
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), 0 },
@@ -514,15 +507,14 @@ static const struct pci_device_id cmd64x[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(cmd64x_pci_device_pm_ops, cmd64x_reinit_one);
+
 static struct pci_driver cmd64x_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= cmd64x,
 	.probe 		= cmd64x_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= cmd64x_reinit_one,
-#endif
+	.driver.pm	= &cmd64x_pci_device_pm_ops,
 };
 
 module_pci_driver(cmd64x_pci_driver);
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 9052148b306d..28d8a7658b17 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -216,24 +216,19 @@ static int cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_host_register(host, &cs5520_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
 /**
  *	cs5520_reinit_one	-	device resume
- *	@pdev: PCI device
+ *	@dev: Device
  *
  *	Do any reconfiguration work needed by a resume from RAM. We need
  *	to restore DMA mode support on BIOSen which disabled it
  */
 
-static int cs5520_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused cs5520_reinit_one(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ata_host *host = pci_get_drvdata(pdev);
 	u8 pcicfg;
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
 
 	pci_read_config_byte(pdev, 0x60, &pcicfg);
 	if ((pcicfg & 0x40) == 0)
@@ -243,29 +238,6 @@ static int cs5520_reinit_one(struct pci_dev *pdev)
 	return 0;
 }
 
-/**
- *	cs5520_pci_device_suspend	-	device suspend
- *	@pdev: PCI device
- *
- *	We have to cut and waste bits from the standard method because
- *	the 5520 is a bit odd and not just a pure ATA device. As a result
- *	we must not disable it. The needed code is short and this avoids
- *	chip specific mess in the core code.
- */
-
-static int cs5520_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
-{
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc = 0;
-
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
-
-	pci_save_state(pdev);
-	return 0;
-}
-#endif /* CONFIG_PM_SLEEP */
 
 /* For now keep DMA off. We can set it for all but A rev CS5510 once the
    core ATA code can handle it */
@@ -277,15 +249,14 @@ static const struct pci_device_id pata_cs5520[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(cs5520_pci_device_pm_ops, cs5520_reinit_one);
+
 static struct pci_driver cs5520_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= pata_cs5520,
 	.probe 		= cs5520_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= cs5520_pci_device_suspend,
-	.resume		= cs5520_reinit_one,
-#endif
+	.driver.pm	= &cs5520_pci_device_pm_ops,
 };
 
 module_pci_driver(cs5520_pci_driver);
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index ad75d02b6dac..aa2fc6ad7533 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -312,15 +312,9 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &cs5530_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cs5530_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused cs5530_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
 	/* If we fail on resume we are doomed */
 	if (cs5530_init_chip())
@@ -329,7 +323,6 @@ static int cs5530_reinit_one(struct pci_dev *pdev)
 	ata_host_resume(host);
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct pci_device_id cs5530[] = {
 	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE), },
@@ -337,15 +330,14 @@ static const struct pci_device_id cs5530[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(cs5530_pci_device_pm_ops, cs5530_reinit_one);
+
 static struct pci_driver cs5530_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= cs5530,
 	.probe 		= cs5530_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= cs5530_reinit_one,
-#endif
+	.driver.pm	= &cs5530_pci_device_pm_ops,
 };
 
 module_pci_driver(cs5530_pci_driver);
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 6725931f3c35..caa682eecbb4 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -188,10 +188,7 @@ static struct pci_driver cs5535_pci_driver = {
 	.id_table	= cs5535,
 	.probe 		= cs5535_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(cs5535_pci_driver);
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 760ac6e65216..dfda7b27a299 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -286,10 +286,7 @@ static struct pci_driver cs5536_pci_driver = {
 	.id_table	= cs5536,
 	.probe		= cs5536_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(cs5536_pci_driver);
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index e1486fe298ae..b1e4eea14e92 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -152,10 +152,7 @@ static struct pci_driver cy82c693_pci_driver = {
 	.id_table	= cy82c693,
 	.probe 		= cy82c693_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(cy82c693_pci_driver);
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index 21da59f35b41..ada56cb1bff1 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -289,10 +289,7 @@ static struct pci_driver efar_pci_driver = {
 	.id_table		= efar_pci_tbl,
 	.probe			= efar_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(efar_pci_driver);
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 2574d6fbb1ad..556110998787 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -384,35 +384,28 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(dev, ppi, &hpt36x_sht, (void *)hpriv, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int hpt36x_reinit_one(struct pci_dev *dev)
+static int __maybe_unused hpt36x_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(dev);
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_pci_device_do_resume(dev);
-	if (rc)
-		return rc;
-	hpt36x_init_chipset(dev);
+	hpt36x_init_chipset(to_pci_dev(dev));
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id hpt36x[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366), },
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(hpt36x_pci_device_pm_ops, hpt36x_reinit_one);
+
 static struct pci_driver hpt36x_pci_driver = {
 	.name		= DRV_NAME,
 	.id_table	= hpt36x,
 	.probe		= hpt36x_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= hpt36x_reinit_one,
-#endif
+	.driver.pm	= &hpt36x_pci_device_pm_ops,
 };
 
 module_pci_driver(hpt36x_pci_driver);
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 83974d5eb387..66e16db0d07e 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -246,22 +246,15 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 				 IRQF_SHARED, &hpt3x3_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int hpt3x3_reinit_one(struct pci_dev *dev)
+static int __maybe_unused hpt3x3_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(dev);
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_pci_device_do_resume(dev);
-	if (rc)
-		return rc;
-
-	hpt3x3_init_chipset(dev);
+	hpt3x3_init_chipset(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id hpt3x3[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT343), },
@@ -269,15 +262,14 @@ static const struct pci_device_id hpt3x3[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(hpt3x3_pci_device_pm_ops, hpt3x3_reinit_one);
+
 static struct pci_driver hpt3x3_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= hpt3x3,
 	.probe 		= hpt3x3_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= hpt3x3_reinit_one,
-#endif
+	.driver.pm	= &hpt3x3_pci_device_pm_ops,
 };
 
 module_pci_driver(hpt3x3_pci_driver);
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
index 8a3e8778163c..620bac68db72 100644
--- a/drivers/ata/pata_it8213.c
+++ b/drivers/ata/pata_it8213.c
@@ -284,10 +284,7 @@ static struct pci_driver it8213_pci_driver = {
 	.id_table		= it8213_pci_tbl,
 	.probe			= it8213_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(it8213_pci_driver);
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 9bac79edbc2c..a8ccf67b6628 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -935,22 +935,15 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &it821x_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int it821x_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused it821x_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 	/* Resume - turn raid back off if need be */
 	if (it8212_noraid)
-		it821x_disable_raid(pdev);
+		it821x_disable_raid(to_pci_dev(dev));
 	ata_host_resume(host);
-	return rc;
+	return 0;
 }
-#endif
 
 static const struct pci_device_id it821x[] = {
 	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8211), },
@@ -960,15 +953,14 @@ static const struct pci_device_id it821x[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(it821x_pci_device_pm_ops, it821x_reinit_one);
+
 static struct pci_driver it821x_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= it821x,
 	.probe 		= it821x_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= it821x_reinit_one,
-#endif
+	.driver.pm	= &it821x_pci_device_pm_ops,
 };
 
 module_pci_driver(it821x_pci_driver);
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index c3dedd3e71fb..e637758b0f5c 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -158,10 +158,7 @@ static struct pci_driver jmicron_pci_driver = {
 	.id_table		= jmicron_pci_tbl,
 	.probe			= jmicron_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(jmicron_pci_driver);
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index b066809ba9a1..d3ed9beb231f 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -172,10 +172,7 @@ static struct pci_driver marvell_pci_driver = {
 	.id_table		= marvell_pci_tbl,
 	.probe			= marvell_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(marvell_pci_driver);
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 8fda0e32c1ab..58240e638e57 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -224,10 +224,7 @@ static struct pci_driver mpiix_pci_driver = {
 	.id_table	= mpiix,
 	.probe 		= mpiix_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(mpiix_pci_driver);
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index a7ecc1a204b5..fdd323a6c681 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -93,10 +93,7 @@ static struct pci_driver netcell_pci_driver = {
 	.id_table		= netcell_pci_tbl,
 	.probe			= netcell_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(netcell_pci_driver);
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index f9255d6fd194..f66124de9bb0 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -150,20 +150,14 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 				 IRQF_SHARED, &ninja32_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ninja32_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused ninja32_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
 	ninja32_program(host->iomap[0]);
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id ninja32[] = {
 	{ 0x10FC, 0x0003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
@@ -175,15 +169,14 @@ static const struct pci_device_id ninja32[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(ninja32_pci_device_pm_ops, ninja32_reinit_one);
+
 static struct pci_driver ninja32_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= ninja32,
 	.probe 		= ninja32_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ninja32_reinit_one,
-#endif
+	.driver.pm	= &ninja32_pci_device_pm_ops,
 };
 
 module_pci_driver(ninja32_pci_driver);
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index ca3ab2736fef..f3fdb00deb58 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -148,10 +148,7 @@ static struct pci_driver ns87410_pci_driver = {
 	.id_table	= ns87410,
 	.probe 		= ns87410_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(ns87410_pci_driver);
diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 4b2ba813dcab..3ac583dabd72 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -386,32 +386,24 @@ static const struct pci_device_id ns87415_pci_tbl[] = {
 	{ }	/* terminate list */
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int ns87415_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused ns87415_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	ns87415_fixup(pdev);
+	ns87415_fixup(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
+
+static ATA_SIMPLE_DEV_PM_OPS(ns87415_pci_device_pm_ops, ns87415_reinit_one);
 
 static struct pci_driver ns87415_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= ns87415_pci_tbl,
 	.probe			= ns87415_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ns87415_reinit_one,
-#endif
+	.driver.pm		= &ns87415_pci_device_pm_ops,
 };
 
 module_pci_driver(ns87415_pci_driver);
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 22a020374410..cf3ff2daf47e 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -259,10 +259,7 @@ static struct pci_driver oldpiix_pci_driver = {
 	.id_table		= oldpiix_pci_tbl,
 	.probe			= oldpiix_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(oldpiix_pci_driver);
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index 06a800a3b070..7efb3abf9f4c 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -185,10 +185,7 @@ static struct pci_driver opti_pci_driver = {
 	.id_table	= opti,
 	.probe 		= opti_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(opti_pci_driver);
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index fbcf0af34924..56193225c20a 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -441,10 +441,7 @@ static struct pci_driver optidma_pci_driver = {
 	.id_table	= optidma,
 	.probe 		= optidma_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(optidma_pci_driver);
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index de834fbb6dfe..c539ba192808 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -57,9 +57,7 @@ enum {
 };
 
 static int pdc2027x_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int pdc2027x_reinit_one(struct pci_dev *pdev);
-#endif
+static int __maybe_unused pdc2027x_reinit_one(struct device *dev);
 static int pdc2027x_prereset(struct ata_link *link, unsigned long deadline);
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
@@ -118,15 +116,14 @@ static const struct pci_device_id pdc2027x_pci_tbl[] = {
 	{ }	/* terminate list */
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(pdc2027x_pci_device_pm_ops, pdc2027x_reinit_one);
+
 static struct pci_driver pdc2027x_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= pdc2027x_pci_tbl,
 	.probe			= pdc2027x_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= pdc2027x_reinit_one,
-#endif
+	.driver.pm		= &pdc2027x_pci_device_pm_ops,
 };
 
 static struct scsi_host_template pdc2027x_sht = {
@@ -748,16 +745,11 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
 				 IRQF_SHARED, &pdc2027x_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pdc2027x_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused pdc2027x_reinit_one(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ata_host *host = pci_get_drvdata(pdev);
 	unsigned int board_idx;
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
 
 	if (pdev->device == PCI_DEVICE_ID_PROMISE_20268 ||
 	    pdev->device == PCI_DEVICE_ID_PROMISE_20270)
@@ -770,6 +762,5 @@ static int pdc2027x_reinit_one(struct pci_dev *pdev)
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 module_pci_driver(pdc2027x_pci_driver);
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 378ed9ea97e9..a16ce7abb6ba 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -378,10 +378,7 @@ static struct pci_driver pdc202xx_pci_driver = {
 	.id_table	= pdc202xx,
 	.probe 		= pdc202xx_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(pdc202xx_pci_driver);
diff --git a/drivers/ata/pata_piccolo.c b/drivers/ata/pata_piccolo.c
index 35cb0e263237..4ede5b98fc10 100644
--- a/drivers/ata/pata_piccolo.c
+++ b/drivers/ata/pata_piccolo.c
@@ -110,10 +110,7 @@ static struct pci_driver ata_tosh_pci_driver = {
 	.id_table	= ata_tosh,
 	.probe 		= ata_tosh_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(ata_tosh_pci_driver);
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 8fde4a86401b..64ae3ad60e52 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -238,10 +238,7 @@ static struct pci_driver radisys_pci_driver = {
 	.id_table		= radisys_pci_tbl,
 	.probe			= radisys_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(radisys_pci_driver);
diff --git a/drivers/ata/pata_rdc.c b/drivers/ata/pata_rdc.c
index ecb229c2c1a2..c205b5a78e6f 100644
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -369,10 +369,7 @@ static struct pci_driver rdc_pci_driver = {
 	.id_table		= rdc_pci_tbl,
 	.probe			= rdc_init_one,
 	.remove			= rdc_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 3722a67083fd..cfb008ba0d39 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -102,25 +102,18 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 	return -ENODEV;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int rz1000_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused rz1000_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
 	/* If this fails on resume (which is a "can't happen" case), we
 	   must stop as any progress risks data loss */
-	if (rz1000_fifo_disable(pdev))
+	if (rz1000_fifo_disable(to_pci_dev(dev)))
 		panic("rz1000 fifo");
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id pata_rz1000[] = {
 	{ PCI_VDEVICE(PCTECH, PCI_DEVICE_ID_PCTECH_RZ1000), },
@@ -129,15 +122,14 @@ static const struct pci_device_id pata_rz1000[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(rz1000_pci_device_pm_ops, rz1000_reinit_one);
+
 static struct pci_driver rz1000_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= pata_rz1000,
 	.probe 		= rz1000_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= rz1000_reinit_one,
-#endif
+	.driver.pm	= &rz1000_pci_device_pm_ops,
 };
 
 module_pci_driver(rz1000_pci_driver);
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 3b8c111140bd..8d1a8b5062c3 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -241,10 +241,7 @@ static struct pci_driver sc1200_pci_driver = {
 	.id_table	= sc1200,
 	.probe 		= sc1200_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(sc1200_pci_driver);
diff --git a/drivers/ata/pata_sch.c b/drivers/ata/pata_sch.c
index 4f9c2aefd807..f080b2929633 100644
--- a/drivers/ata/pata_sch.c
+++ b/drivers/ata/pata_sch.c
@@ -51,10 +51,7 @@ static struct pci_driver sch_pci_driver = {
 	.id_table		= sch_pci_tbl,
 	.probe			= sch_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 static struct scsi_host_template sch_sht = {
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 916bf024d737..c2a84e2b73d0 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -446,22 +446,15 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
 	return ata_pci_bmdma_init_one(pdev, ppi, sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int serverworks_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused serverworks_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-
-	(void)serverworks_fixup(pdev);
+	(void)serverworks_fixup(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id serverworks[] = {
 	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE), 0},
@@ -473,15 +466,14 @@ static const struct pci_device_id serverworks[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(serverworks_pci_device_pm_ops, serverworks_reinit_one);
+
 static struct pci_driver serverworks_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= serverworks,
 	.probe 		= serverworks_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= serverworks_reinit_one,
-#endif
+	.driver.pm	= &serverworks_pci_device_pm_ops,
 };
 
 module_pci_driver(serverworks_pci_driver);
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 7ab9aea3b630..e2e7b530c249 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -400,20 +400,15 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &sil680_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sil680_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused sil680_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int try_mmio, rc;
+	struct ata_host *host = dev_get_drvdata(dev);
+	int try_mmio;
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-	sil680_init_chip(pdev, &try_mmio);
+	sil680_init_chip(to_pci_dev(dev), &try_mmio);
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id sil680[] = {
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_SII_680), },
@@ -421,15 +416,14 @@ static const struct pci_device_id sil680[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(sil680_pci_device_pm_ops, sil680_reinit_one);
+
 static struct pci_driver sil680_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= sil680,
 	.probe 		= sil680_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= sil680_reinit_one,
-#endif
+	.driver.pm	= &sil680_pci_device_pm_ops,
 };
 
 module_pci_driver(sil680_pci_driver);
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index d7cd39a9888a..daa7a6f49589 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -870,22 +870,15 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	return ata_pci_bmdma_init_one(pdev, ppi, &sis_sht, chipset, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sis_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused sis_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-
-	sis_fixup(pdev, host->private_data);
+	sis_fixup(to_pci_dev(dev), host->private_data);
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VDEVICE(SI, 0x5513), },	/* SiS 5513 */
@@ -895,15 +888,14 @@ static const struct pci_device_id sis_pci_tbl[] = {
 	{ }
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(sis_pci_device_pm_ops, sis_reinit_one);
+
 static struct pci_driver sis_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= sis_pci_tbl,
 	.probe			= sis_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= sis_reinit_one,
-#endif
+	.driver.pm		= &sis_pci_device_pm_ops,
 };
 
 module_pci_driver(sis_pci_driver);
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index ac7ddd87f188..51be6538b94b 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -338,22 +338,15 @@ static int sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id
 	return ata_pci_bmdma_init_one(dev, ppi, &sl82c105_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sl82c105_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused sl82c105_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-
-	sl82c105_fixup(pdev);
+	sl82c105_fixup(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id sl82c105[] = {
 	{ PCI_VDEVICE(WINBOND, PCI_DEVICE_ID_WINBOND_82C105), },
@@ -361,15 +354,14 @@ static const struct pci_device_id sl82c105[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(sl82c105_pci_device_pm_ops, sl82c105_reinit_one);
+
 static struct pci_driver sl82c105_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= sl82c105,
 	.probe 		= sl82c105_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= sl82c105_reinit_one,
-#endif
+	.driver.pm	= &sl82c105_pci_device_pm_ops,
 };
 
 module_pci_driver(sl82c105_pci_driver);
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 2a4d38b98026..3d3626890f58 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -184,6 +184,13 @@ static int triflex_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
 
+	/*
+	 * We must not disable or powerdown the device.
+	 * APM bios refuses to suspend if IDE is not accessible.
+	 */
+	dev->pm_cap = 0;
+	dev_info(&dev->dev, "Disable triflex to be turned off by PCI CORE\n");
+
 	ata_print_version_once(&dev->dev, DRV_VERSION);
 
 	return ata_pci_bmdma_init_one(dev, ppi, &triflex_sht, NULL, 0);
@@ -195,36 +202,12 @@ static const struct pci_device_id triflex[] = {
 	{ },
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int triflex_ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
-{
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc = 0;
-
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
-
-	/*
-	 * We must not disable or powerdown the device.
-	 * APM bios refuses to suspend if IDE is not accessible.
-	 */
-	pci_save_state(pdev);
-
-	return 0;
-}
-
-#endif
-
 static struct pci_driver triflex_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= triflex,
 	.probe 		= triflex_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= triflex_ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
-#endif
+	.driver.pm	= &ata_pci_device_pm_ops,
 };
 
 module_pci_driver(triflex_pci_driver);
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 38044e679795..05525d29f307 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -660,10 +660,9 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &via_sht, (void *)config, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
 /**
  *	via_reinit_one		-	reinit after resume
- *	@pdev; PCI device
+ *	@dev: Device
  *
  *	Called when the VIA PATA device is resumed. We must then
  *	reconfigure the fifo and other setup we may have altered. In
@@ -671,21 +670,15 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
  *	quirk supported.
  */
 
-static int via_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused via_reinit_one(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-
-	via_fixup(pdev, host->private_data);
+	via_fixup(to_pci_dev(dev), host->private_data);
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id via[] = {
 	{ PCI_VDEVICE(VIA, 0x0415), },
@@ -700,15 +693,14 @@ static const struct pci_device_id via[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(via_pci_device_pm_ops, via_reinit_one);
+
 static struct pci_driver via_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= via,
 	.probe 		= via_init_one,
 	.remove		= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= via_reinit_one,
-#endif
+	.driver.pm	= &via_pci_device_pm_ops,
 };
 
 module_pci_driver(via_pci_driver);
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index e517bd8822a5..592e86b0e95b 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -793,17 +793,13 @@ static int init_controller(void __iomem *mmio_base, u16 hctl)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int inic_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused inic_pci_device_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ata_host *host = pci_get_drvdata(pdev);
 	struct inic_host_priv *hpriv = host->private_data;
 	int rc;
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = init_controller(hpriv->mmio_base, hpriv->cached_hctl);
 		if (rc)
@@ -814,7 +810,6 @@ static int inic_pci_device_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#endif
 
 static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -886,13 +881,12 @@ static const struct pci_device_id inic_pci_tbl[] = {
 	{ },
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(inic_pci_device_pm_ops, inic_pci_device_resume);
+
 static struct pci_driver inic_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= inic_pci_tbl,
-#ifdef CONFIG_PM_SLEEP
-	.suspend	= ata_pci_device_suspend,
-	.resume		= inic_pci_device_resume,
-#endif
+	.driver.pm	= &inic_pci_device_pm_ops,
 	.probe 		= inic_init_one,
 	.remove		= ata_pci_remove_one,
 };
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d7228f8e9297..22424b219725 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4299,21 +4299,16 @@ static struct platform_driver mv_platform_driver = {
 #ifdef CONFIG_PCI
 static int mv_pci_init_one(struct pci_dev *pdev,
 			   const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int mv_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused mv_pci_device_resume(struct device *dev);
 
+static ATA_SIMPLE_DEV_PM_OPS(mv_pci_device_pm_ops, mv_pci_device_resume);
 
 static struct pci_driver mv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= mv_pci_tbl,
 	.probe			= mv_pci_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= mv_pci_device_resume,
-#endif
-
+	.driver.pm		= &mv_pci_device_pm_ops,
 };
 
 /**
@@ -4437,16 +4432,11 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 				 IS_GEN_I(hpriv) ? &mv5_sht : &mv6_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mv_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused mv_pci_device_resume(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 	int rc;
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-
 	/* initialize adapter */
 	rc = mv_init_host(host);
 	if (rc)
@@ -4457,7 +4447,6 @@ static int mv_pci_device_resume(struct pci_dev *pdev)
 	return 0;
 }
 #endif
-#endif
 
 static int __init mv_init(void)
 {
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index eb9dc14e5147..2b47f519502d 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -279,9 +279,7 @@ struct nv_swncq_port_priv {
 #define NV_ADMA_CHECK_INTR(GCTL, PORT) ((GCTL) & (1 << (19 + (12 * (PORT)))))
 
 static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int nv_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused nv_pci_device_resume(struct device *dev);
 static void nv_ck804_host_stop(struct ata_host *host);
 static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance);
 static irqreturn_t nv_nf2_interrupt(int irq, void *dev_instance);
@@ -359,14 +357,13 @@ static const struct pci_device_id nv_pci_tbl[] = {
 	{ } /* terminate list */
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(nv_pci_device_pm_ops, nv_pci_device_resume);
+
 static struct pci_driver nv_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= nv_pci_tbl,
 	.probe			= nv_init_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= nv_pci_device_resume,
-#endif
+	.driver.pm		= &nv_pci_device_pm_ops,
 	.remove			= ata_pci_remove_one,
 };
 
@@ -2396,16 +2393,11 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return ata_pci_sff_activate_host(host, ipriv->irq_handler, ipriv->sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int nv_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused nv_pci_device_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ata_host *host = pci_get_drvdata(pdev);
 	struct nv_host_priv *hpriv = host->private_data;
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		if (hpriv->type >= CK804) {
@@ -2444,7 +2436,6 @@ static int nv_pci_device_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#endif
 
 static void nv_ck804_host_stop(struct ata_host *host)
 {
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 75321f1ceba5..6ba6bf6c527c 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -96,9 +96,7 @@ enum {
 };
 
 static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int sil_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused sil_pci_device_resume(struct device *dev);
 static void sil_dev_config(struct ata_device *dev);
 static int sil_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int sil_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
@@ -145,15 +143,14 @@ static const struct sil_drivelist {
 	{ }
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(sil_pci_device_pm_ops, sil_pci_device_resume);
+
 static struct pci_driver sil_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= sil_pci_tbl,
 	.probe			= sil_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= sil_pci_device_resume,
-#endif
+	.driver.pm		= &sil_pci_device_pm_ops,
 };
 
 static struct scsi_host_template sil_sht = {
@@ -788,21 +785,14 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				 &sil_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sil_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused sil_pci_device_resume(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
 	sil_init_controller(host);
 	ata_host_resume(host);
 
 	return 0;
 }
-#endif
 
 module_pci_driver(sil_pci_driver);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 560070d4f1d0..4a5159e622b6 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -343,9 +343,7 @@ static void sil24_error_handler(struct ata_port *ap);
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc);
 static int sil24_port_start(struct ata_port *ap);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int sil24_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused sil24_pci_device_resume(struct device *dev);
 #ifdef CONFIG_PM
 static int sil24_port_resume(struct ata_port *ap);
 #endif
@@ -362,15 +360,14 @@ static const struct pci_device_id sil24_pci_tbl[] = {
 	{ } /* terminate list */
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(sil24_pci_device_pm_ops, sil24_pci_device_resume);
+
 static struct pci_driver sil24_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= sil24_pci_tbl,
 	.probe			= sil24_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= sil24_pci_device_resume,
-#endif
+	.driver.pm		= &sil24_pci_device_pm_ops,
 };
 
 static struct scsi_host_template sil24_sht = {
@@ -1326,16 +1323,11 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				 &sil24_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sil24_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused sil24_pci_device_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ata_host *host = pci_get_drvdata(pdev);
 	void __iomem *host_base = host->iomap[SIL24_HOST_BAR];
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
 		writel(HOST_CTRL_GLOBAL_RST, host_base + HOST_CTRL);
@@ -1346,7 +1338,6 @@ static int sil24_pci_device_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_PM
 static int sil24_port_resume(struct ata_port *ap)
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 316237362aa9..86d51bd57b19 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -66,10 +66,7 @@ static struct pci_driver sis_pci_driver = {
 	.id_table		= sis_pci_tbl,
 	.probe			= sis_init_one,
 	.remove			= ata_pci_remove_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= ata_pci_device_resume,
-#endif
+	.driver.pm		= &ata_pci_device_pm_ops,
 };
 
 static struct scsi_host_template sis_sht = {
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index c7891cc84ea0..02fd5101278b 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -67,9 +67,7 @@ module_param_named(vt6420_hotplug, vt6420_hotplug, int, 0644);
 MODULE_PARM_DESC(vt6420_hotplug, "Enable hot-plug support for VT6420 (0=Don't support, 1=support)");
 
 static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int svia_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused svia_pci_device_resume(struct device *dev);
 static int svia_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int svia_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
 static int vt8251_scr_read(struct ata_link *link, unsigned int scr, u32 *val);
@@ -96,14 +94,13 @@ static const struct pci_device_id svia_pci_tbl[] = {
 	{ }	/* terminate list */
 };
 
+static ATA_SIMPLE_DEV_PM_OPS(svia_pci_device_pm_ops, svia_pci_device_resume);
+
 static struct pci_driver svia_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= svia_pci_tbl,
 	.probe			= svia_init_one,
-#ifdef CONFIG_PM_SLEEP
-	.suspend		= ata_pci_device_suspend,
-	.resume			= svia_pci_device_resume,
-#endif
+	.driver.pm		= &svia_pci_device_pm_ops,
 	.remove			= ata_pci_remove_one,
 };
 
@@ -736,23 +733,16 @@ static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 					 IRQF_SHARED, &svia_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int svia_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused svia_pci_device_resume(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 	struct svia_priv *hpriv = host->private_data;
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
 
 	if (hpriv->wd_workaround)
-		svia_wd_fix(pdev);
+		svia_wd_fix(to_pci_dev(dev));
 	ata_host_resume(host);
 
 	return 0;
 }
-#endif
 
 module_pci_driver(svia_pci_driver);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 77ccf040a128..6eb95c4448d8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1104,9 +1104,9 @@ extern int ata_sas_scsi_ioctl(struct ata_port *ap, struct scsi_device *dev,
 			    unsigned int cmd, void __user *arg);
 extern bool ata_link_online(struct ata_link *link);
 extern bool ata_link_offline(struct ata_link *link);
-#ifdef CONFIG_PM
 extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
 extern void ata_host_resume(struct ata_host *host);
+#ifdef CONFIG_PM
 extern void ata_sas_port_suspend(struct ata_port *ap);
 extern void ata_sas_port_resume(struct ata_port *ap);
 #else
@@ -1277,12 +1277,30 @@ extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bit
 extern void ata_pci_shutdown_one(struct pci_dev *pdev);
 extern void ata_pci_remove_one(struct pci_dev *pdev);
 
-#ifdef CONFIG_PM
-extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
-extern int __must_check ata_pci_device_do_resume(struct pci_dev *pdev);
-extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
-extern int ata_pci_device_resume(struct pci_dev *pdev);
-#endif /* CONFIG_PM */
+extern int ata_pci_device_suspend(struct device *dev);
+extern int ata_pci_device_hibernate(struct device *dev);
+extern int ata_pci_device_freeze(struct device *dev);
+extern int ata_pci_device_resume(struct device *dev);
+
+extern const struct dev_pm_ops ata_pci_device_pm_ops;
+
+#ifdef CONFIG_PM_SLEEP
+#define SET_ATA_SLEEP_PM_OPS(resume_fn) \
+	.suspend = ata_pci_device_suspend, \
+	.resume = resume_fn, \
+	.freeze = ata_pci_device_freeze, \
+	.thaw = resume_fn, \
+	.poweroff = ata_pci_device_hibernate, \
+	.restore = resume_fn,
+#else
+#define SET_ATA_SLEEP_PM_OPS(resume_fn)
+#endif
+
+#define ATA_SIMPLE_DEV_PM_OPS(name, resume_fn) \
+const struct dev_pm_ops name = { \
+	SET_ATA_SLEEP_PM_OPS(resume_fn) \
+}
+
 #endif /* CONFIG_PCI */
 
 struct platform_device;
-- 
2.27.0

