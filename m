From: akpm@linux-foundation.org
Subject: [patch for 2.6.33? 1/1] ata: call flush_dcache_page() around PIO data transfers in libata-aff.c
Date: Tue, 02 Feb 2010 14:11:08 -0800
Message-ID: <201002022211.o12MB8cJ017441@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47479 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756995Ab0BBWNR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Feb 2010 17:13:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, jgarzik@pobox.com, stable@kernel.org, tj@kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

Depending on the direction of the transfer, flush_dcache_page() must be
called either before (ATA_TFLAG_WRITE) or after (!ATA_TFLAG_WRITE) the
data copying to avoid D-cache aliasing with user space or I-D cache
coherency issues (when reading data from an ATA device using PIO, the
kernel dirties the D-cache but there is no flush_dcache_page() required on
Harvard architectures).

This patch allows the ARM boards to use a rootfs on CompactFlash with the
PATA platform driver.

As Anfei Zhou mentioned in a recent patch ("flush dcache before writing
into page to avoid alias"), on some architectures there may be a
performance benefit in differentiating the flush_dcache_page() calls based
on whether the kernel or the user page needs flushing.

IMHO, we should differentiate based on the direction (kernel reading or
writing from/to such page).  In the ARM case with PIPT Harvard caches
(newer processors), the kernel reading from a page that may be mapped in
user space shouldn't need cache flushing.  The kernel writing to such page
would require D-cache flushing because of coherency with the I-cache. 
Currently on ARM, the latter happens in both cases.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-sff.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff -puN drivers/ata/libata-sff.c~ata-call-flush_dcache_page-around-pio-data-transfers-in-libata-affc drivers/ata/libata-sff.c
--- a/drivers/ata/libata-sff.c~ata-call-flush_dcache_page-around-pio-data-transfers-in-libata-affc
+++ a/drivers/ata/libata-sff.c
@@ -874,6 +874,9 @@ static void ata_pio_sector(struct ata_qu
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
+	if (do_write)
+		flush_dcache_page(page);
+
 	if (PageHighMem(page)) {
 		unsigned long flags;
 
@@ -893,6 +896,9 @@ static void ata_pio_sector(struct ata_qu
 				       do_write);
 	}
 
+	if (!do_write)
+		flush_dcache_page(page);
+
 	qc->curbytes += qc->sect_size;
 	qc->cursg_ofs += qc->sect_size;
 
_
