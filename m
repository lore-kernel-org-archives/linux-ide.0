From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] sata_mv: endian annotations
Date: Sun, 21 May 2006 15:51:16 +0400
Message-ID: <20060521115116.GG7930@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:631 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751505AbWEULwO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 May 2006 07:52:14 -0400
Received: by nf-out-0910.google.com with SMTP id c31so283848nfb
        for <linux-ide@vger.kernel.org>; Sun, 21 May 2006 04:52:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/scsi/sata_mv.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -272,32 +272,32 @@ enum chip_type {
 
 /* Command ReQuest Block: 32B */
 struct mv_crqb {
-	u32			sg_addr;
-	u32			sg_addr_hi;
-	u16			ctrl_flags;
-	u16			ata_cmd[11];
+	__le32			sg_addr;
+	__le32			sg_addr_hi;
+	__le16			ctrl_flags;
+	__le16			ata_cmd[11];
 };
 
 struct mv_crqb_iie {
-	u32			addr;
-	u32			addr_hi;
-	u32			flags;
+	__le32			addr;
+	__le32			addr_hi;
+	__le32			flags;
 	u32			len;
-	u32			ata_cmd[4];
+	__le32			ata_cmd[4];
 };
 
 /* Command ResPonse Block: 8B */
 struct mv_crpb {
 	u16			id;
-	u16			flags;
+	__le16			flags;
 	u32			tmstmp;
 };
 
 /* EDMA Physical Region Descriptor (ePRD); A.K.A. SG */
 struct mv_sg {
-	u32			addr;
-	u32			flags_size;
-	u32			addr_hi;
+	__le32			addr;
+	__le32			flags_size;
+	__le32			addr_hi;
 	u32			reserved;
 };
 
@@ -1028,7 +1028,7 @@ static inline unsigned mv_inc_q_index(un
 	return (index + 1) & MV_MAX_Q_DEPTH_MASK;
 }
 
-static inline void mv_crqb_pack_cmd(u16 *cmdw, u8 data, u8 addr, unsigned last)
+static inline void mv_crqb_pack_cmd(__le16 *cmdw, u8 data, u8 addr, unsigned last)
 {
 	u16 tmp = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
 		(last ? CRQB_CMD_LAST : 0);
@@ -1051,7 +1051,7 @@ static void mv_qc_prep(struct ata_queued
 {
 	struct ata_port *ap = qc->ap;
 	struct mv_port_priv *pp = ap->private_data;
-	u16 *cw;
+	__le16 *cw;
 	struct ata_taskfile *tf;
 	u16 flags = 0;
 	unsigned in_index;

