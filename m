From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/8] ide-acpi: cleanup do_drive_set_taskfiles()
Date: Sun, 11 Jan 2009 20:12:00 +0100
Message-ID: <20090111191200.17361.86841.sendpatchset@localhost.localdomain>
References: <20090111191120.17361.69981.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:36460 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136AbZAKTLH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 14:11:07 -0500
In-Reply-To: <20090111191120.17361.69981.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-acpi: cleanup do_drive_set_taskfiles()

* ide_noacpi is already checked by ide_acpi_exec_tfs()
  which is the only user of do_drive_set_taskfiles().

* ide_acpi_exec_tfs() prints sufficient debug info about the
  device so no need to do it again.

* do_drive_get_GTF() + ide_acpi_exec_tfs() make sure that this
  function will never be called with incorrect gtf_length argument
  or if device is not present.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-acpi.c |   21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

Index: b/drivers/ide/ide-acpi.c
===================================================================
--- a/drivers/ide/ide-acpi.c
+++ b/drivers/ide/ide-acpi.c
@@ -340,32 +340,14 @@ static int do_drive_set_taskfiles(ide_dr
 				  unsigned int gtf_length,
 				  unsigned long gtf_address)
 {
-	int			rc = -ENODEV, err;
+	int			rc = 0, err;
 	int			gtf_count = gtf_length / REGS_PER_GTF;
 	int			ix;
 	struct taskfile_array	*gtf;
 
-	if (ide_noacpi)
-		return 0;
-
-	DEBPRINT("ENTER: %s, hard_port#: %d\n", drive->name, drive->dn);
-
-	if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0)
-		goto out;
-
-	if (!gtf_count)		/* shouldn't be here */
-		goto out;
-
 	DEBPRINT("total GTF bytes=%u (0x%x), gtf_count=%d, addr=0x%lx\n",
 		 gtf_length, gtf_length, gtf_count, gtf_address);
 
-	if (gtf_length % REGS_PER_GTF) {
-		printk(KERN_ERR "%s: unexpected GTF length (%d)\n",
-		       __func__, gtf_length);
-		goto out;
-	}
-
-	rc = 0;
 	for (ix = 0; ix < gtf_count; ix++) {
 		gtf = (struct taskfile_array *)
 			(gtf_address + ix * REGS_PER_GTF);
@@ -376,7 +358,6 @@ static int do_drive_set_taskfiles(ide_dr
 			rc = err;
 	}
 
-out:
 	return rc;
 }
 
