From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ide: add dcache flushing after PIO
Date: Wed, 21 Dec 2005 23:00:22 +0900
Message-ID: <20051221140022.GA25001@htj.dyndns.org>
References: <9DA102EC128AD511BED000306E0766C70180487A@WTCNT4GW> <43A7FE89.4040909@gmail.com> <58cb370e0512200823g50de6e14n148e27e4a4c267f7@mail.gmail.com> <20051221094847.GA12279@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:35018 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932419AbVLUOA2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Dec 2005 09:00:28 -0500
Received: by zproxy.gmail.com with SMTP id 14so161786nzn
        for <linux-ide@vger.kernel.org>; Wed, 21 Dec 2005 06:00:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20051221094847.GA12279@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: James Steward <james.steward@dynamicratings.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, rmk+lkml@arm.linux.org.uk

Block drivers are responsible for cache coherency before and after IO.
When using DMA, DMA API takes care of it but drivers should do manual
flushing with PIO.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 9e293c8..4fb0d9d 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -617,6 +617,7 @@ static void idefloppy_input_buffers (ide
 
 			data = bvec_kmap_irq(bvec, &flags);
 			drive->hwif->atapi_input_bytes(drive, data, count);
+			flush_dcache_page(bvec->page);
 			bvec_kunmap_irq(data, &flags);
 
 			bcount -= count;
@@ -650,6 +651,7 @@ static void idefloppy_output_buffers (id
 			count = min(bvec->bv_len, bcount);
 
 			data = bvec_kmap_irq(bvec, &flags);
+			flush_dcache_page(bvec->page);
 			drive->hwif->atapi_output_bytes(drive, data, count);
 			bvec_kunmap_irq(data, &flags);
 
diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index 62ebefd..78256d9 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -278,6 +278,8 @@ static void ide_pio_sector(ide_drive_t *
 	local_irq_save(flags);
 #endif
 	buf = kmap_atomic(page, KM_BIO_SRC_IRQ) + offset;
+	if (write)
+		flush_dcache_page(page);
 
 	hwif->nleft--;
 	hwif->cursg_ofs++;
@@ -293,6 +295,8 @@ static void ide_pio_sector(ide_drive_t *
 	else
 		taskfile_input_data(drive, buf, SECTOR_WORDS);
 
+	if (!write)
+		flush_dcache_page(page);
 	kunmap_atomic(buf, KM_BIO_SRC_IRQ);
 #ifdef CONFIG_HIGHMEM
 	local_irq_restore(flags);
