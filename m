From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] libata: add CONFIG_PM to libata core layer
Date: Fri, 2 Mar 2007 17:32:47 +0900
Message-ID: <20070302083247.GM20322@htj.dyndns.org>
References: <20070302083001.GK20322@htj.dyndns.org> <20070302083126.GL20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:46200 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910AbXCBIcs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Mar 2007 03:32:48 -0500
Received: by nz-out-0506.google.com with SMTP id s1so781654nze
        for <linux-ide@vger.kernel.org>; Fri, 02 Mar 2007 00:32:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070302083126.GL20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Conditionalize all PM related stuff in libata core layer using
CONFIG_PM.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   11 +++++++++++
 drivers/ata/libata-eh.c   |   29 +++++++++++++++++++++++++++++
 drivers/ata/libata-scsi.c |    2 ++
 include/linux/libata.h    |    4 ++++
 4 files changed, 46 insertions(+)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -5341,6 +5341,7 @@ int ata_flush_cache(struct ata_device *d
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 			       unsigned int action, unsigned int ehi_flags,
 			       int wait)
@@ -5456,6 +5457,7 @@ void ata_host_resume(struct ata_host *ho
 			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET, 0);
 	host->dev->power.power_state = PMSG_ON;
 }
+#endif
 
 /**
  *	ata_port_start - Set port up for dma.
@@ -6090,6 +6092,7 @@ int pci_test_config_bits(struct pci_dev 
 	return (tmp == bits->val) ? 1 : 0;
 }
 
+#ifdef CONFIG_PM
 void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	pci_save_state(pdev);
@@ -6141,6 +6144,8 @@ int ata_pci_device_resume(struct pci_dev
 		ata_host_resume(host);
 	return rc;
 }
+#endif /* CONFIG_PM */
+
 #endif /* CONFIG_PCI */
 
 
@@ -6350,8 +6355,10 @@ EXPORT_SYMBOL_GPL(sata_scr_write);
 EXPORT_SYMBOL_GPL(sata_scr_write_flush);
 EXPORT_SYMBOL_GPL(ata_port_online);
 EXPORT_SYMBOL_GPL(ata_port_offline);
+#ifdef CONFIG_PM
 EXPORT_SYMBOL_GPL(ata_host_suspend);
 EXPORT_SYMBOL_GPL(ata_host_resume);
+#endif /* CONFIG_PM */
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_id_to_dma_mode);
@@ -6367,16 +6374,20 @@ EXPORT_SYMBOL_GPL(pci_test_config_bits);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
+#ifdef CONFIG_PM
 EXPORT_SYMBOL_GPL(ata_pci_device_do_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_do_resume);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_resume);
+#endif /* CONFIG_PM */
 EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
+#ifdef CONFIG_PM
 EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
 EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
+#endif /* CONFIG_PM */
 
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -52,8 +52,33 @@ enum {
 
 static void __ata_port_freeze(struct ata_port *ap);
 static void ata_eh_finish(struct ata_port *ap);
+#ifdef CONFIG_PM
 static void ata_eh_handle_port_suspend(struct ata_port *ap);
 static void ata_eh_handle_port_resume(struct ata_port *ap);
+static int ata_eh_suspend(struct ata_port *ap,
+			  struct ata_device **r_failed_dev);
+static void ata_eh_prep_resume(struct ata_port *ap);
+static int ata_eh_resume(struct ata_port *ap, struct ata_device **r_failed_dev);
+#else /* CONFIG_PM */
+static void ata_eh_handle_port_suspend(struct ata_port *ap)
+{ }
+
+static void ata_eh_handle_port_resume(struct ata_port *ap)
+{ }
+
+static int ata_eh_suspend(struct ata_port *ap, struct ata_device **r_failed_dev)
+{
+	return 0;
+}
+
+static void ata_eh_prep_resume(struct ata_port *ap)
+{ }
+
+static int ata_eh_resume(struct ata_port *ap, struct ata_device **r_failed_dev)
+{
+	return 0;
+}
+#endif /* CONFIG_PM */
 
 static void ata_ering_record(struct ata_ering *ering, int is_io,
 			     unsigned int err_mask)
@@ -1790,6 +1815,7 @@ static int ata_eh_revalidate_and_attach(
 	return rc;
 }
 
+#ifdef CONFIG_PM
 /**
  *	ata_eh_suspend - handle suspend EH action
  *	@ap: target host port
@@ -1947,6 +1973,7 @@ static int ata_eh_resume(struct ata_port
 	DPRINTK("EXIT\n");
 	return 0;
 }
+#endif /* CONFIG_PM */
 
 static int ata_port_nr_enabled(struct ata_port *ap)
 {
@@ -2249,6 +2276,7 @@ void ata_do_eh(struct ata_port *ap, ata_
 	ata_eh_finish(ap);
 }
 
+#ifdef CONFIG_PM
 /**
  *	ata_eh_handle_port_suspend - perform port suspend operation
  *	@ap: port to suspend
@@ -2364,3 +2392,4 @@ static void ata_eh_handle_port_resume(st
 	}
 	spin_unlock_irqrestore(ap->lock, flags);
 }
+#endif /* CONFIG_PM */
Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -510,6 +510,7 @@ static void ata_dump_status(unsigned id,
 	}
 }
 
+#ifdef CONFIG_PM
 /**
  *	ata_scsi_device_suspend - suspend ATA device associated with sdev
  *	@sdev: the SCSI device to suspend
@@ -634,6 +635,7 @@ int ata_scsi_device_resume(struct scsi_d
 	sdev->sdev_gendev.power.power_state = PMSG_ON;
 	return 0;
 }
+#endif /* CONFIG_PM */
 
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -720,10 +720,12 @@ extern void ata_std_ports(struct ata_iop
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
+#ifdef CONFIG_PM
 extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
 extern int __must_check ata_pci_device_do_resume(struct pci_dev *pdev);
 extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
+#endif
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);
@@ -749,10 +751,12 @@ extern int sata_scr_write(struct ata_por
 extern int sata_scr_write_flush(struct ata_port *ap, int reg, u32 val);
 extern int ata_port_online(struct ata_port *ap);
 extern int ata_port_offline(struct ata_port *ap);
+#ifdef CONFIG_PM
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t mesg);
 extern int ata_host_suspend(struct ata_host *host, pm_message_t mesg);
 extern void ata_host_resume(struct ata_host *host);
+#endif
 extern int ata_ratelimit(void);
 extern int ata_busy_sleep(struct ata_port *ap,
 			  unsigned long timeout_pat, unsigned long timeout);
