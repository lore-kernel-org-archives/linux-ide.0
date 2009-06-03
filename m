From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] libata: pata_bf54x: handle portmuxing of pins through GPIO PORTs
Date: Wed,  3 Jun 2009 09:23:54 -0400
Message-ID: <1244035434-1923-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:60816 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbZFCNX7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jun 2009 09:23:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>, Bryan Wu <cooloney@kernel.org>

From: Sonic Zhang <sonic.zhang@analog.com>

By default, the PATA pins are routed to the async address lines in which
case, no peripheral muxing needs to be done.  However, if the pins get
routed through the GPIO PORTs pins, we need to make sure to request them
so that the muxing is properly set up.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/ata/pata_bf54x.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index c4b47a3..02c81f1 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1557,6 +1557,25 @@ static unsigned short atapi_io_port[] = {
 	P_ATAPI_DMARQ,
 	P_ATAPI_INTRQ,
 	P_ATAPI_IORDY,
+	P_ATAPI_D0A,
+	P_ATAPI_D1A,
+	P_ATAPI_D2A,
+	P_ATAPI_D3A,
+	P_ATAPI_D4A,
+	P_ATAPI_D5A,
+	P_ATAPI_D6A,
+	P_ATAPI_D7A,
+	P_ATAPI_D8A,
+	P_ATAPI_D9A,
+	P_ATAPI_D10A,
+	P_ATAPI_D11A,
+	P_ATAPI_D12A,
+	P_ATAPI_D13A,
+	P_ATAPI_D14A,
+	P_ATAPI_D15A,
+	P_ATAPI_A0A,
+	P_ATAPI_A1A,
+	P_ATAPI_A2A,
 	0
 };
 
-- 
1.6.3.1

