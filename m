From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 02/73] [ide/ata]: add ATA_MWDMA3 and ATA_MWDMA4 masks
Date: Sat, 14 Mar 2009 20:10:31 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142010100.59456@anduin.net>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:60566 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbZCNTKe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 15:10:34 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1LiZFf-000FU2-SH
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 20:10:31 +0100
In-Reply-To: <alpine.BSF.1.00.0903141850260.53715@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Will be used by next patch for pata_octeon_cf.

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 include/linux/ata.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 9a061ac..386eeac 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -117,6 +117,8 @@ enum {
 	ATA_MWDMA0		=3D (1 << 0),
 	ATA_MWDMA1		=3D ATA_MWDMA0 | (1 << 1),
 	ATA_MWDMA2		=3D ATA_MWDMA1 | (1 << 2),
+	ATA_MWDMA3		=3D ATA_MWDMA2 | (1 << 3),
+	ATA_MWDMA4		=3D ATA_MWDMA3 | (1 << 4),
=20
 	ATA_MWDMA12_ONLY	=3D (1 << 1) | (1 << 2),
 	ATA_MWDMA2_ONLY		=3D (1 << 2),
--=20
1.5.6.3

