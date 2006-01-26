From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/16] libata: re-initialize parameters before configuring
Date: Fri, 27 Jan 2006 00:39:12 +0900
Message-ID: <11382899521388-git-send-email-htejun@gmail.com>
References: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:21074 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964774AbWAZPja (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:39:30 -0500
Received: by zproxy.gmail.com with SMTP id 34so372383nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:39:30 -0800 (PST)
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

In ata_dev_configure(), reinitialize parameters before configuring.
This change is for revalidation and hotplug.  As ata_dev_configure()
can be entered multiple times, parameters need to be reinitialized.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

403e45409fde12b368ad951e40e8ad0f4769b521
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ab6b38c..9b1d225 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1462,6 +1462,15 @@ static int ata_dev_configure(struct ata_
 
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
1.1.3


