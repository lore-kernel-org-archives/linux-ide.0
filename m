From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/6] sata_sil24: rename PORT_PRB to PORT_LRAM and add PORT_LRAM_SLOT_SZ
Date: Sat, 20 May 2006 00:38:10 +0900
Message-ID: <1148053090794-git-send-email-htejun@gmail.com>
References: <11480530901755-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:61782 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932350AbWESPiR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:38:17 -0400
Received: by py-out-1112.google.com with SMTP id z59so963256pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:38:16 -0700 (PDT)
In-Reply-To: <11480530901755-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

PORT_PRB is a misnomer as the area also contains other stuff.  Rename
it to PORT_LRAM and add PORT_LRAM_SLOT_SZ.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

629710d0712433cf74b67881ba62dd398d87e3eb
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 26d7c54..a39e8d0 100644
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
1.3.2


