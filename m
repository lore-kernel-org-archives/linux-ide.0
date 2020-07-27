Return-Path: <SRS0=uzjf=BG=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AC0C433E1
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4900220714
	for <linux-ide@archiver.kernel.org>; Mon, 27 Jul 2020 17:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYTMaDCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgG0Rk7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgG0Rk7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jul 2020 13:40:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C7C061794;
        Mon, 27 Jul 2020 10:40:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so10202878pgm.2;
        Mon, 27 Jul 2020 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ARMQz3QuiwZlSHF5kBpn/nUNgAljmfG4kjqU9A1YPKE=;
        b=YYTMaDCy/8dipmd0ihA0VQn9Qk+pwodLI3ij0J45DckFr1/CUropMImQDCrPdKKuV8
         kz5mcZOG3fdO4HlpcBmqM06+Wsfd//d755InP/SJTCjNojeEl9jhMPPiT6nIff2gpR96
         q0IearHGVhwsJlZaRktWjqSZBrpBeWsJ/pMMCjGc6YF4T4V4NxsQcltXA8sH/yV01c1H
         eRwC/U7gyOS7eWnlS6A92fzKfn+2J4Bdd62k39VIJlrejesNbW59gz1ukLZAg9HdErAA
         t900GBQvdVW9JwDb43WNeXa1AdcuEpgSwzChCEhNiqjMfPjWQtRUHdP57V2opZsK3IGu
         p6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ARMQz3QuiwZlSHF5kBpn/nUNgAljmfG4kjqU9A1YPKE=;
        b=SW6COwzEke1d5yM1kyj3NBBozystaAokz6nnN1ndLJ1a7KxSmcMKkOGNyEgMz7Nhe1
         mv7U2wExgEN6QrEy3RKDIModiHtqPaoCQKCaAAClJWHqSaXkqvufl5tDHVG35LYYqX05
         kY1mgih8GoFVaL+3/sypniLSDwNeHO0/cbz/IYn3fbzagrNWGy02D8Z/0iSQb7tts9AH
         NA54nYWthhBapoXQutLiUqqWVe+WrtxH+pFiTzkEpcWvMRFF/tOiwJ9o3Qhnw/7SOxsI
         kpADzIrrPRdQurv4kJ3PDJWir7w++HfEmsNkUCi/tRGJur3aMjQz8TKgNDKaUlZG4gLM
         6BVg==
X-Gm-Message-State: AOAM531qUSIZbAaedfSv7bYx8QQ5UkWuWv7W61WNYWYMKhWWQlwbH6Rs
        7aNYkZMUy3P3vGUEvVAOm00=
X-Google-Smtp-Source: ABdhPJytWMnSieIY2b7tYvOA7wGtDUEAfK6fNzUygnfTt/ROF/OMmoNt0OgKzL0z27wtsLra3wuC7Q==
X-Received: by 2002:aa7:9ec4:: with SMTP id r4mr8993221pfq.48.1595871657645;
        Mon, 27 Jul 2020 10:40:57 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id m6sm4688518pfk.36.2020.07.27.10.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 10:40:56 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2] ata: use generic power management
Date:   Mon, 27 Jul 2020 23:09:23 +0530
Message-Id: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

use generic power management

Drivers using legacy power management .suspen()/.resume() callbacks
have to manage PCI states and device's PM states themselves. They also
need to take care of standard configuration registers.

Switch to generic power management framework using a single
"struct dev_pm_ops" variable to take the unnecessary load from the driver.
This also avoids the need for the driver to directly call most of the PCI
helper functions and device power state control functions, as through
the generic framework PCI Core takes care of the necessary operations,
and drivers are required to do only device-specific jobs.

The ata_pci_device_suspend() and ata_pci_device_resume(), declared in
include/linux/libata.h and defined in drivers/ata/libata-core.c, were
external and were exported. Those were then used by other source files.

Now, as they have to bind with dev_pm_ops object, there is no need to
export them and they can be made static.

Declare an extern const dev_pm_ops object in include/linux/ata.h and define
it in drivers/ata/libata-core.c with SIMPLE_DEV_PM_OPS macro, binding
suspend, and resume callbacks with it. This object can now be used by other
source files.

