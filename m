From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] ahci: make ahci_fill_cmd_slot() take *pp instead of *ap
Date: Sat, 11 Feb 2006 16:26:02 +0900
Message-ID: <11396427621762-git-send-email-htejun@gmail.com>
References: <11396427621534-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:11914 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932256AbWBKH0H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Feb 2006 02:26:07 -0500
Received: by zproxy.gmail.com with SMTP id i28so611941nzi
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 23:26:05 -0800 (PST)
In-Reply-To: <11396427621534-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ahci_fill_cmd_slot() take struct ahci_port_priv *pp instead of
struct ata_port *ap as suggested by Jeff Garzik.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

47c10126810dfdd091c2ff3f6316cab4ff504e5e
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 98ce6bb..72bdd43 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -507,9 +507,8 @@ static unsigned int ahci_dev_classify(st
 	return ata_dev_classify(&tf);
 }
 
-static void ahci_fill_cmd_slot(struct ata_port *ap, u32 opts)
+static void ahci_fill_cmd_slot(struct ahci_port_priv *pp, u32 opts)
 {
-	struct ahci_port_priv *pp = ap->private_data;
 	pp->cmd_slot[0].opts = cpu_to_le32(opts);
 	pp->cmd_slot[0].status = 0;
 	pp->cmd_slot[0].tbl_addr = cpu_to_le32(pp->cmd_tbl_dma & 0xffffffff);
@@ -622,7 +621,7 @@ static void ahci_qc_prep(struct ata_queu
 	if (is_atapi)
 		opts |= AHCI_CMD_ATAPI;
 
-	ahci_fill_cmd_slot(ap, opts);
+	ahci_fill_cmd_slot(pp, opts);
 }
 
 static void ahci_restart_port(struct ata_port *ap, u32 irq_stat)
-- 
1.1.5


