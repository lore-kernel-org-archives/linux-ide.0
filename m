From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 2/2] drivers: ide: Include appropriate header file in
 ide-pio-blacklist.c
Date: Tue, 17 Dec 2013 16:41:11 +0530
Message-ID: <2ec755ae03ae9f912f40a12a241f997909f380a1.1387278225.git.rashika.kheria@gmail.com>
References: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33743 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3LQLLU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Dec 2013 06:11:20 -0500
Content-Disposition: inline
In-Reply-To: <d24d7befadfbfb9501d0e873f13e39fd42ec893b.1387278225.git.rashika.kheria@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, josh@joshtriplett.org

Include appropriate header file include/linux/ide.h in file
ide-pio-blacklist.c because function ide_scan_pio_blacklist() has it's
prototype declaration in include/linux/ide.h.

This eliminates the following warning in ide-pio-blacklist.c:
drivers/ide/ide-pio-blacklist.c:85:5: warning: no previous prototype fo=
r =E2=80=98ide_scan_pio_blacklist=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 drivers/ide/ide-pio-blacklist.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ide/ide-pio-blacklist.c b/drivers/ide/ide-pio-blac=
klist.c
index a8c2c8f8..40e683a 100644
--- a/drivers/ide/ide-pio-blacklist.c
+++ b/drivers/ide/ide-pio-blacklist.c
@@ -7,6 +7,7 @@
  */
=20
 #include <linux/string.h>
+#include <linux/ide.h>
=20
 static struct ide_pio_info {
 	const char	*name;
--=20
1.7.9.5

