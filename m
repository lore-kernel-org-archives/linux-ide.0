From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/7] libata: add 5s sleep between resets
Date: Sun, 2 Apr 2006 20:55:02 +0900
Message-ID: <20060402115502.GB19569@htj.dyndns.org>
References: <11439680863256-git-send-email-htejun@gmail.com> <11439680861847-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.200]:11451 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932334AbWDBLzI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 07:55:08 -0400
Received: by xproxy.gmail.com with SMTP id t10so674603wxc
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 04:55:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <11439680861847-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Some devices react badly if resets are performed back-to-back.  Give
devices some time to breath and tell user that we're taking a nap.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

The last message was missing '\n'.  Other than that, identical patch.

 libata-core.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2006-04-02 20:38:21.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2006-04-02 20:38:21.000000000 +0900
@@ -2585,6 +2585,9 @@ int ata_drive_probe_reset(struct ata_por
 		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
 		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
 			goto done;
+		printk(KERN_INFO "ata%u: softreset failed, will try "
+		       "hardreset in 5 secs\n", ap->id);
+		ssleep(5);
 	}
 
 	if (!hardreset)
@@ -2600,10 +2603,20 @@ int ata_drive_probe_reset(struct ata_por
 
 		if (ata_down_sata_spd_limit(ap))
 			goto done;
+
+		printk(KERN_INFO "ata%u: hardreset failed, will retry "
+		       "in 5 secs\n", ap->id);
+		ssleep(5);
 	}
 
-	if (softreset)
+	if (softreset) {
+		printk(KERN_INFO "ata%u: hardreset succeeded without "
+		       "classification, will retry softreset in 5 secs\n",
+		       ap->id);
+		ssleep(5);
+
 		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
+	}
 
  done:
 	if (rc == 0 && classes[0] == ATA_DEV_UNKNOWN)
