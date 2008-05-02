From: Dave Jones <davej@codemonkey.org.uk>
Subject: Remove Asus EEE UDMA/33 limitation.
Date: Fri, 2 May 2008 11:44:58 -0400
Message-ID: <20080502154458.GA10567@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from testure.choralone.org ([194.9.77.134]:46660 "EHLO
	testure.choralone.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758939AbYEBPpG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 11:45:06 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>

The Asus Eee PC prints this during bootup..

ata2.00: limited to UDMA/33 due to 40-wire cable
Which is unfortunate, as it has..
ata2.00: ATA-4: SILICONMOTION SM223AC, , max UDMA/66

I believe there actually is no cable, and the flash is directly
connected to the controller.

[root@eee ~]# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:   64 MB in  3.08 seconds =  20.76 MB/sec

With the patch below it returns..

/dev/sda:
 Timing buffered disk reads:   76 MB in  3.04 seconds =  25.04 MB/sec


Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.24.noarch/drivers/ata/ata_piix.c~	2008-03-31 23:43:05.000000000 -0400
+++ linux-2.6.24.noarch/drivers/ata/ata_piix.c	2008-03-31 23:44:34.000000000 -0400
@@ -716,6 +716,7 @@ struct ich_laptop {
 
 static const struct ich_laptop ich_laptop[] = {
 	/* devid, subvendor, subdev */
+	{ 0x2653, 0x1043, 0x82d8 },	/* ICH6M on Asus Eee PC */
 	{ 0x27DF, 0x0005, 0x0280 },	/* ICH7 on Acer 5602WLMi */
 	{ 0x27DF, 0x1025, 0x0102 },	/* ICH7 on Acer 5602aWLMi */
 	{ 0x27DF, 0x1025, 0x0110 },	/* ICH7 on Acer 3682WLMi */

-- 
http://www.codemonkey.org.uk
