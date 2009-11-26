From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: add comment documenting PIO latency issues on UP
Date: Thu, 26 Nov 2009 17:11:16 +0100
Message-ID: <200911261711.16954.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760770AbZKZQMO@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Based on:
http://lkml.indiana.edu/hypermail/linux/kernel/0908.2/01420.html

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/libata-core.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: b/drivers/ata/libata-core.c
===================================================================
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6624,6 +6624,13 @@ static int __init ata_init(void)
 {
 	ata_parse_force_param();
 
+	/*
+	 * FIXME: In UP case, there is only one workqueue thread and if you
+	 * have more than one PIO device, latency is bloody awful, with
+	 * occasional multi-second "hiccups" as one PIO device waits for
+	 * another.  It's an ugly wart that users DO occasionally complain
+	 * about; luckily most users have at most one PIO polled device.
+	 */
 	ata_wq = create_workqueue("ata");
 	if (!ata_wq)
 		goto free_force_tbl;
