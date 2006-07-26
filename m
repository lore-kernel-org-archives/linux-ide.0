From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: cosmetic changes to PM functions
Date: Wed, 26 Jul 2006 16:58:33 +0900
Message-ID: <20060726075833.GA6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:61652 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964790AbWGZH6k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Jul 2006 03:58:40 -0400
Received: by py-out-1112.google.com with SMTP id t32so3377979pyc
        for <linux-ide@vger.kernel.org>; Wed, 26 Jul 2006 00:58:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Unify pm_message_t argument to the new-style @mesg.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2006-07-26 16:32:30.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2006-07-26 16:34:36.000000000 +0900
@@ -5767,11 +5767,11 @@ int pci_test_config_bits(struct pci_dev 
 	return (tmp == bits->val) ? 1 : 0;
 }
 
-void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t state)
+void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	pci_save_state(pdev);
 
-	if (state.event == PM_EVENT_SUSPEND) {
+	if (mesg.event == PM_EVENT_SUSPEND) {
 		pci_disable_device(pdev);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
@@ -5785,24 +5785,24 @@ void ata_pci_device_do_resume(struct pci
 	pci_set_master(pdev);
 }
 
-int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
+int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
 	int rc = 0;
 
-	rc = ata_host_set_suspend(host_set, state);
+	rc = ata_host_set_suspend(host_set, mesg);
 	if (rc)
 		return rc;
 
 	if (host_set->next) {
-		rc = ata_host_set_suspend(host_set->next, state);
+		rc = ata_host_set_suspend(host_set->next, mesg);
 		if (rc) {
 			ata_host_set_resume(host_set);
 			return rc;
 		}
 	}
 
-	ata_pci_device_do_suspend(pdev, state);
+	ata_pci_device_do_suspend(pdev, mesg);
 
 	return 0;
 }
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2006-07-26 16:32:30.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2006-07-26 16:33:55.000000000 +0900
@@ -400,7 +400,7 @@ void ata_dump_status(unsigned id, struct
 /**
  *	ata_scsi_device_suspend - suspend ATA device associated with sdev
  *	@sdev: the SCSI device to suspend
- *	@state: target power management state
+ *	@mesg: target power management message
  *
  *	Request suspend EH action on the ATA device associated with
  *	@sdev and wait for the operation to complete.
@@ -411,7 +411,7 @@ void ata_dump_status(unsigned id, struct
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
+int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t mesg)
 {
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct ata_device *dev = ata_scsi_find_dev(ap, sdev);
@@ -438,7 +438,7 @@ int ata_scsi_device_suspend(struct scsi_
 
 	/* request suspend */
 	action = ATA_EH_SUSPEND;
-	if (state.event != PM_EVENT_SUSPEND)
+	if (mesg.event != PM_EVENT_SUSPEND)
 		action |= ATA_EH_PM_FREEZE;
 	ap->eh_info.dev_action[dev->devno] |= action;
 	ap->eh_info.flags |= ATA_EHI_QUIET;
@@ -463,7 +463,7 @@ int ata_scsi_device_suspend(struct scsi_
 	spin_unlock_irqrestore(ap->lock, flags);
  out:
 	if (rc == 0)
-		sdev->sdev_gendev.power.power_state = state;
+		sdev->sdev_gendev.power.power_state = mesg;
 	return rc;
 }
 
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2006-07-26 16:32:31.000000000 +0900
+++ work/include/linux/libata.h	2006-07-26 16:32:50.000000000 +0900
@@ -676,9 +676,9 @@ extern void ata_std_ports(struct ata_iop
 extern int ata_pci_init_one (struct pci_dev *pdev, struct ata_port_info **port_info,
 			     unsigned int n_ports);
 extern void ata_pci_remove_one (struct pci_dev *pdev);
-extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t state);
+extern void ata_pci_device_do_suspend(struct pci_dev *pdev, pm_message_t mesg);
 extern void ata_pci_device_do_resume(struct pci_dev *pdev);
-extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
+extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
 extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
@@ -697,7 +697,7 @@ extern int sata_scr_write_flush(struct a
 extern int ata_port_online(struct ata_port *ap);
 extern int ata_port_offline(struct ata_port *ap);
 extern int ata_scsi_device_resume(struct scsi_device *);
-extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
+extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t mesg);
 extern int ata_host_set_suspend(struct ata_host_set *host_set,
 				pm_message_t mesg);
 extern void ata_host_set_resume(struct ata_host_set *host_set);
