From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 01/24] ata_piix TIME0/TIME1 setup
Date: Tue, 4 Jul 2006 18:14:24 +0000 (UTC)
Message-ID: <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45710 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932297AbWGDSOS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:18 -0400
Date: Maw, 04 Gor 2006 19:01:25 +0100
In-Reply-To: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

We were using PIO 0 setup for PIO 2. Fix the off by one check

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/ata_piix.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

4a153b397c817c9115b6a423fcadfaa0e7ad8a76
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 31bc08f..f7893ef 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -717,7 +717,7 @@ static void piix_set_piomode (struct ata
 			    { 2, 1 },
 			    { 2, 3 }, };
 
-	if (pio > 2)
+	if (pio >= 2)
 		control |= 1;	/* TIME1 enable */
 	if (ata_pio_need_iordy(adev))
 		control |= 2;	/* IE enable */
-- 
1.2.GIT

