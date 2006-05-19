From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/14] libata-hp-prep: implement ata_noop_check_status()
Date: Fri, 19 May 2006 06:06:41 -0700 (PDT)
Message-ID: <1148043989542-git-send-email-htejun@gmail.com>
References: <11480439893100-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:18121 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751325AbWESNGm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:06:42 -0400
Received: by py-out-1112.google.com with SMTP id z59so917368pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:06:41 -0700 (PDT)
In-Reply-To: <11480439893100-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

As with ops->tf_read, ops->check_status() and ops->check_altstatus()
don't make sense for controllers without single TF image.  As
->check_status() and ->check_altstatus() are deeply integrated into
libata core layer, implement ata_noop_check_status() as a temporary
measure.  This function always returns ATA_DRDY without doing
anything.

In the long term, these IO ops should be made optional and removed
from top level ata_port_operations such that driver implementing
high-level behavior don't have to bother with these.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   19 +++++++++++++++++++
 include/linux/libata.h     |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

89c675e09ffd6c3cdf7cc656152f6a1ea03533f0
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9a4124e..72eef00 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -707,6 +707,24 @@ static u64 ata_id_n_sectors(const u16 *i
 }
 
 /**
+ *	ata_noop_check_status - Fake device status reg
+ *	@ap: target port
+ *
+ *	This function performs no actual function and always returns
+ *	ATA_DRDY.
+ *
+ *	May be used as the check_status/altstatus() entry in
+ *	ata_port_operations.
+ *
+ *	LOCKING:
+ *	caller.
+ */
+u8 ata_noop_check_status(struct ata_port *ap)
+{
+	return ATA_DRDY;
+}
+
+/**
  *	ata_noop_dev_select - Select device 0/1 on ATA bus
  *	@ap: ATA channel to manipulate
  *	@device: ATA device (numbered from zero) to select
@@ -5769,6 +5787,7 @@ EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
 EXPORT_SYMBOL_GPL(ata_tf_load);
 EXPORT_SYMBOL_GPL(ata_tf_read);
 EXPORT_SYMBOL_GPL(ata_noop_dev_select);
+EXPORT_SYMBOL_GPL(ata_noop_check_status);
 EXPORT_SYMBOL_GPL(ata_std_dev_select);
 EXPORT_SYMBOL_GPL(ata_tf_to_fis);
 EXPORT_SYMBOL_GPL(ata_tf_from_fis);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3d7c3e3..35f6d3b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -665,6 +665,7 @@ extern void ata_tf_load(struct ata_port 
 extern void ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf, u8 *fis, u8 pmp);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
+extern u8 ata_noop_check_status(struct ata_port *ap);
 extern void ata_noop_dev_select (struct ata_port *ap, unsigned int device);
 extern void ata_std_dev_select (struct ata_port *ap, unsigned int device);
 extern u8 ata_check_status(struct ata_port *ap);
-- 
1.3.2

