From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH v2] libata-sff: use ATAPI_{COD|IO}
Date: Fri, 2 Dec 2011 18:39:53 +0300
Message-ID: <201112021839.53516.sshtylyov@ru.mvista.com>
References: <201112011853.28829.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:47314 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756761Ab1LBOky (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2011 09:40:54 -0500
In-Reply-To: <201112011853.28829.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

atapi_pio_bytes() uses bare numbers for the ATAPI interrupt reason bits despite
these are #define'd in <linux/ata.h>.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' tree.

Changes in v2: corrected typo in the patch description.

 drivers/ata/libata-sff.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ata/libata-sff.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-sff.c
+++ linux-2.6/drivers/ata/libata-sff.c
@@ -929,11 +929,11 @@ static void atapi_pio_bytes(struct ata_q
 	bytes = (bc_hi << 8) | bc_lo;
 
 	/* shall be cleared to zero, indicating xfer of data */
-	if (unlikely(ireason & (1 << 0)))
+	if (unlikely(ireason & ATAPI_COD))
 		goto atapi_check;
 
 	/* make sure transfer direction matches expected */
-	i_write = ((ireason & (1 << 1)) == 0) ? 1 : 0;
+	i_write = ((ireason & ATAPI_IO) == 0) ? 1 : 0;
 	if (unlikely(do_write != i_write))
 		goto atapi_check;
 
