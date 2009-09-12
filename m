From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Subject: [RFC][PATCH] ata: sata_sil.c check sil_scr_read for failure
Date: Sun, 13 Sep 2009 00:07:06 +0530
Message-ID: <1252780626.3687.20.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34296 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722AbZILShH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Sep 2009 14:37:07 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

[This is untested]

By checking sil_scr_read, we can get rid of this compilation warning:

  CC [M]  drivers/ata/sata_sil.o
drivers/ata/sata_sil.c: In function =E2=80=98sil_host_intr=E2=80=99:
drivers/ata/sata_sil.c:442: warning: =E2=80=98serror=E2=80=99 may be us=
ed uninitialized in this function

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 drivers/ata/sata_sil.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 3cb69d5..a908031 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -445,7 +445,8 @@ static void sil_host_intr(struct ata_port *ap, u32 =
bmdma2)
 		 * controllers continue to assert IRQ as long as
 		 * SError bits are pending.  Clear SError immediately.
 		 */
-		sil_scr_read(&ap->link, SCR_ERROR, &serror);
+		if (sil_scr_read(&ap->link, SCR_ERROR, &serror))
+			return;
 		sil_scr_write(&ap->link, SCR_ERROR, serror);
=20
 		/* Sometimes spurious interrupts occur, double check
--=20
1.6.4.2


