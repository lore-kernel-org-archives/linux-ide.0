From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 04/24] pata_pcmcia: Make drivers/scsi/pata_pcmcia.c:pcmcia_remove_one() static
Date: Tue, 4 Jul 2006 18:17:36 +0000 (UTC)
Message-ID: <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59278 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932325AbWGDSRC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:17:02 -0400
Date: Maw, 04 Gor 2006 19:01:28 +0100
In-Reply-To: <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/pata_pcmcia.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

fac48280be51547d8841b24d72c48be5eb434769
diff --git a/drivers/scsi/pata_pcmcia.c b/drivers/scsi/pata_pcmcia.c
index b078e64..9f630d7 100644
--- a/drivers/scsi/pata_pcmcia.c
+++ b/drivers/scsi/pata_pcmcia.c
@@ -294,7 +294,7 @@ out1:
  *	cleanup. Also called on module unload for any active devices.
  */
 
-void pcmcia_remove_one(struct pcmcia_device *pdev)
+static void pcmcia_remove_one(struct pcmcia_device *pdev)
 {
 	struct ata_pcmcia_info *info = pdev->priv;
 	struct device *dev = &pdev->dev;
-- 
1.2.GIT

