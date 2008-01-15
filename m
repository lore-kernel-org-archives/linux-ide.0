From: Jeff Garzik <jeff@garzik.org>
Subject: [Fwd: [PATCH] libata fixes]
Date: Mon, 14 Jan 2008 21:13:21 -0500
Message-ID: <478C16C1.8000200@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000202040401020108070402"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45780 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbYAOCNY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jan 2008 21:13:24 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000202040401020108070402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Any comments? ACK?


--------------000202040401020108070402
Content-Type: message/rfc822;
 name="[PATCH] libata fixes.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] libata fixes.eml"

X-Account-Key: account3
X-Mozilla-Keys: 
Return-path: <SRS0=ypXZ=SC=ftp.linux.org.uk=viro@bounce2.pobox.com>
Envelope-to: jgpobox@dvmed.net
Delivery-date: Sat, 12 Jan 2008 14:16:52 +0000
Received: from indigo.pobox.com ([207.106.133.17])
	by mail.dvmed.net with esmtp (Exim 4.66 #1 (Red Hat Linux))
	id 1JDhAD-0000xJ-52
	for jgpobox@dvmed.net; Sat, 12 Jan 2008 14:16:52 +0000
Received: from indigo.pobox.com (localhost [127.0.0.1])
	by indigo.pobox.com (Postfix) with ESMTP id 1EF5063832
	for <jgpobox@dvmed.net>; Sat, 12 Jan 2008 09:17:06 -0500 (EST)
Delivered-To: jgarzik@pobox.com
X-Pobox-Delivery-ID: 
 0D34DC56-C119-11DC-9C04-ED22A8B2A71F-86483764!indigo.pobox.com
x-pobox-client-address: 195.92.253.2
x-pobox-client-name: zeniv.linux.org.uk
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2]) by
 indigo.pobox.com (Postfix) with ESMTP id D086C63875 for <jgarzik@pobox.com>;
 Sat, 12 Jan 2008 09:16:53 -0500 (EST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.63 #1 (Red Hat
 Linux)) id 1JDh9i-00022m-AE for jgarzik@pobox.com; Sat, 12 Jan 2008 14:16:14
 +0000
Date: Sat, 12 Jan 2008 14:16:14 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: jgarzik@pobox.com
Subject: [PATCH] libata fixes
Message-ID: <20080112141614.GJ27894@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Score: -2.6 (--)
X-Spam-Report: SpamAssassin version 3.2.3 on srv5.dvmed.net summary:
	Content analysis details:   (-2.6 points, 5.0 required)

In pata_legacy and pata_winbond we've got bugs - cpu_to_le16() instead
of cpu_to_le32().  Fortunately, both affected suckers are VLB, thus
l-e-only, so we might get away with that unless we hit it with slop == 3
(hadn't checked if playing with badly aligned sg could trigger that).
Still buggy...  Moreover, pata_legacy, pata_winbond and pata_qdi forgot to
initialize pad on the write side of 32bit case in their ->data_xfer().
Hopefully the hardware does't care, but still, sending uninitialized
data to it...
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 7bed8d8..17159b5 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -271,14 +271,12 @@ static void pdc_data_xfer_vlb(struct ata_device *adev, unsigned char *buf, unsig
 			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			u32 pad;
+			__le32 pad = 0;
 			if (write_data) {
 				memcpy(&pad, buf + buflen - slop, slop);
-				pad = le32_to_cpu(pad);
-				iowrite32(pad, ap->ioaddr.data_addr);
+				iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
 			} else {
-				pad = ioread32(ap->ioaddr.data_addr);
-				pad = cpu_to_le16(pad);
+				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
 				memcpy(buf + buflen - slop, &pad, slop);
 			}
 		}
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 7d4c696..a4c0e50 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -136,14 +136,12 @@ static void qdi_data_xfer(struct ata_device *adev, unsigned char *buf, unsigned
 			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			u32 pad;
+			__le32 pad = 0;
 			if (write_data) {
 				memcpy(&pad, buf + buflen - slop, slop);
-				pad = le32_to_cpu(pad);
-				iowrite32(pad, ap->ioaddr.data_addr);
+				iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
 			} else {
-				pad = ioread32(ap->ioaddr.data_addr);
-				pad = cpu_to_le32(pad);
+				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
 				memcpy(buf + buflen - slop, &pad, slop);
 			}
 		}
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 311cdb3..7116a9e 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -104,14 +104,12 @@ static void winbond_data_xfer(struct ata_device *adev, unsigned char *buf, unsig
 			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			u32 pad;
+			__le32 pad = 0;
 			if (write_data) {
 				memcpy(&pad, buf + buflen - slop, slop);
-				pad = le32_to_cpu(pad);
-				iowrite32(pad, ap->ioaddr.data_addr);
+				iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
 			} else {
-				pad = ioread32(ap->ioaddr.data_addr);
-				pad = cpu_to_le16(pad);
+				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
 				memcpy(buf + buflen - slop, &pad, slop);
 			}
 		}


--------------000202040401020108070402--
