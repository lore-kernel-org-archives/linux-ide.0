From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 17/24] pata_qdi: Fix return code
Date: Tue, 4 Jul 2006 18:15:27 +0000 (UTC)
Message-ID: <11520361221250-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxo
 rguk.ukuu.org.uk> <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56974 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932315AbWGDSPG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:15:06 -0400
Date: Maw, 04 Gor 2006 19:01:41 +0100
In-Reply-To: <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/pata_qdi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

50c4cfe08714a41b64a4375c3616e158f02ec3e5
diff --git a/drivers/scsi/pata_qdi.c b/drivers/scsi/pata_qdi.c
index f8fc0ef..5ddd708 100644
--- a/drivers/scsi/pata_qdi.c
+++ b/drivers/scsi/pata_qdi.c
@@ -309,7 +309,7 @@ static __init int qdi_init(void)
 	int i;
 	
 	if (probe_qdi == 0)
-		return;
+		return -ENODEV;
 	
 	/*
  	 *	Check each possible QD65xx base address
-- 
1.2.GIT

