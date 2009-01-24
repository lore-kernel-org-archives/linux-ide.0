From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] icside: fix PCB version 6 support
Date: Sat, 24 Jan 2009 16:46:21 +0100
Message-ID: <200901241646.22077.bzolnier@gmail.com>
References: <200901241513.29772.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:36174 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbZAXPq1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Jan 2009 10:46:27 -0500
In-Reply-To: <200901241513.29772.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

On Saturday 24 January 2009, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] icside: fix PCB version 6 support
> 
> We need to pass struct ide_port_info also to ide_host_register().
> 
> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] icside: fix PCB version 6 support (v2)

We need to pass struct ide_port_info also to ide_host_register().

v2:
Fix v5/v6 mismatch noticed by Russell.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/icside.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/icside.c
===================================================================
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -534,7 +534,7 @@ icside_register_v6(struct icside_state *
 		d.dma_ops = NULL;
 	}
 
-	ret = ide_host_register(host, NULL, hws);
+	ret = ide_host_register(host, &d, hws);
 	if (ret)
 		goto err_free;
 
