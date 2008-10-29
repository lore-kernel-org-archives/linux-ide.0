From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-gd: re-get floppy capacity on revalidate
Date: Wed, 29 Oct 2008 08:42:20 +0100
Message-ID: <20081029074220.GA11117@gollum.tnic>
References: <20081029071319.GA9205@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:8779 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbYJ2HmX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 03:42:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2653003fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:42:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081029071319.GA9205@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: Tejun Heo <tj@kernel.org>, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi Bart,

by the way we need to following in ide-gd otherwise
rescan_partitions returns early due to the capacity being 0.

---
From: Borislav Petkov <petkovbb@gmail.com>
Subject: ide-gd: re-get capacity on revalidate

We need to re-get a removable media's capacity when revalidating the
disk so that its partitions get rescanned by the block layer.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index 7b66628..b8078b3 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -281,7 +281,12 @@ static int ide_gd_media_changed(struct gendisk *disk)
 static int ide_gd_revalidate_disk(struct gendisk *disk)
 {
 	struct ide_disk_obj *idkp = ide_drv_g(disk, ide_disk_obj);
-	set_capacity(disk, ide_gd_capacity(idkp->drive));
+	ide_drive_t *drive = idkp->drive;
+
+	if (ide_gd_media_changed(disk))
+		drive->disk_ops->get_capacity(drive);
+
+	set_capacity(disk, ide_gd_capacity(drive));
 	return 0;
 }
 
-- 
Regards/Gruss,
    Boris.
