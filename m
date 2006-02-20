From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: blacklist update
Date: Mon, 20 Feb 2006 15:25:17 +0000
Message-ID: <1140449118.26526.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52617 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030283AbWBTPV2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Feb 2006 10:21:28 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k1KFPJAt026924
	for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 15:25:19 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k1KFPIJx026923
	for linux-ide@vger.kernel.org; Mon, 20 Feb 2006 15:25:18 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

A long time after testing confirmed the SN-124 was ok Klaas Gadeyne
discovered that early revision N001 is not.

Signed-off-by: Alan Cox <alan@redhat.com>


--- linux.vanilla-2.6.16-rc4/drivers/ide/ide-dma.c	2006-02-20 11:16:39.000000000 +0000
+++ linux-2.6.16-rc4/drivers/ide/ide-dma.c	2006-02-20 15:01:02.238144320 +0000
@@ -129,6 +129,7 @@
 	{ "SanDisk SDP3B-64"	,	"ALL"		},
 	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	"ALL"		},
 	{ "_NEC DV5800A",               "ALL"           },  
+	{ "SAMSUNG CD-ROM SN-124",	"N001"		},
 	{ NULL			,	NULL		}
 
 };