Now ata_pci_device_suspend() invokes ata_host_suspend(...,pm_message_t).
Earlier, PCI core used to send "PMSG_SUSPEND" argument to pm_message_t
variable of .suspend() which was then passed to .host_suspend(). Since, the
structure of .suspend() has changed, PCI core no more, pass this argument.
Hence, modfy each instance of call to .host_susped(), in respective PCI
drivers, and pass the value "PMSG_SUSPEND" to it.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/ata/acard-ahci.c        | 36 +++++++++-----------
 drivers/ata/ata_generic.c       |  5 +--
 drivers/ata/ata_piix.c          | 48 +++++++++------------------
 drivers/ata/libata-core.c       | 59 ++++++---------------------------
 drivers/ata/pata_acpi.c         |  5 +--
 drivers/ata/pata_ali.c          | 26 +++++++--------
 drivers/ata/pata_amd.c          | 24 +++++++-------
 drivers/ata/pata_artop.c        | 25 +++++++-------
 drivers/ata/pata_atiixp.c       |  5 +--
 drivers/ata/pata_atp867x.c      | 23 ++++++-------
 drivers/ata/pata_cmd640.c       | 26 +++++++--------
 drivers/ata/pata_cmd64x.c       | 25 +++++++-------
 drivers/ata/pata_cs5520.c       | 35 +++++++------------
 drivers/ata/pata_cs5530.c       | 23 ++++++-------
 drivers/ata/pata_cs5535.c       |  5 +--
 drivers/ata/pata_cs5536.c       |  5 +--
 drivers/ata/pata_cypress.c      |  5 +--
 drivers/ata/pata_efar.c         |  5 +--
 drivers/ata/pata_hpt366.c       | 26 +++++++--------
 drivers/ata/pata_hpt3x3.c       | 25 +++++++-------
 drivers/ata/pata_it8213.c       |  5 +--
 drivers/ata/pata_it821x.c       | 27 ++++++++-------
 drivers/ata/pata_jmicron.c      |  5 +--
 drivers/ata/pata_marvell.c      |  5 +--
 drivers/ata/pata_mpiix.c        |  5 +--
 drivers/ata/pata_netcell.c      |  5 +--
 drivers/ata/pata_ninja32.c      | 24 +++++++-------
 drivers/ata/pata_ns87410.c      |  5 +--
 drivers/ata/pata_ns87415.c      | 25 +++++++-------
 drivers/ata/pata_oldpiix.c      |  5 +--
 drivers/ata/pata_opti.c         |  5 +--
 drivers/ata/pata_optidma.c      |  5 +--
 drivers/ata/pata_pdc2027x.c     | 29 ++++++++--------
 drivers/ata/pata_pdc202xx_old.c |  5 +--
 drivers/ata/pata_piccolo.c      |  5 +--
 drivers/ata/pata_radisys.c      |  5 +--
 drivers/ata/pata_rdc.c          |  5 +--
 drivers/ata/pata_rz1000.c       | 25 +++++++-------
 drivers/ata/pata_sc1200.c       |  5 +--
 drivers/ata/pata_sch.c          |  5 +--
 drivers/ata/pata_serverworks.c  | 25 +++++++-------
 drivers/ata/pata_sil680.c       | 27 +++++++--------
 drivers/ata/pata_sis.c          | 25 +++++++-------
 drivers/ata/pata_sl82c105.c     | 25 +++++++-------
 drivers/ata/pata_triflex.c      | 33 +++++-------------
 drivers/ata/pata_via.c          | 33 +++++++++---------
 drivers/ata/sata_inic162x.c     | 23 +++++++------
 drivers/ata/sata_mv.c           | 29 ++++++++--------
 drivers/ata/sata_nv.c           | 29 ++++++++--------
 drivers/ata/sata_sil.c          | 28 ++++++++--------
 drivers/ata/sata_sil24.c        | 29 ++++++++--------
 drivers/ata/sata_sis.c          |  5 +--
 drivers/ata/sata_via.c          | 32 +++++++++---------
 include/linux/libata.h          |  9 ++---
 54 files changed, 407 insertions(+), 586 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 2a04e8abd397..4883ab38c076 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -61,10 +61,8 @@ static bool acard_ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
 static int acard_ahci_port_start(struct ata_port *ap);
 static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 
