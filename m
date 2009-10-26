From: Philippe De Muyter <phdm@macqel.be>
Subject: [PATCH ide] : Increase WAIT_DRQ to support slow CF cards
Date: Mon, 26 Oct 2009 17:20:11 +0100
Message-ID: <20091026162011.GA3289@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:3714 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752757AbZJZQUO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 12:20:14 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

Hi,

I just encountered a problem with write-access to a batch of CF cards
(KINGSTON TECHNOLOGY 4GB COMPACT FLASH CF/4GB
3.3V/5V 9904321 - 006.AOOLF 4449081 - 1219643 X001 ASSY IN TAIWAN (c) 2008)
connected to a PC-CARD / PCMCIA interface, with the following error messages :

	hda: status timeout: status=0xd0 { Busy }
	ide: failed opcode was: unknown
	hda: no DRQ after issuing MULTWRITE

After testing with different bigger values for the WAIT_DRQ timeout value,
the problem disappeared.  I had success with WAIT_DRQ = 500ms, then with
WAIT_DRQ = 300ms.  I then tested with WAIT_DRQ = 200ms, but the problem
reappeared.  So I kept the 300ms value.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>

diff -r a145344bb228 include/linux/ide.h
--- a/include/linux/ide.h	Thu Oct 22 08:28:28 2009 +0900
+++ b/include/linux/ide.h	Mon Oct 26 16:51:23 2009 +0100
@@ -125,8 +125,8 @@
  * Timeouts for various operations:
  */
 enum {
-	/* spec allows up to 20ms */
-	WAIT_DRQ	= HZ / 10,	/* 100ms */
+	/* spec allows up to 20ms, but some CF cards need more than 200ms */
+	WAIT_DRQ	= 3 * HZ / 10,	/* 300ms */
 	/* some laptops are very slow */
 	WAIT_READY	= 5 * HZ,	/* 5s */
 	/* should be less than 3ms (?), if all ATAPI CD is closed at boot */
