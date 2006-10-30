From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: [PATCH] Added S.M.A.R.T. command decoding to libata error reporting.
Date: Mon, 30 Oct 2006 01:09:20 -0500
Message-ID: <76366b180610292209u3202a77bqdfe1b6c46eea74da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:3784 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161122AbWJ3GJW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Oct 2006 01:09:22 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1058348ugm
        for <linux-ide@vger.kernel.org>; Sun, 29 Oct 2006 22:09:20 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Added S.M.A.R.T. command decoding to libata error reporting.

This is useful because if a user program attempts to send an
invalid smart command, the standard reporting only indicates
that cmd 0xb0 (now ATA_CMD_SMART) failed. This code prints out
a readable string indicating which smart cmd was attempted as
encoded in tf.feature per the ATAPI spec.

Example with patch applied:
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
ata1.00: smart cmd 0xd2 (enable/disable attribute autosave)

---
 drivers/ata/libata-eh.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ata.h     |    1 +
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 02b2b27..dd93ab8 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -849,6 +849,46 @@ static const char * ata_err_string(unsig
 }

 /**
+ *     ata_smart_feature - convert feature code to descriptive string
+ *     @feature: feature byte to convert to string
+ *
+ *     Convert @feature to descriptive string. SMART command features
+ *     are located in the ATAPI specification.
+ *
+ *     LOCKING:
+ *     None.
+ *
+ *     RETURNS:
+ *     Descriptive string for @feature
+ */
+static const char * ata_smart_feature(u8 feature)
+{
+       switch (feature) {
+               case 0xD0:
+                       return "read data";
+               case 0xD2:
+                       return "enable/disable attribute autosave";
+               case 0xD4:
+                       return "execute off-line immediate";
+               case 0xD5:
+                       return "read log";
+               case 0xD6:
+                       return "write log";
+               case 0xD8:
+                       return "enable operations";
+               case 0xD9:
+                       return "disable operations";
+               case 0xDA:
+                       return "return status";
+               default:
+                       if (feature >= 0xE0)
+                               return "vendor specific feature";
+                       else
+                               return "obsolete or reserved feature";
+       }
+}
+
+/**
  *     ata_read_log_page - read a specific log page
  *     @dev: target device
  *     @page: page to read
@@ -1443,6 +1483,12 @@ static void ata_eh_report(struct ata_por
                               qc->tag, qc->tf.command, qc->err_mask,
                               qc->result_tf.command, qc->result_tf.feature,
                               ata_err_string(qc->err_mask));
+
+               if (qc->tf.command == ATA_CMD_SMART)
+                   ata_dev_printk(qc->dev, KERN_ERR, "smart "
+                                  "cmd 0x%02x (%s)\n",
+                                  qc->tf.feature,
+                                  ata_smart_feature(qc->tf.feature));
        }
 }

diff --git a/include/linux/ata.h b/include/linux/ata.h
index d894419..46dd849 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -156,6 +156,7 @@ enum {
        ATA_CMD_READ_NATIVE_MAX = 0xF8,
        ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
        ATA_CMD_READ_LOG_EXT    = 0x2f,
+       ATA_CMD_SMART           = 0xB0,

        /* READ_LOG_EXT pages */
        ATA_LOG_SATA_NCQ        = 0x10,
-- 
1.4.1.1
