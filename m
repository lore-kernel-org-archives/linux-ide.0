From: Brandon Philips <brandon@ifup.org>
Subject: [PATCH] it821x.c: use dev->revision instead of pci_read_config_byte
Date: Mon, 5 Jan 2009 11:10:06 -0800
Message-ID: <20090105191006.GD22062@jenkins.ifup.org>
References: <20090105165811.GF29255@jenkins.ifup.org> <20090105171104.5db48c74@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:3619 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742AbZAETL1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 14:11:27 -0500
Received: by wf-out-1314.google.com with SMTP id 27so7726587wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2009 11:11:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20090105171104.5db48c74@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, Shawn Lin <shawn@dmp.com.tw>

Minor cleanup.

Signed-off-by: Brandon Philips <bphilips@suse.de>

---
 drivers/ide/it821x.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6/drivers/ide/it821x.c
===================================================================
--- linux-2.6.orig/drivers/ide/it821x.c
+++ linux-2.6/drivers/ide/it821x.c
@@ -563,8 +563,7 @@ static void __devinit init_hwif_it821x(i
 	 *	this is necessary.
 	 */
 
-	pci_read_config_byte(dev, 0x08, &conf);
-	if (conf == 0x10) {
+	if (dev->revision == 0x10) {
 		idev->timing10 = 1;
 		hwif->host_flags |= IDE_HFLAG_NO_ATAPI_DMA;
 		if (idev->smart == 0)
