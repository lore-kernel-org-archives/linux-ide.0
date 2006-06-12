From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add host_set->next for legacy two host_sets case, take #3
Date: Mon, 12 Jun 2006 23:05:38 +0900
Message-ID: <20060612140538.GA3892@htj.dyndns.org>
References: <20060612051727.GD9166@htj.dyndns.org> <448D0FF9.1080605@pobox.com> <20060612101419.GB5751@htj.dyndns.org> <448D6DBF.9010604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:52896 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751998AbWFLOFn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 10:05:43 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1638718nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 07:05:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <448D6DBF.9010604@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

For a legacy ATA controller, libata registers two separate host sets.
There was no connection between the two hosts making it impossible to
traverse all ports related to the controller.  This patch adds
host_set->next which points to the second host_set and makes
ata_pci_remove_one() remove all associated host_sets.

* On device removal, all ports hanging off the device are properly
  detached.  Prior to this patch, ports on the first host_set weren't
  detached casuing oops on driver unloading.

* On device removal, both host_sets are properly freed

This will also be used by new power management code to suspend and
resume all ports of a controller.  host_set/port representation will
be improved to handle legacy controllers better and this host_set
linking will go away with it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |   15 +++++++++++++--
 drivers/scsi/libata-core.c  |    4 ++++
 include/linux/libata.h      |    3 ++-
 3 files changed, 19 insertions(+), 3 deletions(-)

d785d4a8e1eb5210dc351585610244567a0d5d70
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 4bc0537..13fab97 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -1076,10 +1076,21 @@ int ata_pci_init_one (struct pci_dev *pd
 
 	/* FIXME: check ata_device_add return */
 	if (legacy_mode) {
-		if (legacy_mode & (1 << 0))
+		struct device *dev = &pdev->dev;
+		struct ata_host_set *host_set = NULL;
+
+		if (legacy_mode & (1 << 0)) {
 			ata_device_add(probe_ent);
-		if (legacy_mode & (1 << 1))
+			host_set = dev_get_drvdata(dev);
+		}
+
+		if (legacy_mode & (1 << 1)) {
 			ata_device_add(probe_ent2);
+			if (host_set) {
+				host_set->next = dev_get_drvdata(dev);
+				dev_set_drvdata(dev, host_set);
+			}
+		}
 	} else
 		ata_device_add(probe_ent);
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 014855e..d73cb36 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5621,8 +5621,12 @@ void ata_pci_remove_one (struct pci_dev 
 {
 	struct device *dev = pci_dev_to_dev(pdev);
 	struct ata_host_set *host_set = dev_get_drvdata(dev);
+	struct ata_host_set *host_set2 = host_set->next;
 
 	ata_host_set_remove(host_set);
+	if (host_set2)
+		ata_host_set_remove(host_set2);
+
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	dev_set_drvdata(dev, NULL);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 61eea57..f03b866 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -356,7 +356,8 @@ struct ata_host_set {
 	unsigned long		flags;
 	int			simplex_claimed;	/* Keep seperate in case we
 							   ever need to do this locked */
-	struct ata_port *	ports[0];
+	struct ata_host_set	*next;		/* for legacy mode */
+	struct ata_port		*ports[0];
 };
 
 struct ata_queued_cmd {
-- 
1.3.2

