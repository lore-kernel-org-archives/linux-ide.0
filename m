From: maximilian attems <debian@sternwelten.at>
Subject: [patch] ide dma blacklist toshiba
Date: Sun, 26 Jun 2005 18:55:33 +0200
Message-ID: <20050626165533.GU12811@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:48567 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261439AbVFZREw
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 13:04:52 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

blacklist "TOSHIBA CD-ROM XM-1702BC"
bug reporter couldn't acces it's cdrom drive otherwise
debian bug -> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=222939
there are also older reports that this drive doesn't work out of the box:
http://lists.debian.org/debian-boot/1999/02/msg00016.html


Signed-off-by: maximilian attems <janitor@sternwelten.at>

--- kernel-source-2.6.6/drivers/ide/ide-dma.c	2004-04-05 19:49:28.000000000 +1000
+++ kernel-source-2.6.6-1/drivers/ide/ide-dma.c	2004-04-05 20:54:34.000000000 +1000
@@ -125,6 +125,7 @@
 	{ "HITACHI CDR-8335"	,	"ALL"		},
 	{ "HITACHI CDR-8435"	,	"ALL"		},
 	{ "Toshiba CD-ROM XM-6202B"	,	"ALL"		},
+	{ "TOSHIBA CD-ROM XM-1702BC"	,	"ALL"		},
 	{ "CD-532E-A"		,	"ALL"		},
 	{ "E-IDE CD-ROM CR-840",	"ALL"		},
 	{ "CD-ROM Drive/F5A",	"ALL"		},
