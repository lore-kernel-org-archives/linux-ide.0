From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ht6560b can only do up to PIO mode 4
Date: Mon, 18 Feb 2008 23:56:32 +0100
Message-ID: <200802182356.32996.bzolnier@gmail.com>
References: <47B98EFC.8080507@caiway.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:23771 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbYBSAus (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 19:50:48 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1958583mue.5
        for <linux-ide@vger.kernel.org>; Mon, 18 Feb 2008 16:50:47 -0800 (PST)
In-Reply-To: <47B98EFC.8080507@caiway.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Cc: linux-ide@vger.kernel.org

On Monday 18 February 2008, Jan Evert van Grootheest wrote:
> According to the datasheet, ht6560b only supports up to PIO mode 4.
> 
> Signed-off-by: Jan Evert van Grootheest <janevert@caiway.nl>

applied, thanks!

PS I had to manually port it over 2.6.25-rc2, patch below

From: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Subject: [PATCH] ht6560b can only do up to PIO mode 4

According to the datasheet, ht6560b only supports up to PIO mode 4.

[bart: manually ported it over 2.6.25-rc2]

Signed-off-by: Jan Evert van Grootheest <janevert@caiway.nl>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ht6560b.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -323,7 +323,7 @@ static const struct ide_port_info ht6560
 				  IDE_HFLAG_NO_DMA |
 				  IDE_HFLAG_NO_AUTOTUNE |
 				  IDE_HFLAG_ABUSE_PREFETCH,
-	.pio_mask		= ATA_PIO5,
+	.pio_mask		= ATA_PIO4,
 };
 
 static int __init ht6560b_init(void)
