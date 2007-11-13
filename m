From: Gabriel C <nix.or.die@googlemail.com>
Subject: [PATCH] pata_sis.c: Add Packard Bell EasyNote K5305 to laptops
Date: Tue, 13 Nov 2007 21:38:47 +0100
Message-ID: <473A0B57.4030703@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:5063 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758155AbXKMUiw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Nov 2007 15:38:52 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1552265nfb
        for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 12:38:50 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

Hi,

With newer kernels HDD in my old laptop is limited to UDMA 33.
With this patch I get UDMA 100 again.

Signed-off-by: Gabriel Craciunescu <nix.or.die@googlemail.com>

---

diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 3b5be77..87546d9 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -55,6 +55,7 @@ static const struct sis_laptop sis_laptop[] = {
 	/* devid, subvendor, subdev */
 	{ 0x5513, 0x1043, 0x1107 },	/* ASUS A6K */
 	{ 0x5513, 0x1734, 0x105F },	/* FSC Amilo A1630 */
+	{ 0x5513, 0x1071, 0x8640 },     /* EasyNote K5305 */
 	/* end marker */
 	{ 0, }
 };