-#ifdef CONFIG_PM_SLEEP
-static int acard_ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
-static int acard_ahci_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused acard_ahci_pci_device_suspend(struct device *dev);
+static int __maybe_unused acard_ahci_pci_device_resume(struct device *dev);
 
 static struct scsi_host_template acard_ahci_sht = {
 	AHCI_SHT("acard-ahci"),
@@ -97,28 +95,29 @@ static const struct pci_device_id acard_ahci_pci_tbl[] = {
 	{ }    /* terminate list */
 };
 
+static SIMPLE_DEV_PM_OPS(acard_ahci_pci_device_pm_ops,
+			 acard_ahci_pci_device_suspend,
+			 acard_ahci_pci_device_resume);
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
+static int __maybe_unused acard_ahci_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
+	pm_message_t mesg = PMSG_SUSPEND;
 	u32 ctl;
 
 	if (mesg.event & PM_EVENT_SUSPEND &&
 	    hpriv->flags & AHCI_HFLAG_NO_SUSPEND) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"BIOS update required for suspend/resume\n");
 		return -EIO;
 	}
@@ -134,19 +133,15 @@ static int acard_ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg
 		readl(mmio + HOST_CTL); /* flush */
 	}
 
-	return ata_pci_device_suspend(pdev, mesg);
+	return ata_pci_device_pm_ops.suspend(dev);
 }
 
-static int acard_ahci_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused acard_ahci_pci_device_resume(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 	int rc;
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-
-	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
+	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_reset_controller(host);
 		if (rc)
 			return rc;
@@ -158,7 +153,6 @@ static int acard_ahci_pci_device_resume(struct pci_dev *pdev)
 
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
index 3ca7720e7d8f..984338d8beb3 100644
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
@@ -983,11 +982,13 @@ static int piix_broken_suspend(void)
 	return 0;
 }
 
-static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int __maybe_unused piix_pci_device_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct ata_host *host = pci_get_drvdata(pdev);
 	unsigned long flags;
 	int rc = 0;
+	pm_message_t mesg = PMSG_SUSPEND;
 
 	rc = ata_host_suspend(host, mesg);
 	if (rc)
