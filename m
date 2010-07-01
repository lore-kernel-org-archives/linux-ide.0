From: Mark Lord <kernel@teksavvy.com>
Subject: [PATCH 3/3] libata: reduce blacklist size (resend)
Date: Thu, 01 Jul 2010 11:36:34 -0400
Message-ID: <4C2CB602.3010104@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CB4C4.6070806@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:50633 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756869Ab0GAPgh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 11:36:37 -0400
In-Reply-To: <4C2CB4C4.6070806@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>


Take further advantage of the new glob_match() function to reduce the blacklist size.
There are even more savings possible, but how far do we want to go with this?

Signed-off-by: Mark Lord <mlord@pobox.com>

(resent with subject line fixed)

--- 2.6.34/drivers/ata/libata-core.c	2010-07-01 11:27:32.549052000 -0400
+++ linux/drivers/ata/libata-core.c	2010-07-01 11:15:38.555802000 -0400
@@ -4254,15 +4254,13 @@
  	{ "WDC AC23200L",	"21.10N21",	ATA_HORKAGE_NODMA },
  	{ "Compaq CRD-8241B", 	NULL,		ATA_HORKAGE_NODMA },
  	{ "CRD-8400B",		NULL, 		ATA_HORKAGE_NODMA },
-	{ "CRD-8480B",		NULL,		ATA_HORKAGE_NODMA },
-	{ "CRD-8482B",		NULL,		ATA_HORKAGE_NODMA },
+	{ "CRD-848[02]B",	NULL,		ATA_HORKAGE_NODMA },
  	{ "CRD-84",		NULL,		ATA_HORKAGE_NODMA },
  	{ "SanDisk SDP3B",	NULL,		ATA_HORKAGE_NODMA },
  	{ "SanDisk SDP3B-64",	NULL,		ATA_HORKAGE_NODMA },
  	{ "SANYO CD-ROM CRD",	NULL,		ATA_HORKAGE_NODMA },
  	{ "HITACHI CDR-8",	NULL,		ATA_HORKAGE_NODMA },
-	{ "HITACHI CDR-8335",	NULL,		ATA_HORKAGE_NODMA },
-	{ "HITACHI CDR-8435",	NULL,		ATA_HORKAGE_NODMA },
+	{ "HITACHI CDR-8[34]35",NULL,		ATA_HORKAGE_NODMA },
  	{ "Toshiba CD-ROM XM-6202B", NULL,	ATA_HORKAGE_NODMA },
  	{ "TOSHIBA CD-ROM XM-1702BC", NULL,	ATA_HORKAGE_NODMA },
  	{ "CD-532E-A", 		NULL,		ATA_HORKAGE_NODMA },
@@ -4342,12 +4340,7 @@
  	/* Devices which get the IVB wrong */
  	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB, },
  	/* Maybe we should just blacklist TSSTcorp... */
-	{ "TSSTcorp CDDVDW SH-S202H", "SB00",	  ATA_HORKAGE_IVB, },
-	{ "TSSTcorp CDDVDW SH-S202H", "SB01",	  ATA_HORKAGE_IVB, },
-	{ "TSSTcorp CDDVDW SH-S202J", "SB00",	  ATA_HORKAGE_IVB, },
-	{ "TSSTcorp CDDVDW SH-S202J", "SB01",	  ATA_HORKAGE_IVB, },
-	{ "TSSTcorp CDDVDW SH-S202N", "SB00",	  ATA_HORKAGE_IVB, },
-	{ "TSSTcorp CDDVDW SH-S202N", "SB01",	  ATA_HORKAGE_IVB, },
+	{ "TSSTcorp CDDVDW SH-S202[HJN]", "SB0[01]",  ATA_HORKAGE_IVB, },
  
  	/* Devices that do not need bridging limits applied */
  	{ "MTRON MSP-SATA*",		NULL,	ATA_HORKAGE_BRIDGE_OK, },
