From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 86/86] libata: add private driver field to struct ata_device
Date: Wed, 25 Nov 2009 18:12:48 +0100
Message-ID: <20091125171248.5446.22482.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52976 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934853AbZKYRN0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:13:26 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: add private driver field to struct ata_device

This brings struct ata_device in-line with struct ata_{port,host}.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/libata.h |    1 +
 1 file changed, 1 insertion(+)

Index: b/include/linux/libata.h
===================================================================
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -585,6 +585,7 @@ struct ata_device {
 	unsigned int		horkage;	/* List of broken features */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	struct scsi_device	*sdev;		/* attached SCSI device */
+	void			*private_data;
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
 	union acpi_object	*gtf_cache;
