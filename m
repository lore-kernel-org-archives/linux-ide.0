From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_sil: fix uninitialized variable use when sil_scr_read()
 fails
Date: Wed, 21 Oct 2009 14:00:19 +0900
Message-ID: <4ADE9563.2030705@kernel.org>
References: <20091020153456.9104e044.yuasa@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35629 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbZJUOct (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Oct 2009 10:32:49 -0400
In-Reply-To: <20091020153456.9104e044.yuasa@linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Yoichi Yuasa wrote:
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> 
> ---
>  drivers/ata/sata_sil.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
> index 3cb69d5..d7fff6b 100644
> --- a/drivers/ata/sata_sil.c
> +++ b/drivers/ata/sata_sil.c
> @@ -439,7 +439,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
>  	u8 status;
>  
>  	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
> -		u32 serror;
> +		u32 serror = 0;

The first usage of that is

  sil_scr_read(&ap->link, SCR_ERROR, &serror);

which sets the value.  So, I don't think the patch is necessary.  If
it triggers a compile warning, putting uninitialized_var() macro will
be more appropriate.

Thanks.

-- 
tejun

