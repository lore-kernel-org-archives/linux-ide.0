From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12] sata_sil24: add hardreset
Date: Tue, 24 Jan 2006 17:05:22 +0900
Message-ID: <11380899222691-git-send-email-htejun@gmail.com>
References: <1138089921565-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:7320 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030360AbWAXIFg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 03:05:36 -0500
Received: by zproxy.gmail.com with SMTP id z6so1191028nzd
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 00:05:36 -0800 (PST)
In-Reply-To: <1138089921565-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Now that libata is smart enough to handle both soft and hard resets,
add hardreset method.  Note that sil24 hardreset doesn't supply
signature; still, the new reset mechanism can make good use of it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

873ad4e86a46fa83982f694d56d2b9e52d0c2b6a
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index f884c31..f2a4e01 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -484,9 +484,18 @@ static int sil24_softreset(struct ata_po
 	return 0;
 }
 
+static int sil24_hardreset(struct ata_port *ap, int verbose,
+			   unsigned int *class)
+{
+	unsigned int dummy_class;
+
+	/* sil24 doesn't report device signature after hard reset */
+	return sata_std_hardreset(ap, verbose, &dummy_class);
+}
+
 static int sil24_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
-	return ata_drive_probe_reset(ap, sil24_softreset, NULL,
+	return ata_drive_probe_reset(ap, sil24_softreset, sil24_hardreset,
 				     ata_std_postreset, classes);
 }
 
-- 
1.1.3


