From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: ATA: Make CS5536 PATA driver use 32-bit BM DMA template instead of 16-bit.
Date: Wed, 11 Nov 2009 00:58:16 +0100
Message-ID: <m3my2u0w6f.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:42956 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757186AbZKJX6M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Nov 2009 18:58:12 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Tested on IXP425 + CS5536.

Signed-off-by: Krzysztof Ha=C5=82asa <khc@pm.waw.pl>

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 88a7933..0898213 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -232,7 +232,7 @@ static struct scsi_host_template cs5536_sht =3D {
 };
=20
 static struct ata_port_operations cs5536_port_ops =3D {
-	.inherits		=3D &ata_bmdma_port_ops,
+	.inherits		=3D &ata_bmdma32_port_ops,
 	.cable_detect		=3D cs5536_cable_detect,
 	.set_piomode		=3D cs5536_set_piomode,
 	.set_dmamode		=3D cs5536_set_dmamode,

--=20
Krzysztof Halasa
