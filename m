From: Kel Modderman <kel@otaku42.de>
Subject: [PATCH 1/5] storage-fixup: add ASUS F6S with seagate devices
Date: Wed, 29 Oct 2008 09:08:54 +1000
Message-ID: <200810290908.54442.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from venema.h4ckr.net ([217.24.1.135]:43268 "EHLO venema.h4ckr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006AbYJ1Xlq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Oct 2008 19:41:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by venema.h4ckr.net (Postfix) with ESMTP id 3F19D3067CF
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:12:40 +0100 (CET)
Received: from venema.h4ckr.net ([127.0.0.1])
	by localhost (venema.h4ckr.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TRvzxLX9t992 for <linux-ide@vger.kernel.org>;
	Wed, 29 Oct 2008 00:12:38 +0100 (CET)
Received: from [192.168.1.99] (anikodeak.plus.com [80.229.152.168])
	by venema.h4ckr.net (Postfix) with ESMTP id 895783067C6
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:12:38 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The ASUS F6S was generating approx. 3 clicks per minute without the APM
workaround, with two different seagate drives of similar model but differing
cache/capacity.

Any value ~ 192 or above is enough to have the clicking cease, is the lowest
possible number preferable?

Signed-off-by: Kel Modderman <kel@otaku42.de>
---
--- a/storage-fixup.conf
+++ b/storage-fixup.conf
@@ -153,3 +153,10 @@ dmi system-manufacturer		Micro-Star Inte
 dmi system-product-name		MSI Notebook EX600
 ata model			WDC WD*BEVE*
 act hdparm -B 254 $DEV
+
+# Reported drive model: ST9200420AS
+rule asus-f6s
+dmi system-manufacturer		ASUSTeK Computer Inc.
+dmi system-product-name		F6S
+ata model			ST9*AS
+act hdparm -B 254 $DEV
---
