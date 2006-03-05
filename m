From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/6] sata_sil: use kzalloc
Date: Sun, 5 Mar 2006 16:03:52 +0900
Message-ID: <11415422321622-git-send-email-htejun@gmail.com>
References: <11415422323592-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:14354 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751910AbWCEHD4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 02:03:56 -0500
Received: by pproxy.gmail.com with SMTP id x66so608695pye
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 23:03:56 -0800 (PST)
In-Reply-To: <11415422323592-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use kzalloc instead of kmalloc/memset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

329b9143f3e901977aed81c1593b06dda52bb090
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 0d962a4..b5401fa 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -406,13 +406,12 @@ static int sil_init_one (struct pci_dev 
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	INIT_LIST_HEAD(&probe_ent->node);
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	probe_ent->port_ops = sil_port_info[ent->driver_data].port_ops;
-- 
1.2.1


