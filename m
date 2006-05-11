From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/22] libata: fix ->phy_reset class code handling in ata_bus_probe()
Date: Thu, 11 May 2006 20:59:50 +0900
Message-ID: <11473487902319-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:49594 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751566AbWEKMAA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:00 -0400
Received: by py-out-1112.google.com with SMTP id f28so211124pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:00 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_bus_probe() doesn't clear dev->class after ->phy_reset().  This
can result in falsely enabled devices if probing fails.  Clear
dev->class to ATA_DEV_UNKNOWN after fetching it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

2c6d8801ef9205d36d646cd8a0bf81a27b6c46d2
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8ac560c..142a3a8 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1397,9 +1397,11 @@ static int ata_bus_probe(struct ata_port
 	} else {
 		ap->ops->phy_reset(ap);
 
-		if (!(ap->flags & ATA_FLAG_DISABLED))
-			for (i = 0; i < ATA_MAX_DEVICES; i++)
+		for (i = 0; i < ATA_MAX_DEVICES; i++) {
+			if (!(ap->flags & ATA_FLAG_DISABLED))
 				classes[i] = ap->device[i].class;
+			ap->device[i].class = ATA_DEV_UNKNOWN;
+		}
 
 		ata_port_probe(ap);
 	}
-- 
1.2.4


