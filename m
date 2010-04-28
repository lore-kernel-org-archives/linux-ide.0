From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH 1/2] libata: don't flush dcache on slab pages
Date: Wed, 28 Apr 2010 22:06:37 +0200
Message-ID: <20100428200637.GA4578@Chamillionaire.breakpoint.cc>
References: <20100321215222.GA27709@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:58326 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932109Ab0D1UGj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Apr 2010 16:06:39 -0400
Content-Disposition: inline
In-Reply-To: <20100321215222.GA27709@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

* Sebastian Andrzej Siewior | 2010-03-21 22:52:22 [+0100]:

>page_mapping() check this via VM_BUG_ON(PageSlab(page)) so we bug here
>with the according debuging turned on.
>
>Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

Jeff, a month passed since I posted this patch. Any reason why you
ignore it?

> drivers/ata/libata-sff.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
>index 561dec2..83ecf48 100644
>--- a/drivers/ata/libata-sff.c
>+++ b/drivers/ata/libata-sff.c
>@@ -893,7 +893,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
> 				       do_write);
> 	}
> 
>-	if (!do_write)
>+	if (!do_write && !PageSlab(page))
> 		flush_dcache_page(page);
> 
> 	qc->curbytes += qc->sect_size;
>-- 
>1.6.6

Sebastian
