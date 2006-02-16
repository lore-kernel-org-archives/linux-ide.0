From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: fix sata_sil24 mwdma_mask setting
Date: Thu, 16 Feb 2006 23:09:06 +0900
Message-ID: <11400989462360-git-send-email-htejun@gmail.com>
References: <43F3244B.2010600@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.199]:5066 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932260AbWBPOJM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2006 09:09:12 -0500
Received: by xproxy.gmail.com with SMTP id h28so117519wxd
        for <linux-ide@vger.kernel.org>; Thu, 16 Feb 2006 06:09:11 -0800 (PST)
In-Reply-To: <43F3244B.2010600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

mwdma_mask was not copied from port_info to probe_ent.  This bug is
probably introduced by following ahci.c without thinking.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

bc7de87cd24b47b5480d928755dd7c08f4d43b03
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index a0e35a2..1c54736 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -891,6 +891,7 @@ static int sil24_init_one(struct pci_dev
 	probe_ent->sht		= pinfo->sht;
 	probe_ent->host_flags	= pinfo->host_flags;
 	probe_ent->pio_mask	= pinfo->pio_mask;
+	probe_ent->mwdma_mask	= pinfo->mwdma_mask;
 	probe_ent->udma_mask	= pinfo->udma_mask;
 	probe_ent->port_ops	= pinfo->port_ops;
 	probe_ent->n_ports	= SIL24_FLAG2NPORTS(pinfo->host_flags);
-- 
1.1.5


