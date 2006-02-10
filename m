From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/9] sata_sil24: add hardreset
Date: Fri, 10 Feb 2006 23:58:48 +0900
Message-ID: <11395835283599-git-send-email-htejun@gmail.com>
References: <11395835282719-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:32440 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932122AbWBJO7O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 09:59:14 -0500
Received: by wproxy.gmail.com with SMTP id i13so553462wra
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 06:59:13 -0800 (PST)
In-Reply-To: <11395835282719-git-send-email-htejun@gmail.com>
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

1e7c4c83847442f2e881e04e6a3b8f257dcc241e
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index ccac05a..228a7fa 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -485,10 +485,19 @@ static int sil24_softreset(struct ata_po
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
1.1.5


