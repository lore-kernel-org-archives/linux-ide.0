From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [PATCH]trivial: add CDC_RAM to ide-cd capabilities mask
Date: Mon, 9 Jan 2006 23:16:47 +0300
Message-ID: <200601092316.47938.arvidjaar@mail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.mail.ru ([194.67.23.121]:29530 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1751304AbWAIUQu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2006 15:16:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Add CDC-RAM to capability mask. This prevents udev incorrectly reporting RAM 
capabilities for device.

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>

- ---

- --- linux-2.6.15/drivers/ide/ide-cd.c.orig	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15/drivers/ide/ide-cd.c	2006-01-09 00:31:32.000000000 +0300
@@ -2905,6 +2905,8 @@ static int ide_cdrom_register (ide_drive
 		devinfo->mask |= CDC_CLOSE_TRAY;
 	if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
 		devinfo->mask |= CDC_MO_DRIVE;
+	if (!CDROM_CONFIG_FLAGS(drive)->ram)
+		devinfo->mask |= CDC_RAM;
 
 	devinfo->disk = info->disk;
 	return register_cdrom(devinfo);
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDwsSvR6LMutpd94wRAuyRAKDVr66aA5cGLoQAliK20dz7FbTP+wCfb8C3
qCm1Sur7eFjCh2i1J95qI68=
=i3pt
-----END PGP SIGNATURE-----
