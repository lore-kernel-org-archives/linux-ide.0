From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 1/2] libata: align ap->sector_buf
Date: Mon, 02 Mar 2009 18:53:26 +0900
Message-ID: <49ABAC96.3060109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35031 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758203AbZCBJxb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Mar 2009 04:53:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Chuck Ebbert <cebbert@redhat.com>, Robert Hancock <hancockr@shaw.ca>, FUJITA Tomonori <fujita.tom>

ap->sector_buf is used as DMA target and should at least be aligned on
cacheline.  This caused problems on some embedded machines.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/libata.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index c82695d..4234973 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -750,7 +750,8 @@ struct ata_port {
 	acpi_handle		acpi_handle;
 	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
-	u8			sector_buf[ATA_SECT_SIZE]; /* owned by EH */
+	/* owned by EH */
+	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
 };
 
 /* The following initializer overrides a method to NULL whether one of
