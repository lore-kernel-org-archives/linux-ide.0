From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 18/22] ide-acpi: remove needless exports
Date: Thu, 17 Jan 2008 00:28:11 +0100
Message-ID: <20080116232811.9166.38451.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:10937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684AbYAPXPb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:15:31 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275986ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:15:30 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c |    4 ----
 1 file changed, 4 deletions(-)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -494,7 +494,6 @@ int ide_acpi_exec_tfs(ide_drive_t *drive
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ide_acpi_exec_tfs);
 
 /**
  * ide_acpi_get_timing - get the channel (controller) timings
@@ -580,7 +579,6 @@ void ide_acpi_get_timing(ide_hwif_t *hwi
 
 	kfree(output.pointer);
 }
-EXPORT_SYMBOL_GPL(ide_acpi_get_timing);
 
 /**
  * ide_acpi_push_timing - set the channel (controller) timings
@@ -634,7 +632,6 @@ void ide_acpi_push_timing(ide_hwif_t *hw
 	}
 	DEBPRINT("_STM status: %d\n", status);
 }
-EXPORT_SYMBOL_GPL(ide_acpi_push_timing);
 
 /**
  * ide_acpi_set_state - set the channel power state
@@ -762,4 +759,3 @@ void ide_acpi_init(ide_hwif_t *hwif)
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(ide_acpi_init);
