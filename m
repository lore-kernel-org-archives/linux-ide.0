From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 19/24] jmicron: It works better if you get the file name right
Date: Tue, 4 Jul 2006 18:15:21 +0000 (UTC)
Message-ID: <11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxo
 rguk.ukuu.org.uk> <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036122125!
 0-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57230 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932319AbWGDSPI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:15:08 -0400
Date: Maw, 04 Gor 2006 19:01:43 +0100
In-Reply-To: <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

From: Alan Cox <alan@redhat.com>

Fix the Makefile to be ata_

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

25c581221bf9095dbf8a32aee395d83bd1fa4f9e
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 3654dab..e925bad 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -140,7 +140,7 @@ obj-$(CONFIG_SCSI_PATA_HPT3X3)	+= libata
 obj-$(CONFIG_SCSI_PATA_ISAPNP)	+= libata.o pata_isapnp.o
 obj-$(CONFIG_SCSI_PATA_IT8172)	+= libata.o pata_it8172.o
 obj-$(CONFIG_SCSI_PATA_IT821X)	+= libata.o pata_it821x.o
-obj-$(CONFIG_SCSI_PATA_JMICRON)	+= libata.o ata_jmicron.o
+obj-$(CONFIG_SCSI_ATA_JMICRON)	+= libata.o ata_jmicron.o
 obj-$(CONFIG_SCSI_PATA_NETCELL)	+= libata.o pata_netcell.o
 obj-$(CONFIG_SCSI_PATA_NS87410)	+= libata.o pata_ns87410.o
 obj-$(CONFIG_SCSI_PATA_OPTI)	+= libata.o pata_opti.o
-- 
1.2.GIT

