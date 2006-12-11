From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: use piix_host_stop() in ich_pata_ops
Date: Mon, 11 Dec 2006 22:26:25 +0900
Message-ID: <20061211132625.GA18947@htj.dyndns.org>
References: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:8442 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762904AbWLKN0i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 08:26:38 -0500
Received: by nz-out-0102.google.com with SMTP id s1so783658nze
        for <linux-ide@vger.kernel.org>; Mon, 11 Dec 2006 05:26:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0612091454j6df1fb0ej2fa006c3fa33abae@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

piix_init_one() allocates host private data which should be freed by
piix_host_stop().  ich_pata_ops wasn't converted to piix_host_stop()
while merging, leaking 4 bytes on driver detach.  Fix it.

This was spotted using Kmemleak by Catalin Marinas.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Catalin Marinas <catalin.marinas@gmail.com>
---
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index c7de0bb..dfe17e1 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -330,7 +330,7 @@ static const struct ata_port_operations ich_pata_ops = {
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
