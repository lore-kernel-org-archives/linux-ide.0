From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream] libata: add printf format attribute to ehi desc functions
Date: Sun, 29 Jul 2007 19:02:49 +0900
Message-ID: <20070729100249.GF22374@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:64967 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759255AbXG2KCz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 06:02:55 -0400
Received: by rv-out-0910.google.com with SMTP id k20so261848rvb
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 03:02:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tell the compiler that [__]ata_ehi_push_desc() functions take printf
style format string and arguments.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 include/linux/libata.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -914,8 +914,10 @@ extern void ata_do_eh(struct ata_port *a
 /*
  * ata_eh_info helpers
  */
-extern void __ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...);
-extern void ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...);
+extern void __ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+extern void ata_ehi_push_desc(struct ata_eh_info *ehi, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
 extern void ata_ehi_clear_desc(struct ata_eh_info *ehi);
 
 static inline void ata_ehi_schedule_probe(struct ata_eh_info *ehi)
