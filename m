From: =?UTF-8?Q?Erik_Inge_Bols=C3=B8?= <knan-lkml@anduin.net>
Subject: [PATCH 1/2 v2] ide/ata: add some more transfer masks to ata.h
Date: Sat, 14 Mar 2009 21:37:48 +0100 (CET)
Message-ID: <alpine.BSF.1.00.0903142137160.66298@anduin.net>
References: <alpine.BSF.1.00.0903142131010.65817@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:55918 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbZCNUhv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 16:37:51 -0400
Received: from localhost ([127.0.0.1])
	by anduin.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <knan-lkml@anduin.net>)
	id 1Liac8-000HFi-K5
	for linux-ide@vger.kernel.org; Sat, 14 Mar 2009 21:37:48 +0100
In-Reply-To: <alpine.BSF.1.00.0903142131010.65817@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
---
 include/linux/ata.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 9a061ac..3901b00 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -108,6 +108,8 @@ enum {
 	ATA_PIO5		=3D ATA_PIO4 | (1 << 5),
 	ATA_PIO6		=3D ATA_PIO5 | (1 << 6),
=20
+	ATA_PIO4_ONLY		=3D (1 << 4),
+
 	ATA_SWDMA0		=3D (1 << 0),
 	ATA_SWDMA1		=3D ATA_SWDMA0 | (1 << 1),
 	ATA_SWDMA2		=3D ATA_SWDMA1 | (1 << 2),
@@ -117,6 +119,8 @@ enum {
 	ATA_MWDMA0		=3D (1 << 0),
 	ATA_MWDMA1		=3D ATA_MWDMA0 | (1 << 1),
 	ATA_MWDMA2		=3D ATA_MWDMA1 | (1 << 2),
+	ATA_MWDMA3		=3D ATA_MWDMA2 | (1 << 3),
+	ATA_MWDMA4		=3D ATA_MWDMA3 | (1 << 4),
=20
 	ATA_MWDMA12_ONLY	=3D (1 << 1) | (1 << 2),
 	ATA_MWDMA2_ONLY		=3D (1 << 2),
@@ -131,6 +135,8 @@ enum {
 	ATA_UDMA7		=3D ATA_UDMA6 | (1 << 7),
 	/* ATA_UDMA7 is just for completeness... doesn't exist (yet?).  */
=20
+	ATA_UDMA24_ONLY		=3D (1 << 2) | (1 << 4),
+
 	ATA_UDMA_MASK_40C	=3D ATA_UDMA2,	/* udma0-2 */
=20
 	/* DMA-related */
--=20
1.5.6.3

