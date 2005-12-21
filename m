From: "Tony Battersby" <tonyb@cybernetics.com>
Subject: [PATCH] fix libata inquiry VPD for ATAPI devices
Date: Wed, 21 Dec 2005 16:35:44 -0500
Message-ID: <00c101c60676$808f9980$e0019d89@cybernetics.com>
Reply-To: <tonyb@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cyborg.cybernetics.com ([206.246.200.18]:20745 "EHLO
	cyborg.cybernetics.com") by vger.kernel.org with ESMTP
	id S1751164AbVLUVfu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Dec 2005 16:35:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

The following patch prevents libata from incorrectly modifying inquiry
VPD pages and command support data from ATAPI devices.  I have tested
the patch with a SATA ATAPI tape drive on an AHCI controller.

Patch is against kernel 2.4.32 with 2.4.32-libata1.patch applied.

Anthony J. Battersby
Cybernetics

--- linux-2.4.32-libata1/drivers/scsi/libata-scsi.c.orig	2005-12-21 16:04:24.000000000 -0500
+++ linux-2.4.32-libata1/drivers/scsi/libata-scsi.c	2005-12-21 16:06:58.000000000 -0500
@@ -2009,7 +2009,7 @@
 	else {
 		u8 *scsicmd = cmd->cmnd;
 
-		if (scsicmd[0] == INQUIRY) {
+		if ((scsicmd[0] == INQUIRY) && ((scsicmd[1] & 0x03) == 0)) {
 			u8 *buf = NULL;
 			unsigned int buflen;
 
@@ -2023,9 +2023,6 @@
 	 * device.  2) Ensure response data format / ATAPI information
 	 * are always correct.
 	 */
-	/* FIXME: do we ever override EVPD pages and the like, with
-	 * this code?
-	 */
 			if (buf[2] == 0) {
 				buf[2] = 0x5;
 				buf[3] = 0x32;

