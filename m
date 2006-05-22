From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv: endian annotations
Date: Mon, 22 May 2006 18:56:18 -0400
Message-ID: <200605221856.18673.liml@rtr.ca>
References: <20060521115116.GG7930@mipter.zuzino.mipt.ru> <44715C16.5070600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1493 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750715AbWEVW4U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 18:56:20 -0400
In-Reply-To: <44715C16.5070600@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-ide@vger.kernel.org

On Monday 22 May 2006 02:37, Jeff Garzik wrote:
> Alexey Dobriyan wrote:
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Unless Mark objects, I'll merge this into #upstream (2.6.18) soon.
> 
> 	Jeff

Well, if we're going to use the endian annotation types,
then we may as well mark *all* of the __le* hardware fields,
not just a few of them.

Thus, this extended version of Alexey's original patch:

Signed-off-by: Mark Lord <liml@rtr.ca>

---
--- linux/drivers/scsi/sata_mv.c	2006-05-19 15:59:51.000000000 -0400
+++ linux/drivers/scsi/sata_mv.c	2006-05-22 18:52:37.000000000 -0400
@@ -272,33 +272,33 @@
 
 /* Command ReQuest Block: 32B */
 struct mv_crqb {
-	u32			sg_addr;
-	u32			sg_addr_hi;
-	u16			ctrl_flags;
-	u16			ata_cmd[11];
+	__u32			sg_addr;
+	__u32			sg_addr_hi;
+	__u16			ctrl_flags;
+	__u16			ata_cmd[11];
 };
 
 struct mv_crqb_iie {
-	u32			addr;
-	u32			addr_hi;
-	u32			flags;
-	u32			len;
-	u32			ata_cmd[4];
+	__u32			addr;
+	__u32			addr_hi;
+	__u32			flags;
+	__u32			len;
+	__u32			ata_cmd[4];
 };
 
 /* Command ResPonse Block: 8B */
 struct mv_crpb {
-	u16			id;
-	u16			flags;
-	u32			tmstmp;
+	__u16			id;
+	__u16			flags;
+	__u32			tmstmp;
 };
 
 /* EDMA Physical Region Descriptor (ePRD); A.K.A. SG */
 struct mv_sg {
-	u32			addr;
-	u32			flags_size;
-	u32			addr_hi;
-	u32			reserved;
+	__u32			addr;
+	__u32			flags_size;
+	__u32			addr_hi;
+	__u32			reserved;
 };
 
 struct mv_port_priv {
@@ -1028,7 +1028,7 @@
 	return (index + 1) & MV_MAX_Q_DEPTH_MASK;
 }
 
-static inline void mv_crqb_pack_cmd(u16 *cmdw, u8 data, u8 addr, unsigned last)
+static inline void mv_crqb_pack_cmd(__u16 *cmdw, u8 data, u8 addr, unsigned last)
 {
 	u16 tmp = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
 		(last ? CRQB_CMD_LAST : 0);
@@ -1051,7 +1051,7 @@
 {
 	struct ata_port *ap = qc->ap;
 	struct mv_port_priv *pp = ap->private_data;
-	u16 *cw;
+	__u16 *cw;
 	struct ata_taskfile *tf;
 	u16 flags = 0;
 	unsigned in_index;
