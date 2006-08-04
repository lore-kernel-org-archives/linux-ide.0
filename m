From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] sata_sil24: don't set probe_ent->mmio_base
Date: Sat, 5 Aug 2006 05:48:46 +0900
Message-ID: <11547245266-git-send-email-htejun@gmail.com>
References: <11547243571730-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:4150 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161443AbWHDUsw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 16:48:52 -0400
Received: by nz-out-0102.google.com with SMTP id n1so107951nzf
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 13:48:51 -0700 (PDT)
In-Reply-To: <11547243571730-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

sata_sil24 doesn't make use of probe_ent->mmio_base and setting this
field causes the area to be released twice on detach.  Don't set
probe_ent->mmio_base.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

f31e945c50e47b7163c6018928aa93b66e8f22f0
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 2e0f4a4..3f368c7 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -1106,7 +1106,6 @@ static int sil24_init_one(struct pci_dev
 
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->mmio_base = port_base;
 	probe_ent->private_data = hpriv;
 
 	hpriv->host_base = host_base;
-- 
1.3.2


