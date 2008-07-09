From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] palm_bk3710: fix tRP for UDMA mode 4
Date: Wed, 9 Jul 2008 19:40:15 +0400
Message-ID: <200807091940.15722.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:2917 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754692AbYGIPkL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jul 2008 11:40:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, mcherkashin@ru.mvista.com

From: Mikhail Cherkashin <mcherkhashin@ru.mvista.com>

Fix tRP timing for UDMA mode 4 according to the ATA specification.

Signed-off-by: Mikhail Cherkashin <mcherkhashin@ru.mvista.com>
Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 drivers/ide/arm/palm_bk3710.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/arm/palm_bk3710.c b/drivers/ide/arm/palm_bk3710.c
index 2f2b4f4..74a05dc 100644
--- a/drivers/ide/arm/palm_bk3710.c
+++ b/drivers/ide/arm/palm_bk3710.c
@@ -83,7 +83,7 @@ static const struct palm_bk3710_udmatiming palm_bk3710_udmatimings[6] = {
 	{125, 160},		/* UDMA Mode 1 */
 	{100, 120},		/* UDMA Mode 2 */
 	{100, 90},		/* UDMA Mode 3 */
-	{85,  60},		/* UDMA Mode 4 */
+	{100, 60},		/* UDMA Mode 4 */
 };
 
 static void palm_bk3710_setudmamode(void __iomem *base, unsigned int dev,

