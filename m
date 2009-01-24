From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] icside: use struct ide_port_info also for PCB version 5
Date: Sat, 24 Jan 2009 16:46:35 +0100
Message-ID: <200901241646.35558.bzolnier@gmail.com>
References: <200901241514.23036.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:43829 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbZAXPq2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 10:46:28 -0500
In-Reply-To: <200901241514.23036.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

On Saturday 24 January 2009, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] icside: use struct ide_port_info also for PCB version 5
> 
> This fixes hwif->channel and drive->dn assignments.
> 
> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] icside: use struct ide_port_info also for PCB version 5 (v2)

This fixes hwif->channel and drive->dn assignments.

v2:
Fix v5/v6 mismatch noticed by Russell.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/icside.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: b/drivers/ide/icside.c
===================================================================
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -419,6 +419,10 @@ static void icside_setup_ports(hw_regs_t
 	hw->chipset = ide_acorn;
 }
 
+static const struct ide_port_info icside_v5_port_info = {
+	.host_flags		= IDE_HFLAG_NO_DMA,
+};
+
 static int __devinit
 icside_register_v5(struct icside_state *state, struct expansion_card *ec)
 {
@@ -445,7 +449,7 @@ icside_register_v5(struct icside_state *
 
 	icside_setup_ports(&hw, base, &icside_cardinfo_v5, ec);
 
-	host = ide_host_alloc(NULL, hws);
+	host = ide_host_alloc(&icside_v5_port_info, hws);
 	if (host == NULL)
 		return -ENODEV;
 
@@ -453,7 +457,7 @@ icside_register_v5(struct icside_state *
 
 	ecard_set_drvdata(ec, state);
 
-	ret = ide_host_register(host, NULL, hws);
+	ret = ide_host_register(host, &icside_v5_port_info, hws);
 	if (ret)
 		goto err_free;
 
