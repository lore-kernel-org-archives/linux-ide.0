From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCHv2] ata: endianness annotations in pata drivers
Date: Wed, 18 Jun 2008 17:16:43 -0700
Message-ID: <1213834603.2125.34.camel@brick>
References: <1213829582.2125.24.camel@brick>
	 <20080618233332.GN28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:25699 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098AbYFSAQm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2008 20:16:42 -0400
Received: by wa-out-1112.google.com with SMTP id j37so368654waf.23
        for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2008 17:16:42 -0700 (PDT)
In-Reply-To: <20080618233332.GN28946@ZenIV.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>

drivers/ata/pata_qdi.c:142:9: warning: incorrect type in assignment (different base types)
drivers/ata/pata_qdi.c:142:9:    expected unsigned int [unsigned] [usertype] pad
drivers/ata/pata_qdi.c:142:9:    got restricted __le32 [usertype] <noident>
drivers/ata/pata_qdi.c:146:15: warning: cast to restricted __le32

drivers/ata/pata_winbond.c:110:9: warning: incorrect type in assignment (different base types)
drivers/ata/pata_winbond.c:110:9:    expected unsigned int [unsigned] [usertype] pad
drivers/ata/pata_winbond.c:110:9:    got restricted __le32 [usertype] <noident>
drivers/ata/pata_winbond.c:114:15: warning: cast to restricted __le32

drivers/ata/pata_legacy.c:310:9: warning: incorrect type in assignment (different base types)
drivers/ata/pata_legacy.c:310:9:    expected unsigned int [unsigned] [usertype] pad
drivers/ata/pata_legacy.c:310:9:    got restricted __le32 [usertype] <noident>
drivers/ata/pata_legacy.c:314:15: warning: cast to restricted __le32
drivers/ata/pata_legacy.c:752:11: warning: cast to restricted __le32
drivers/ata/pata_legacy.c:756:9: warning: incorrect type in assignment (different base types)
drivers/ata/pata_legacy.c:756:9:    expected unsigned int [unsigned] [addressable] [assigned] [usertype] pad
drivers/ata/pata_legacy.c:756:9:    got restricted __le32 [usertype] <noident>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
Al, have incorporated your comments.

 drivers/ata/pata_legacy.c  |   10 ++++------
 drivers/ata/pata_qdi.c     |    2 +-
 drivers/ata/pata_winbond.c |    2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index fe7cc8e..bc037ff 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -305,7 +305,7 @@ static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
 			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			u32 pad;
+			__le32 pad;
 			if (rw == READ) {
 				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
 				memcpy(buf + buflen - slop, &pad, slop);
@@ -746,14 +746,12 @@ static unsigned int vlb32_data_xfer(struct ata_device *adev, unsigned char *buf,
 			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			u32 pad;
+			__le32 pad;
 			if (rw == WRITE) {
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
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 97e5b09..63b7a1c 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -137,7 +137,7 @@ static unsigned int qdi_data_xfer(struct ata_device *dev, unsigned char *buf,
 			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			u32 pad;
+			__le32 pad;
 			if (rw == READ) {
 				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
 				memcpy(buf + buflen - slop, &pad, slop);
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 474528f..a7606b0 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -105,7 +105,7 @@ static unsigned int winbond_data_xfer(struct ata_device *dev,
 			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
-			u32 pad;
+			__le32 pad;
 			if (rw == READ) {
 				pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
 				memcpy(buf + buflen - slop, &pad, slop);
-- 
1.5.6.rc3.295.gdca2e



