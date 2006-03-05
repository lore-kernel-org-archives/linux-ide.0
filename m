From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil24: fix mwdma_mask setting
Date: Sun, 5 Mar 2006 23:03:42 +0900
Message-ID: <20060305140342.GA7702@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:37704 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932093AbWCEODr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 09:03:47 -0500
Received: by pproxy.gmail.com with SMTP id e30so636552pya
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 06:03:46 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

mwdma_mask was not copied from port_info to probe_ent.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This bug is probably introduced by following ahci.c without thinking
(by me).

 drivers/scsi/sata_sil24.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 5c5822e..8fb6242 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -892,6 +892,7 @@ static int sil24_init_one(struct pci_dev
 	probe_ent->sht		= pinfo->sht;
 	probe_ent->host_flags	= pinfo->host_flags;
 	probe_ent->pio_mask	= pinfo->pio_mask;
+	probe_ent->mwdma_mask	= pinfo->mwdma_mask;
 	probe_ent->udma_mask	= pinfo->udma_mask;
 	probe_ent->port_ops	= pinfo->port_ops;
 	probe_ent->n_ports	= SIL24_FLAG2NPORTS(pinfo->host_flags);
