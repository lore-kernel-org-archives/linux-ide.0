From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: re-initialize parameters before configuring
Date: Wed, 1 Mar 2006 17:20:39 +0900
Message-ID: <11412012393930-git-send-email-htejun@gmail.com>
References: <11412012393192-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:56032 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751714AbWCAIUo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 03:20:44 -0500
Received: by zproxy.gmail.com with SMTP id 16so82811nzp
        for <linux-ide@vger.kernel.org>; Wed, 01 Mar 2006 00:20:44 -0800 (PST)
In-Reply-To: <11412012393192-git-send-email-htejun@gmail.com>
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

ce0cef100691a38180b32a74ce6ab7ca90b390f0
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 63ba1aa..17d113b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1082,6 +1082,15 @@ static int ata_dev_configure(struct ata_
 
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


