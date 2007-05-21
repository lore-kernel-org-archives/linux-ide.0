From: Dave Jones <davej@redhat.com>
Subject: Add Seagate STT20000A to DMA blacklist.
Date: Mon, 21 May 2007 10:50:42 -0400
Message-ID: <20070521145042.GA6957@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34747 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbXEUOus (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 May 2007 10:50:48 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=1044
has been open for _four_ years with a patch available.
Here's a rediffed version of the same.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/ide/ide-dma.c~	2007-05-21 10:48:11.000000000 -0400
+++ linux-2.6/drivers/ide/ide-dma.c	2007-05-21 10:48:21.000000000 -0400
@@ -127,7 +127,8 @@ static const struct drive_list_entry dri
 	{ "SAMSUNG CD-ROM SC",	"ALL"		},
 	{ "SanDisk SDP3B-64"	,	"ALL"		},
 	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	"ALL"		},
-	{ "_NEC DV5800A",               "ALL"           },  
+	{ "_NEC DV5800A",               "ALL"           },
+	{ "Seagate STT20000A",          "ALL"           },
 	{ NULL			,	NULL		}
 
 };

-- 
http://www.codemonkey.org.uk
