From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/10] sata_sil24: don't use NCQ if marvell 4140 PMP is attached
Date: Mon, 19 May 2008 01:15:13 +0900
Message-ID: <12111273202036-git-send-email-htejun@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:23550 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbYERQPa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:30 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1008619rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:29 -0700 (PDT)
In-Reply-To: <12111273141039-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

When 4140 PMP is attached to sil24, NCQ commands to fan out port 1 and
2 (0 based) often stall if commands are in progress to other ports.
I've tried a number of things but can't tell what's going on.  It
never happens w/ ahci and reportedly sata_mv which can issue NCQ
commands to multiple devices simultaneously like sil24 does.

Disable NCQ for devices behind 4140 PMP for the time being.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>
---
 drivers/ata/sata_sil24.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 27a1101..8ee6b5b 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -899,14 +899,25 @@ static bool sil24_qc_fill_rtf(struct ata_queued_cmd *qc)
 
 static void sil24_pmp_attach(struct ata_port *ap)
 {
+	u32 *gscr = ap->link.device->gscr;
+
 	sil24_config_pmp(ap, 1);
 	sil24_init_port(ap);
+
+	if (sata_pmp_gscr_vendor(gscr) == 0x11ab &&
+	    sata_pmp_gscr_devid(gscr) == 0x4140) {
+		ata_port_printk(ap, KERN_INFO,
+			"disabling NCQ support due to sil24-mv4140 quirk\n");
+		ap->flags &= ~ATA_FLAG_NCQ;
+	}
 }
 
 static void sil24_pmp_detach(struct ata_port *ap)
 {
 	sil24_init_port(ap);
 	sil24_config_pmp(ap, 0);
+
+	ap->flags |= ATA_FLAG_NCQ;
 }
 
 static int sil24_pmp_hardreset(struct ata_link *link, unsigned int *class,
-- 
1.5.2.4

