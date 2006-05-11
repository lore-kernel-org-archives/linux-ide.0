From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/6] sata_sil24: rename PORT_PRB to PORT_LRAM and add PORT_LRAM_SLOT_SZ
Date: Fri, 12 May 2006 00:11:59 +0900
Message-ID: <11473603192587-git-send-email-htejun@gmail.com>
References: <1147360318920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:44528 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751849AbWEKPMJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:12:09 -0400
Received: by nz-out-0102.google.com with SMTP id 13so224767nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:12:09 -0700 (PDT)
In-Reply-To: <1147360318920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

PORT_PRB is a misnomer as the area also contains other stuff.  Rename
it to PORT_LRAM and add PORT_LRAM_SLOT_SZ.

---

 drivers/scsi/sata_sil24.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

7b6eafd6c25c22b66aa7dd610099569596606a1c
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 4747047..629679e 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -98,7 +98,9 @@ enum {
 	 * (8192 bytes @ +0x0000, +0x2000, +0x4000 and +0x6000 @ BAR2)
 	 */
 	PORT_REGS_SIZE		= 0x2000,
-	PORT_PRB		= 0x0000, /* (32 bytes PRB + 16 bytes SGEs * 6) * 31 (3968 bytes) */
+
+	PORT_LRAM		= 0x0000, /* 31 LRAM slots and PM regs */
+	PORT_LRAM_SLOT_SZ	= 0x0080, /* 32 bytes PRB + 2 SGE, ACT... */
 
 	PORT_PM			= 0x0f80, /* 8 bytes PM * 16 (128 bytes) */
 		/* 32 bit regs */
@@ -1103,7 +1105,7 @@ static int sil24_init_one(struct pci_dev
 		void __iomem *port = port_base + i * PORT_REGS_SIZE;
 		unsigned long portu = (unsigned long)port;
 
-		probe_ent->port[i].cmd_addr = portu + PORT_PRB;
+		probe_ent->port[i].cmd_addr = portu;
 		probe_ent->port[i].scr_addr = portu + PORT_SCONTROL;
 
 		ata_std_ports(&probe_ent->port[i]);
-- 
1.2.4


