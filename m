From: "Andre Hedrick (anhedric)" <anhedric@cisco.com>
Subject: CFA 4.0 patch
Date: Mon, 14 May 2012 21:57:37 -0700
Message-ID: <4E75C4FECC27A44E9F7E0737D71946900F686C5B@xmb-sjc-21e.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtv-iport-1.cisco.com ([173.36.130.12]:57609 "EHLO
	mtv-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab2EOFHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2012 01:07:05 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, lkml@vger.kernel.org

This is a missing part of the CFA 4.0 and above support.

6.2.1.6.1 Word 0: General Configuration
	This field indicates the general characteristics of the device.
When Word 0 of the Identify drive information is 848Ah then the device
is a CompactFlash Storage Card and complies with the CFA specification
and CFA command set. It is recommended that PC Card modes of operation
report only the 848Ah value as they are always intended as removable
devices.

Bits 15-0: CF Standard Configuration Value
Word 0 is 848Ah. This is the recommended value of Word 0.
	Some operating systems require Bit 6 of Word 0 to be set to 1
(Non-removable device) to use the card as the root storage device. The
Card must be the root storage device when a host completely replaces
conventional disk storage with a CompactFlash Card in True IDE mode. To
support this requirement and provide capability for any future removable
media Cards, alternate handling of Word 0 is permitted.

Bits 15-0: CF Preferred Alternate Configuration Values

044Ah: This is the alternate value of Word 0 turns on ATA device and
turns off Removable Media and Removable Device while 	preserving all
Retired bits in the word.

0040h: This is the alternate value of Word 0 turns on ATA device and
turns off Removable Media and Removable Device while 	zeroing all
Retired bits in the word

Cheers,
Andre
--------------------
The Linux X-ATA/SATA guy


--- linux-2.6.32.orig/include/linux/ata.h	Mon May 14 15:48:24 2012
+++ linux-2.6.32/include/linux/ata.h	Mon May 14 15:51:42 2012
@@ -819,6 +819,10 @@
 {
 	if (id[ATA_ID_CONFIG] == 0x848A)	/* Traditional CF */
 		return 1;
+	if (id[ATA_ID_CONFIG] == 0x044A)	/* Alternative CF w/
removable turned off, preserving retired bits */
+		return 1;
+	if (id[ATA_ID_CONFIG] == 0x0040)	/* Alternative CF w/
removable turned off, zeroing retired bits*/
+		return 1;
 	/*
 	 * CF specs don't require specific value in the word 0 anymore
and yet
 	 * they forbid to report the ATA version in the word 80 and
require the
