From: akpm@linux-foundation.org
Subject: [patch 3/3] libata: reorder ata_device to remove 8 bytes of padding on 64 bits
Date: Mon, 22 Sep 2008 14:47:13 -0700
Message-ID: <200809222147.m8MLlDGd031662@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58401 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754098AbYIVVsT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 17:48:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, richard@rsk.demon.co.uk

From: Richard Kennedy <richard@rsk.demon.co.uk>

reduce size by 8 bytes from 1160 to 1152 allowing it to fit in 1 fewer
cachelines.

Signed-off-by: Richard Kennedy <richard@rsk.demon.co.uk>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/libata.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/libata.h~libata-reorder-ata_device-to-remove-8-bytes-of-padding-on-64-bits include/linux/libata.h
--- a/include/linux/libata.h~libata-reorder-ata_device-to-remove-8-bytes-of-padding-on-64-bits
+++ a/include/linux/libata.h
@@ -554,8 +554,8 @@ struct ata_ering {
 struct ata_device {
 	struct ata_link		*link;
 	unsigned int		devno;		/* 0 or 1 */
-	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		horkage;	/* List of broken features */
+	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	struct scsi_device	*sdev;		/* attached SCSI device */
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
_
