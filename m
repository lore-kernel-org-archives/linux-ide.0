From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] sata_sil24: endian anotations
Date: Tue, 6 Jun 2006 07:31:14 +0400
Message-ID: <20060606033114.GA7268@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:51653 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751046AbWFFDbN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jun 2006 23:31:13 -0400
Received: by nf-out-0910.google.com with SMTP id b2so1613005nfe
        for <linux-ide@vger.kernel.org>; Mon, 05 Jun 2006 20:31:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Andew Morton <akpm@osdl.org>

With help from Tejun Heo.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Better patch instead of sata_sil24-endian-annotations.patch

 drivers/scsi/sata_sil24.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -37,9 +37,9 @@
  * Port request block (PRB) 32 bytes
  */
 struct sil24_prb {
-	u16	ctrl;
-	u16	prot;
-	u32	rx_cnt;
+	__le16	ctrl;
+	__le16	prot;
+	__le32	rx_cnt;
 	u8	fis[6 * 4];
 };
 
@@ -47,17 +47,17 @@ struct sil24_prb {
  * Scatter gather entry (SGE) 16 bytes
  */
 struct sil24_sge {
-	u64	addr;
-	u32	cnt;
-	u32	flags;
+	__le64	addr;
+	__le32	cnt;
+	__le32	flags;
 };
 
 /*
  * Port multiplier
  */
 struct sil24_port_multiplier {
-	u32	diag;
-	u32	sactive;
+	__le32	diag;
+	__le32	sactive;
 };
 
 enum {

