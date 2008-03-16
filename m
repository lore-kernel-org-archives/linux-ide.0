From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/1] IDE: fix ide.h compiler warning
Date: Sun, 16 Mar 2008 17:02:40 +0100
Message-ID: <1205683360-1454-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.wellnetcz.com ([212.24.148.102]:58658 "EHLO WNmonitoring"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752043AbYCPQlG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Mar 2008 12:41:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

=46ix following compiler warning by returning EINVAL
In file included from ANYTHING-INCLUDING-IDE.H:45:
include/linux/ide.h: In function =E2=80=98ide_hwif_setup_dma=E2=80=99:
include/linux/ide.h:1022: warning: no return statement in function retu=
rning non-void

This fix is only for CONFIG_BLK_DEV_IDEDMA_PCI=3Dn configs and is intro=
duced by
ide: do complete DMA setup in ->init_dma method.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index 83ddaf0..bd8d751 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1016,7 +1016,10 @@ unsigned long ide_pci_dma_base(ide_hwif_t *, con=
st struct ide_port_info *);
 int ide_hwif_setup_dma(ide_hwif_t *, const struct ide_port_info *);
 #else
 static inline int ide_hwif_setup_dma(ide_hwif_t *hwif,
-				     const struct ide_port_info *d) { }
+				     const struct ide_port_info *d)
+{
+	return -EINVAL;
+}
 #endif
=20
 extern void default_hwif_iops(ide_hwif_t *);
--=20
1.5.4.1

