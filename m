From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream-fixes] pata_amd: fix an obvious bug in cable detection
Date: Mon, 5 Feb 2007 17:01:28 +0900
Message-ID: <20070205080128.GH1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:37211 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbXBEIBf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 03:01:35 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1533647wxd
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 00:01:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
Cc: stable@kernel.org

80c test mask is at bits 18 and 19 of EIDE Controller Configuration
not 22 and 23.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This makes unreliable cable detection even more unreliable.  Please
consider for -stable.  Thanks.

 drivers/ata/pata_amd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/ata/pata_amd.c
===================================================================
--- work.orig/drivers/ata/pata_amd.c
+++ work/drivers/ata/pata_amd.c
@@ -128,7 +128,7 @@ static void timing_setup(struct ata_port
 
 static int amd_pre_reset(struct ata_port *ap)
 {
-	static const u32 bitmask[2] = {0x03, 0xC0};
+	static const u32 bitmask[2] = {0x03, 0x0C};
 	static const struct pci_bits amd_enable_bits[] = {
 		{ 0x40, 1, 0x02, 0x02 },
 		{ 0x40, 1, 0x01, 0x01 }
@@ -247,7 +247,7 @@ static void amd133_set_dmamode(struct at
  */
 
 static int nv_pre_reset(struct ata_port *ap) {
-	static const u8 bitmask[2] = {0x03, 0xC0};
+	static const u8 bitmask[2] = {0x03, 0x0C};
 	static const struct pci_bits nv_enable_bits[] = {
 		{ 0x50, 1, 0x02, 0x02 },
 		{ 0x50, 1, 0x01, 0x01 }
