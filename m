From: "Daniel E. Markle" <syntax@pa.net>
Subject: [PATCH] sata_sil mod15 quirk with Seagate ST380013AS
Date: Tue, 01 Feb 2005 00:39:11 -0500
Message-ID: <41FF15FF.7060503@pa.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040708090706090204060802"
Received: from ashtech.net ([66.59.109.171]:40075 "EHLO mail.ashtech.net")
	by vger.kernel.org with ESMTP id S261554AbVBAFg1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Feb 2005 00:36:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708090706090204060802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hardware Environment:
AMD64, onboard SiI 3114 controller

Drive Model:
Seagate 80GB ST380013AS

Problem:
Drive would lock up whenever the disk was used heavily.

Applied attached patch to add it to the "mod15" blacklist which seems to 
have fixed the problem.

--
Daniel E. Markle

--------------040708090706090204060802
Content-Type: text/x-patch;
 name="20050131-seagate-sata-3114.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="20050131-seagate-sata-3114.diff"

diff -urN linux.orig/drivers/scsi/sata_sil.c linux/drivers/scsi/sata_sil.c
--- linux.orig/drivers/scsi/sata_sil.c	2005-01-31 09:49:03.488652904 -0500
+++ linux/drivers/scsi/sata_sil.c	2005-01-31 09:52:28.165537288 -0500
@@ -84,6 +84,7 @@
 	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST380013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },

--------------040708090706090204060802--

