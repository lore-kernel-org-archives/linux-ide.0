From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/15] libata: implement ata_port_max_devices()
Date: Sat, 24 Jun 2006 20:30:19 +0900
Message-ID: <1151148619318-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:48166 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S933038AbWFXLaN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:13 -0400
Received: by py-out-1112.google.com with SMTP id t32so931812pyc
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:13 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_port_max_devices().  This function returns the number of
possible devices on a port.  This will be used by new PM
implementation.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

af0dd1d6c6651ab9e8e3a9d8e7264daf57eff032
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 20b1cf5..3afd009 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -887,6 +887,9 @@ static inline unsigned int ata_tag_inter
 	return tag == ATA_MAX_QUEUE - 1;
 }
 
+/*
+ * device helpers
+ */
 static inline unsigned int ata_class_enabled(unsigned int class)
 {
 	return class == ATA_DEV_ATA || class == ATA_DEV_ATAPI;
@@ -917,6 +920,17 @@ static inline unsigned int ata_dev_absen
 	return ata_class_absent(dev->class);
 }
 
+/*
+ * port helpers
+ */
+static inline int ata_port_max_devices(const struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_SLAVE_POSS)
+		return 2;
+	return 1;
+}
+
+
 static inline u8 ata_chk_status(struct ata_port *ap)
 {
 	return ap->ops->check_status(ap);
-- 
1.3.2


