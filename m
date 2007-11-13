From: Gabriel C <nix.or.die@googlemail.com>
Subject: [PATCH] sis5513.c: Add Packard Bell EasyNote K5305 to laptops
Date: Tue, 13 Nov 2007 21:35:39 +0100
Message-ID: <473A0A9B.5000104@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:3951 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826AbXKMUfo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 15:35:44 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1926184mue
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 12:35:43 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hi,

With newer kernels HDD in my old laptop is limited to UDMA 33.
With this patch I get UDMA 100 again.

Signed-off-by: Gabriel Craciunescu <nix.or.die@googlemail.com>

---

diff --git a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
index 6b7bb53..3878224 100644
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -527,6 +527,7 @@ static const struct sis_laptop sis_laptop[] = {
 	/* devid, subvendor, subdev */
 	{ 0x5513, 0x1043, 0x1107 },	/* ASUS A6K */
 	{ 0x5513, 0x1734, 0x105f },	/* FSC Amilo A1630 */
+	{ 0x5513, 0x1071, 0x8640 },     /* EasyNote K5305 */
 	/* end marker */
 	{ 0, }
 };

