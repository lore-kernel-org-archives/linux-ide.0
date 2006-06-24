From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/15] libata: clear EH action on device detach
Date: Sat, 24 Jun 2006 20:30:19 +0900
Message-ID: <1151148619969-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:40067 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752218AbWFXLaI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:08 -0400
Received: by nz-out-0102.google.com with SMTP id z31so964563nzd
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:07 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Clear related EH action on device detach such that new device doesn't
receive EH actions scheduled for the old one.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

578e73a7401b8942425bc669ba0f4dcc1b6c8a45
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index c7e6298..bf5a72a 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -734,6 +734,10 @@ static void ata_eh_detach_dev(struct ata
 		ap->flags |= ATA_FLAG_SCSI_HOTPLUG;
 	}
 
+	/* clear per-dev EH actions */
+	ata_eh_clear_action(dev, &ap->eh_info, ATA_EH_PERDEV_MASK);
+	ata_eh_clear_action(dev, &ap->eh_context.i, ATA_EH_PERDEV_MASK);
+
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 
-- 
1.3.2


