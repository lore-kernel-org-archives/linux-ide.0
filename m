From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_sis: Add the FSC Amilo and friends
Date: Wed, 22 Aug 2007 22:56:43 +0100
Message-ID: <20070822225643.1192cdf4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46622 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762920AbXHVVsm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Aug 2007 17:48:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

More short cables

Signed-off-by: Alan Cox <alan@redhat.com>


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sis.c linux-2.6.23rc3-mm1/drivers/ata/pata_sis.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sis.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_sis.c	2007-08-22 17:46:53.000000000 +0100
@@ -54,6 +54,7 @@
 static const struct sis_laptop sis_laptop[] = {
 	/* devid, subvendor, subdev */
 	{ 0x5513, 0x1043, 0x1107 },	/* ASUS A6K */
+	{ 0x5513, 0x1734, 0x105F },	/* FSC Amilo A1630 */
 	/* end marker */
 	{ 0, }
 };


-- 
--
	"Alan, I'm getting a bit worried about you."
				-- Linus Torvalds
