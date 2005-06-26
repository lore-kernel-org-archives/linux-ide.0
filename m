From: maximilian attems <janitor@sternwelten.at>
Subject: [patch] libata dma blacklist toshiba cdrom drive
Date: Sun, 26 Jun 2005 20:01:20 +0200
Message-ID: <20050626180120.GX12811@sputnik.stro.at>
References: <20050626165533.GU12811@sputnik.stro.at> <42BEE984.8050704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:50105 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261525AbVFZSAk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 26 Jun 2005 14:00:40 -0400
Content-Disposition: inline
In-Reply-To: <42BEE984.8050704@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>

blacklist "TOSHIBA CD-ROM XM-1702BC"
bug reporter couldn't acces it's cdrom drive otherwise
seperate patch from Herbert Xu adds it to drive_blacklist[] 
in drivers/ide/ide-dma.c 

Signed-off-by: maximilian attems <janitor@sternwelten.at>

--- a/drivers/scsi/libata-core.c.orig	2005-06-26 19:51:10.769825568 +0200
+++ b/drivers/scsi/libata-core.c	2005-06-26 19:52:04.849967051 +0200
@@ -1920,6 +1920,7 @@ static const char * ata_dma_blacklist []
 	"HITACHI CDR-8335",
 	"HITACHI CDR-8435",
 	"Toshiba CD-ROM XM-6202B",
+	"TOSHIBA CD-ROM XM-1702BC",
 	"CD-532E-A",
 	"E-IDE CD-ROM CR-840",
 	"CD-ROM Drive/F5A",
