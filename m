From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_scc.c: add thaw ops
Date: Fri, 15 Feb 2008 13:52:21 -0500
Message-ID: <47B5DF65.3010800@garzik.org>
References: <200802130254.m1D2s9bG023092@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54656 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760140AbYBOSwY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Feb 2008 13:52:24 -0500
In-Reply-To: <200802130254.m1D2s9bG023092@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: kou.ishizaki@toshiba.co.jp, linux-ide@vger.kernel.org

Akira Iguchi wrote:
> This patch adds default thaw ops and fixes the freeze/thaw inconsistency.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
> ---
> 
> diff -pu linux-2.6.25-rc1/drivers/ata/pata_scc.c linux-2.6.25-rc1_mod/drivers/ata/pata_scc.c
> --- linux-2.6.25-rc1/drivers/ata/pata_scc.c	2008-02-11 07:18:14.000000000 +0900
> +++ linux-2.6.25-rc1_mod/drivers/ata/pata_scc.c	2008-02-13 11:37:34.000000000 +0900
> @@ -1007,6 +1007,8 @@ static const struct ata_port_operations 
>  	.qc_issue		= ata_qc_issue_prot,
>  
>  	.freeze			= scc_bmdma_freeze,
> +	.thaw			= ata_bmdma_thaw,
> +
>  	.error_handler		= scc_error_handler,
>  	.post_internal_cmd	= scc_bmdma_stop,

applied


