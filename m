From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH 1/2] libata: don't flush dcache on slab pages
Date: Sun, 21 Mar 2010 22:52:23 +0100
Message-ID: <20100321215222.GA27709@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:34733 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753308Ab0CUVwZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Mar 2010 17:52:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

page_mapping() check this via VM_BUG_ON(PageSlab(page)) so we bug here
with the according debuging turned on.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 drivers/ata/libata-sff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 561dec2..83ecf48 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -893,7 +893,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 				       do_write);
 	}
 
-	if (!do_write)
+	if (!do_write && !PageSlab(page))
 		flush_dcache_page(page);
 
 	qc->curbytes += qc->sect_size;
-- 
1.6.6

