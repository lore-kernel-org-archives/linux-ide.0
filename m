From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/11] sata_sil24: add hardreset
Date: Thu, 2 Feb 2006 18:20:00 +0900
Message-ID: <11388720002336-git-send-email-htejun@gmail.com>
References: <11388720003793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:10653 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423409AbWBBJUM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 04:20:12 -0500
Received: by wproxy.gmail.com with SMTP id i30so336637wra
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2006 01:20:11 -0800 (PST)
In-Reply-To: <11388720003793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that libata is smart enough to handle both soft and hard resets,
add hardreset method.  Note that sil24 hardreset doesn't supply
signature; still, the new reset mechanism can make good use of it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

8ef9da7d26ee574c1d719609c86b6c86543ab496
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index a529628..c2df4b6 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -484,10 +484,19 @@ static int sil24_softreset(struct ata_po
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
 	return ata_drive_probe_reset(ap, ata_std_probeinit,
-				     sil24_softreset, NULL,
+				     sil24_softreset, sil24_hardreset,
 				     ata_std_postreset, classes);
 }
 
-- 
1.1.3