@@ -999,8 +1000,6 @@ static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	 * beauty.
 	 */
 	if (piix_broken_suspend() && (mesg.event & PM_EVENT_SLEEP)) {
-		pci_save_state(pdev);
-
 		/* mark its power state as "unknown", since we don't
 		 * know if e.g. the BIOS will change its device state
 		 * when we suspend.
@@ -1012,44 +1011,26 @@ static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 		spin_lock_irqsave(&host->lock, flags);
 		host->flags |= PIIX_HOST_BROKEN_SUSPEND;
 		spin_unlock_irqrestore(&host->lock, flags);
-	} else
-		ata_pci_device_do_suspend(pdev, mesg);
+	}
 
 	return 0;
 }
 
-static int piix_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused piix_pci_device_resume(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
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
@@ -1752,15 +1733,16 @@ static void piix_remove_one(struct pci_dev *pdev)
 	ata_pci_remove_one(pdev);
 }
 
+static SIMPLE_DEV_PM_OPS(piix_pci_device_pm_ops,
+			 piix_pci_device_suspend,
+			 piix_pci_device_resume);
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
index b1cd4d97bc2a..525b9d04be9f 100644
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
@@ -6007,63 +6007,26 @@ int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits)
 }
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
 
-#ifdef CONFIG_PM
-void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int __maybe_unused ata_pci_device_suspend(struct device *dev)
 {
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	if (mesg.event & PM_EVENT_SLEEP)
-		pci_set_power_state(pdev, PCI_D3hot);
+	return ata_host_suspend(host, PMSG_SUSPEND);
 }
-EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
 
-int ata_pci_device_do_resume(struct pci_dev *pdev)
+static int __maybe_unused ata_pci_device_resume(struct device *dev)
 {
-	int rc;
+	struct ata_host *host = dev_get_drvdata(dev);
 
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
+	ata_host_resume(host);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 
-int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
-{
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc = 0;
+SIMPLE_DEV_PM_OPS(ata_pci_device_pm_ops,
+		  ata_pci_device_suspend,
+		  ata_pci_device_resume);
 
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
-
-	ata_pci_device_do_suspend(pdev, mesg);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
-
-int ata_pci_device_resume(struct pci_dev *pdev)
-{
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc == 0)
-		ata_host_resume(host);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(ata_pci_device_resume);
-#endif /* CONFIG_PM */
+EXPORT_SYMBOL_GPL(ata_pci_device_pm_ops);
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
index 0b122f903b8a..f9177b7aacd0 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -590,20 +590,19 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ata_pci_bmdma_init_one(pdev, ppi, &ali_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ali_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused ali_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-	ali_init_chipset(pdev);
+static int __maybe_unused ali_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+
+	ali_init_chipset(to_pci_dev(dev));
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id ali[] = {
 	{ PCI_VDEVICE(AL, PCI_DEVICE_ID_AL_M5228), },
@@ -612,15 +611,16 @@ static const struct pci_device_id ali[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(ali_pci_device_pm_ops,
+			 ali_pci_device_suspend,
+			 ali_reinit_one);
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
index 987967f976cb..e4dcbdbd4537 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -575,15 +575,15 @@ static int amd_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &amd_sht, hpriv, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int amd_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused amd_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused amd_reinit_one(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct ata_host *host = pci_get_drvdata(pdev);
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD) {
 		amd_clear_fifo(pdev);
@@ -594,7 +594,6 @@ static int amd_reinit_one(struct pci_dev *pdev)
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id amd[] = {
 	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_COBRA_7401),		0 },
@@ -622,15 +621,16 @@ static const struct pci_device_id amd[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(amd_pci_device_pm_ops,
+			 amd_pci_device_suspend,
+			 amd_reinit_one);
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
index 6bd2228bb6ff..021ecece6902 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -423,32 +423,31 @@ static const struct pci_device_id artop_pci_tbl[] = {
 	{ }	/* terminate list */
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int atp8xx_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused atp8xx_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused atp8xx_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	atp8xx_fixup(pdev);
+	atp8xx_fixup(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
+
+static SIMPLE_DEV_PM_OPS(atp8xx_pci_device_pm_ops,
+			 atp8xx_pci_device_suspend,
+			 atp8xx_reinit_one);
 
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
index e01a3a6e4d46..fbcea7af0072 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -513,22 +513,20 @@ static int atp867x_init_one(struct pci_dev *pdev,
 	return rc;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int atp867x_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused atp867x_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused atp867x_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 
 	atp867x_fixup(host);
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static struct pci_device_id atp867x_pci_tbl[] = {
 	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867A),	0 },
@@ -536,15 +534,16 @@ static struct pci_device_id atp867x_pci_tbl[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(atp867x_pci_device_pm_ops,
+			 atp867x_pci_device_suspend,
+			 atp867x_reinit_one);
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
index d0bcabb58b44..a7dc2046a28b 100644
--- a/drivers/ata/pata_cmd640.c
+++ b/drivers/ata/pata_cmd640.c
@@ -232,35 +232,35 @@ static int cmd640_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_sff_init_one(pdev, ppi, &cmd640_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cmd640_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused cmd640_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-	cmd640_hardware_init(pdev);
+static int __maybe_unused cmd640_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+
+	cmd640_hardware_init(to_pci_dev(dev));
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id cmd640[] = {
 	{ PCI_VDEVICE(CMD, 0x640), 0 },
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(cmd640_pci_device_pm_ops,
+			 cmd640_pci_device_suspend,
+			 cmd640_reinit_one);
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
index 3134eaec9e3d..34431f0feb4a 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -488,22 +488,20 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &cmd64x_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cmd64x_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused cmd64x_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused cmd64x_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	cmd64x_fixup(pdev);
+	cmd64x_fixup(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id cmd64x[] = {
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), 0 },
@@ -514,15 +512,16 @@ static const struct pci_device_id cmd64x[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(cmd64x_pci_device_pm_ops,
+			 cmd64x_pci_device_suspend,
+			 cmd64x_reinit_one);
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
index 9052148b306d..467332f926b6 100644
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
@@ -245,7 +240,7 @@ static int cs5520_reinit_one(struct pci_dev *pdev)
 
 /**
  *	cs5520_pci_device_suspend	-	device suspend
- *	@pdev: PCI device
+ *	@dev: Device
  *
  *	We have to cut and waste bits from the standard method because
  *	the 5520 is a bit odd and not just a pure ATA device. As a result
@@ -253,19 +248,12 @@ static int cs5520_reinit_one(struct pci_dev *pdev)
  *	chip specific mess in the core code.
  */
 
-static int cs5520_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int __maybe_unused cs5520_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc = 0;
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	rc = ata_host_suspend(host, mesg);
-	if (rc)
-		return rc;
-
-	pci_save_state(pdev);
-	return 0;
+	return ata_host_suspend(host, PMSG_SUSPEND);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 /* For now keep DMA off. We can set it for all but A rev CS5510 once the
    core ATA code can handle it */
@@ -277,15 +265,16 @@ static const struct pci_device_id pata_cs5520[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(cs5520_pci_device_pm_ops,
+			 cs5520_pci_device_suspend,
+			 cs5520_reinit_one);
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
index ad75d02b6dac..4d08b5a420ca 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -312,15 +312,14 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &cs5530_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cs5530_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused cs5530_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused cs5530_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 
 	/* If we fail on resume we are doomed */
 	if (cs5530_init_chip())
@@ -329,7 +328,6 @@ static int cs5530_reinit_one(struct pci_dev *pdev)
 	ata_host_resume(host);
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct pci_device_id cs5530[] = {
 	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE), },
@@ -337,15 +335,16 @@ static const struct pci_device_id cs5530[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(cs5530_pci_device_pm_ops,
+			 cs5530_pci_device_suspend,
+			 cs5530_reinit_one);
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
index 2574d6fbb1ad..5d47a629a3a5 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -384,35 +384,35 @@ static int hpt36x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(dev, ppi, &hpt36x_sht, (void *)hpriv, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int hpt36x_reinit_one(struct pci_dev *dev)
+static int __maybe_unused hpt36x_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(dev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(dev);
-	if (rc)
-		return rc;
-	hpt36x_init_chipset(dev);
+static int __maybe_unused hpt36x_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+
+	hpt36x_init_chipset(to_pci_dev(dev));
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id hpt36x[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT366), },
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(hpt36x_pci_device_pm_ops,
+			 hpt36x_pci_device_suspend,
+			 hpt36x_reinit_one);
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
index 83974d5eb387..eaef70d0d7a1 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -246,22 +246,20 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 				 IRQF_SHARED, &hpt3x3_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int hpt3x3_reinit_one(struct pci_dev *dev)
+static int __maybe_unused hpt3x3_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(dev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(dev);
-	if (rc)
-		return rc;
+static int __maybe_unused hpt3x3_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	hpt3x3_init_chipset(dev);
+	hpt3x3_init_chipset(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id hpt3x3[] = {
 	{ PCI_VDEVICE(TTI, PCI_DEVICE_ID_TTI_HPT343), },
@@ -269,15 +267,16 @@ static const struct pci_device_id hpt3x3[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(hpt3x3_pci_device_pm_ops,
+			 hpt3x3_pci_device_suspend,
+			 hpt3x3_reinit_one);
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
index 9bac79edbc2c..6a42902df58d 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -935,22 +935,20 @@ static int it821x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &it821x_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int it821x_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused it821x_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused it821x_reinit_one(struct device *dev)
+{
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
@@ -960,15 +958,16 @@ static const struct pci_device_id it821x[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(it821x_pci_device_pm_ops,
+			 it821x_pci_device_suspend,
+			 it821x_reinit_one);
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
index f9255d6fd194..1cf342ccee92 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -150,20 +150,19 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 				 IRQF_SHARED, &ninja32_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ninja32_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused ninja32_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
+
+static int __maybe_unused ninja32_reinit_one(struct device *dev)
+{
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
@@ -175,15 +174,16 @@ static const struct pci_device_id ninja32[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(ninja32_pci_device_pm_ops,
+			 ninja32_pci_device_suspend,
+			 ninja32_reinit_one);
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
index 4b2ba813dcab..665abc024892 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -386,32 +386,31 @@ static const struct pci_device_id ns87415_pci_tbl[] = {
 	{ }	/* terminate list */
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int ns87415_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused ns87415_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused ns87415_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	ns87415_fixup(pdev);
+	ns87415_fixup(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
+
+static SIMPLE_DEV_PM_OPS(ns87415_pci_device_pm_ops,
+			 ns87415_pci_device_suspend,
+			 ns87415_reinit_one);
 
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
index de834fbb6dfe..f1164945a9fa 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -57,9 +57,8 @@ enum {
 };
 
 static int pdc2027x_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int pdc2027x_reinit_one(struct pci_dev *pdev);
-#endif
+static int __maybe_unused pdc2027x_pci_device_suspend(struct device *dev);
+static int __maybe_unused pdc2027x_reinit_one(struct device *dev);
 static int pdc2027x_prereset(struct ata_link *link, unsigned long deadline);
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
@@ -118,15 +117,16 @@ static const struct pci_device_id pdc2027x_pci_tbl[] = {
 	{ }	/* terminate list */
 };
 
+static SIMPLE_DEV_PM_OPS(pdc2027x_pci_device_pm_ops,
+			 pdc2027x_pci_device_suspend,
+			 pdc2027x_reinit_one);
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
@@ -748,16 +748,16 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
 				 IRQF_SHARED, &pdc2027x_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int pdc2027x_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused pdc2027x_pci_device_suspend(struct device *dev)
+{
+	return ata_pci_device_pm_ops.suspend(dev);
+}
+
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
@@ -770,6 +770,5 @@ static int pdc2027x_reinit_one(struct pci_dev *pdev)
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
index 3722a67083fd..8e4354233fb8 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -102,25 +102,23 @@ static int rz1000_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 	return -ENODEV;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int rz1000_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused rz1000_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused rz1000_reinit_one(struct device *dev)
+{
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
@@ -129,15 +127,16 @@ static const struct pci_device_id pata_rz1000[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(rz1000_pci_device_pm_ops,
+			 rz1000_pci_device_suspend,
+			 rz1000_reinit_one);
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
index 916bf024d737..1b015b048870 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -446,22 +446,20 @@ static int serverworks_init_one(struct pci_dev *pdev, const struct pci_device_id
 	return ata_pci_bmdma_init_one(pdev, ppi, sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int serverworks_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused serverworks_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused serverworks_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	(void)serverworks_fixup(pdev);
+	(void)serverworks_fixup(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id serverworks[] = {
 	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE), 0},
@@ -473,15 +471,16 @@ static const struct pci_device_id serverworks[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(serverworks_pci_device_pm_ops,
+			 serverworks_pci_device_suspend,
+			 serverworks_reinit_one);
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
index 7ab9aea3b630..3cbbd5988c34 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -400,20 +400,20 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &sil680_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sil680_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused sil680_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int try_mmio, rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-	sil680_init_chip(pdev, &try_mmio);
+static int __maybe_unused sil680_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	int try_mmio;
+
+	sil680_init_chip(to_pci_dev(dev), &try_mmio);
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id sil680[] = {
 	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_SII_680), },
@@ -421,15 +421,16 @@ static const struct pci_device_id sil680[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(sil680_pci_device_pm_ops,
+			 sil680_pci_device_suspend,
+			 sil680_reinit_one);
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
index d7cd39a9888a..0f42615a304c 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -870,22 +870,20 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	return ata_pci_bmdma_init_one(pdev, ppi, &sis_sht, chipset, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sis_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused sis_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused sis_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	sis_fixup(pdev, host->private_data);
+	sis_fixup(to_pci_dev(dev), host->private_data);
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id sis_pci_tbl[] = {
 	{ PCI_VDEVICE(SI, 0x5513), },	/* SiS 5513 */
@@ -895,15 +893,16 @@ static const struct pci_device_id sis_pci_tbl[] = {
 	{ }
 };
 
+static SIMPLE_DEV_PM_OPS(sis_pci_device_pm_ops,
+			 sis_pci_device_suspend,
+			 sis_reinit_one);
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
index ac7ddd87f188..6e8070be9d50 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -338,22 +338,20 @@ static int sl82c105_init_one(struct pci_dev *dev, const struct pci_device_id *id
 	return ata_pci_bmdma_init_one(dev, ppi, &sl82c105_sht, NULL, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sl82c105_reinit_one(struct pci_dev *pdev)
+static int __maybe_unused sl82c105_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused sl82c105_reinit_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 
-	sl82c105_fixup(pdev);
+	sl82c105_fixup(to_pci_dev(dev));
 
 	ata_host_resume(host);
 	return 0;
 }
-#endif
 
 static const struct pci_device_id sl82c105[] = {
 	{ PCI_VDEVICE(WINBOND, PCI_DEVICE_ID_WINBOND_82C105), },
@@ -361,15 +359,16 @@ static const struct pci_device_id sl82c105[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(sl82c105_pci_device_pm_ops,
+			 sl82c105_pci_device_suspend,
+			 sl82c105_reinit_one);
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
index 38044e679795..2bb447517aaa 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -660,10 +660,18 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ata_pci_bmdma_init_one(pdev, ppi, &via_sht, (void *)config, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
+/**
+ *	via_pci_device_suspend	-	suspend
+ *	@dev: Device
+ */
+static int __maybe_unused via_pci_device_suspend(struct device *dev)
+{
+	return ata_pci_device_pm_ops.suspend(dev);
+}
+
 /**
  *	via_reinit_one		-	reinit after resume
- *	@pdev; PCI device
+ *	@dev: Device
  *
  *	Called when the VIA PATA device is resumed. We must then
  *	reconfigure the fifo and other setup we may have altered. In
@@ -671,21 +679,15 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -700,15 +702,16 @@ static const struct pci_device_id via[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(via_pci_device_pm_ops,
+			 via_pci_device_suspend,
+			 via_reinit_one);
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
index e517bd8822a5..68e662c2992b 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -793,17 +793,18 @@ static int init_controller(void __iomem *mmio_base, u16 hctl)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int inic_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused inic_pci_device_suspend(struct device *dev)
 {
+	return ata_pci_device_pm_ops.suspend(dev);
+}
+
+static int __maybe_unused inic_pci_device_resume(struct device *dev)
+{
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
@@ -814,7 +815,6 @@ static int inic_pci_device_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#endif
 
 static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -886,13 +886,14 @@ static const struct pci_device_id inic_pci_tbl[] = {
 	{ },
 };
 
+static SIMPLE_DEV_PM_OPS(inic_pci_device_pm_ops,
+			 inic_pci_device_suspend,
+			 inic_pci_device_resume);
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
index d7228f8e9297..58e7cec970c7 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4299,21 +4299,19 @@ static struct platform_driver mv_platform_driver = {
 #ifdef CONFIG_PCI
 static int mv_pci_init_one(struct pci_dev *pdev,
 			   const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int mv_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused mv_pci_device_suspend(struct device *dev);
+static int __maybe_unused mv_pci_device_resume(struct device *dev);
 
+static SIMPLE_DEV_PM_OPS(mv_pci_device_pm_ops,
+			 mv_pci_device_suspend,
+			 mv_pci_device_resume);
 
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
@@ -4437,15 +4435,15 @@ static int mv_pci_init_one(struct pci_dev *pdev,
 				 IS_GEN_I(hpriv) ? &mv5_sht : &mv6_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mv_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused mv_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused mv_pci_device_resume(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	int rc;
 
 	/* initialize adapter */
 	rc = mv_init_host(host);
@@ -4457,7 +4455,6 @@ static int mv_pci_device_resume(struct pci_dev *pdev)
 	return 0;
 }
 #endif
-#endif
 
 static int __init mv_init(void)
 {
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index eb9dc14e5147..57f2adf43b7b 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -279,9 +279,8 @@ struct nv_swncq_port_priv {
 #define NV_ADMA_CHECK_INTR(GCTL, PORT) ((GCTL) & (1 << (19 + (12 * (PORT)))))
 
 static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int nv_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused nv_pci_device_suspend(struct device *dev);
+static int __maybe_unused nv_pci_device_resume(struct device *dev);
 static void nv_ck804_host_stop(struct ata_host *host);
 static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance);
 static irqreturn_t nv_nf2_interrupt(int irq, void *dev_instance);
@@ -359,14 +358,15 @@ static const struct pci_device_id nv_pci_tbl[] = {
 	{ } /* terminate list */
 };
 
+static SIMPLE_DEV_PM_OPS(nv_pci_device_pm_ops,
+			 nv_pci_device_suspend,
+			 nv_pci_device_resume);
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
 
@@ -2396,16 +2396,16 @@ static int nv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return ata_pci_sff_activate_host(host, ipriv->irq_handler, ipriv->sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int nv_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused nv_pci_device_suspend(struct device *dev)
+{
+	return ata_pci_device_pm_ops.suspend(dev);
+}
+
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
@@ -2444,7 +2444,6 @@ static int nv_pci_device_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#endif
 
 static void nv_ck804_host_stop(struct ata_host *host)
 {
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 75321f1ceba5..433e39731e40 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -96,9 +96,8 @@ enum {
 };
 
 static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int sil_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused sil_pci_device_suspend(struct device *dev);
+static int __maybe_unused sil_pci_device_resume(struct device *dev);
 static void sil_dev_config(struct ata_device *dev);
 static int sil_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int sil_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
@@ -145,15 +144,16 @@ static const struct sil_drivelist {
 	{ }
 };
 
+static SIMPLE_DEV_PM_OPS(sil_pci_device_pm_ops,
+			 sil_pci_device_suspend,
+			 sil_pci_device_resume);
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
@@ -788,21 +788,19 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				 &sil_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sil_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused sil_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused sil_pci_device_resume(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
 
 	sil_init_controller(host);
 	ata_host_resume(host);
 
 	return 0;
 }
-#endif
 
 module_pci_driver(sil_pci_driver);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 560070d4f1d0..f47d7225b999 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -343,9 +343,8 @@ static void sil24_error_handler(struct ata_port *ap);
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc);
 static int sil24_port_start(struct ata_port *ap);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int sil24_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused sil24_pci_device_suspend(struct device *dev);
+static int __maybe_unused sil24_pci_device_resume(struct device *dev);
 #ifdef CONFIG_PM
 static int sil24_port_resume(struct ata_port *ap);
 #endif
@@ -362,15 +361,16 @@ static const struct pci_device_id sil24_pci_tbl[] = {
 	{ } /* terminate list */
 };
 
+static SIMPLE_DEV_PM_OPS(sil24_pci_device_pm_ops,
+			 sil24_pci_device_suspend,
+			 sil24_pci_device_resume);
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
@@ -1326,16 +1326,16 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				 &sil24_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sil24_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused sil24_pci_device_suspend(struct device *dev)
+{
+	return ata_pci_device_pm_ops.suspend(dev);
+}
+
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
@@ -1346,7 +1346,6 @@ static int sil24_pci_device_resume(struct pci_dev *pdev)
 
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
index c7891cc84ea0..be0d1e3ae5bd 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -67,9 +67,8 @@ module_param_named(vt6420_hotplug, vt6420_hotplug, int, 0644);
 MODULE_PARM_DESC(vt6420_hotplug, "Enable hot-plug support for VT6420 (0=Don't support, 1=support)");
 
 static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-#ifdef CONFIG_PM_SLEEP
-static int svia_pci_device_resume(struct pci_dev *pdev);
-#endif
+static int __maybe_unused svia_pci_device_suspend(struct device *dev);
+static int __maybe_unused svia_pci_device_resume(struct device *dev);
 static int svia_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int svia_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
 static int vt8251_scr_read(struct ata_link *link, unsigned int scr, u32 *val);
@@ -96,14 +95,15 @@ static const struct pci_device_id svia_pci_tbl[] = {
 	{ }	/* terminate list */
 };
 
+static SIMPLE_DEV_PM_OPS(svia_pci_device_pm_ops,
+			 svia_pci_device_suspend,
+			 svia_pci_device_resume);
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
 
@@ -736,23 +736,21 @@ static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 					 IRQF_SHARED, &svia_sht);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int svia_pci_device_resume(struct pci_dev *pdev)
+static int __maybe_unused svia_pci_device_suspend(struct device *dev)
 {
-	struct ata_host *host = pci_get_drvdata(pdev);
-	struct svia_priv *hpriv = host->private_data;
-	int rc;
+	return ata_pci_device_pm_ops.suspend(dev);
+}
 
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
+static int __maybe_unused svia_pci_device_resume(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct svia_priv *hpriv = host->private_data;
 
 	if (hpriv->wd_workaround)
-		svia_wd_fix(pdev);
+		svia_wd_fix(to_pci_dev(dev));
 	ata_host_resume(host);
 
 	return 0;
 }
-#endif
 
 module_pci_driver(svia_pci_driver);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 77ccf040a128..f1bdda06ed5c 100644
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
@@ -1277,12 +1277,7 @@ extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bit
 extern void ata_pci_shutdown_one(struct pci_dev *pdev);
 extern void ata_pci_remove_one(struct pci_dev *pdev);
 
-#ifdef CONFIG_PM
-extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
-extern int __must_check ata_pci_device_do_resume(struct pci_dev *pdev);
-extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
-extern int ata_pci_device_resume(struct pci_dev *pdev);
-#endif /* CONFIG_PM */
+extern const struct dev_pm_ops ata_pci_device_pm_ops;
 #endif /* CONFIG_PCI */
 
 struct platform_device;
-- 
2.27.0

