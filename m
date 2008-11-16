From: Qinghuang Feng <qhfeng.kernel@gmail.com>
Subject: [PATCH 4/7] drivers/ata/pata_pdc2027x.c: cleanup kernel-doc
Date: Sun, 16 Nov 2008 17:44:02 +0800
Message-ID: <491feb6c.044e6e0a.74c1.ffffee9b@mx.google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.242]:46937 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbYKPJoO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 04:44:14 -0500
Received: by ag-out-0708.google.com with SMTP id 31so1818690agc.10
        for <linux-ide@vger.kernel.org>; Sun, 16 Nov 2008 01:44:14 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: qhfeng.kernel@gmail.com, Randy Dunlap <rdunlap@xenotime.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

No argument named @pio in pdc2027x_set_piomode, and
no argument named @udma in pdc2027x_set_dmamode,
remove them.

Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com>
---
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 0e1c2c1..22a1f7d 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -281,7 +281,6 @@ static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long
  *	pdc2027x_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port to configure
  *	@adev: um
- *	@pio: PIO mode, 0 - 4
  *
  *	Set PIO mode for device.
  *
@@ -326,7 +325,6 @@ static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
  *	pdc2027x_set_dmamode - Initialize host controller PATA UDMA timings
  *	@ap: Port to configure
  *	@adev: um
- *	@udma: udma mode, XFER_UDMA_0 to XFER_UDMA_6
  *
  *	Set UDMA mode for device.
  *

