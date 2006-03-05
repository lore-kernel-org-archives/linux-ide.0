From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: re-initialize parameters before configuring
Date: Sun, 5 Mar 2006 17:55:58 +0900
Message-ID: <11415489581177-git-send-email-htejun@gmail.com>
References: <11415489584127-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:32094 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752157AbWCEI4E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 03:56:04 -0500
Received: by pproxy.gmail.com with SMTP id x31so574349pye
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 00:56:03 -0800 (PST)
In-Reply-To: <11415489584127-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

In ata_dev_configure(), reinitialize parameters before configuring.
This change is for revalidation and hotplug.  As ata_dev_configure()
can be entered multiple times, parameters need to be reinitialized.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

1c25bf6bd9a1176c2510d27868e475e2c0a801ff
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b710fc4..5982849 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1086,6 +1086,15 @@ static int ata_dev_configure(struct ata_
 
 	DPRINTK("ENTER, host %u, dev %u\n", ap->id, dev->devno);
 
+	/* initialize to-be-configured parameters */
+	dev->flags = 0;
+	dev->max_sectors = 0;
+	dev->cdb_len = 0;
+	dev->n_sectors = 0;
+	dev->cylinders = 0;
+	dev->heads = 0;
+	dev->sectors = 0;
+
 	/*
 	 * common ATA, ATAPI feature tests
 	 */
-- 
1.2.1


