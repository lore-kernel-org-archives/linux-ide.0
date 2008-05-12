From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] [libata] pata-bf54x: Set ATAPI host state machine
 to control IDE device terminate sequence.
Date: Mon, 12 May 2008 10:50:14 +0100
Message-ID: <20080512105014.05afe682@core>
References: <1210565536-4026-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57881 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760859AbYELKAr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 May 2008 06:00:47 -0400
In-Reply-To: <1210565536-4026-1-git-send-email-cooloney@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>, Bryan Wu <cooloney@kernel.org>

On Mon, 12 May 2008 12:12:16 +0800
Bryan Wu <cooloney@kernel.org> wrote:

> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> Set ATAPI host state machine to control IDE device terminate sequence.
> Some IDE harddisk may assert terminate sequence in the middle of a
> formal DMA transaction and resume later. Bit DETECT_TERM in ATAPI_CTRL
> register determines whether the ATAPI host state machine or the kernel
> driver should take care of this case.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>

Acked-by: Alan Cox <alan@redhat.com>

(but when submitting fix typo "contorl" )
> ---
>  drivers/ata/pata_bf54x.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
> index 9ab8973..5551610 100644
> --- a/drivers/ata/pata_bf54x.c
> +++ b/drivers/ata/pata_bf54x.c
> @@ -911,7 +911,10 @@ static void bfin_bmdma_start(struct ata_queued_cmd *qc)
>  	/* Reset all transfer count */
>  	ATAPI_SET_CONTROL(base, ATAPI_GET_CONTROL(base) | TFRCNT_RST);
>  
> -		/* Set transfer length to buffer len */
> +	/* Set ATAPI state machine contorl in terminate sequence */
> +	ATAPI_SET_CONTROL(base, ATAPI_GET_CONTROL(base) | END_ON_TERM);
> +
> +	/* Set transfer length to buffer len */
>  	for_each_sg(qc->sg, sg, qc->n_elem, si) {
>  		ATAPI_SET_XFER_LEN(base, (sg_dma_len(sg) >> 1));
>  	}


-- 
--
	"Alan, I'm getting a bit worried about you."
				-- Linus Torvalds
