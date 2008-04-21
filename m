From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] ata_piix: add Asus Eee 701 controller to short cable list
Date: Sun, 20 Apr 2008 23:52:02 -0500
Message-ID: <1208753522-10540-1-git-send-email-dpmcgee@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:29014 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbYDUEwG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Apr 2008 00:52:06 -0400
Received: by py-out-1112.google.com with SMTP id u52so2403484pyb.10
        for <linux-ide@vger.kernel.org>; Sun, 20 Apr 2008 21:52:06 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Dan McGee <dpmcgee@gmail.com>

The drive is directly soldered to the controller, so there is no cable at
all. Remove the 40-wire assumption so the drive can operate at max speed.

Before patch:
$ dd if=/dev/sda of=/dev/null bs=2M count=64 iflag=direct
134217728 bytes (134 MB) copied, 5.29612 s, 25.3 MB/s

After patch:
$ dd if=/dev/sda of=/dev/null bs=2M count=64 iflag=direct
134217728 bytes (134 MB) copied, 3.94955 s, 34.0 MB/s

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

I sent this to the linux-kernel ML earlier along with what seemed to be
the maintainer from recent git-log, but I failed at reading the comments
at the top of the file, so I'm resending it to you guys too. Sorry about
that.

Original Message-Id: <1208747007-9791-1-git-send-email-dpmcgee@gmail.com>

-Dan

 drivers/ata/ata_piix.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index b7c38ee..ea2c764 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -573,6 +573,7 @@ static const struct ich_laptop ich_laptop[] = {
 	{ 0x27DF, 0x1043, 0x1267 },	/* ICH7 on Asus W5F */
 	{ 0x27DF, 0x103C, 0x30A1 },	/* ICH7 on HP Compaq nc2400 */
 	{ 0x24CA, 0x1025, 0x0061 },	/* ICH4 on ACER Aspire 2023WLMi */
+	{ 0x2653, 0x1043, 0x82D8 },	/* ICH6M on Asus Eee 701 */
 	/* end marker */
 	{ 0, }
 };
-- 
1.5.5.1

