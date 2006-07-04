From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 24/24] jmicron: Missed one
Date: Tue, 4 Jul 2006 18:15:17 +0000 (UTC)
Message-ID: <1152036128371-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxo
 rguk.ukuu.org.uk> <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036122125!
 0-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361243147-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361254139-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361251284-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361272182-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56462 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932316AbWGDSPF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:15:05 -0400
Date: Maw, 04 Gor 2006 19:01:48 +0100
In-Reply-To: <11520361272182-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

From: Alan Cox <alan@redhat.com>

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/ata_jmicron.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

56d473e506ba2cda167f25df4cfd21910eb2d1ab
diff --git a/drivers/scsi/ata_jmicron.c b/drivers/scsi/ata_jmicron.c
index f141ee7..85a7ffc 100644
--- a/drivers/scsi/ata_jmicron.c
+++ b/drivers/scsi/ata_jmicron.c
@@ -177,7 +177,7 @@ static const struct ata_port_operations 
 
 
 /**
- *	jmicron_init_one - Register Netcell ATA PCI device with kernel services
+ *	jmicron_init_one - Register Jmicron ATA PCI device with kernel services
  *	@pdev: PCI device to register
  *	@ent: Entry in jmicron_pci_tbl matching with @pdev
  *
-- 
1.2.GIT

