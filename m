From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/6] sata_mv: drop unncessary EH callback resetting
Date: Tue, 25 May 2010 19:42:07 -0400
Message-ID: <4BFC604F.5020908@garzik.org>
References: <1274299824-15691-1-git-send-email-tj@kernel.org> <1274299824-15691-2-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49394 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933883Ab0EYXmK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 May 2010 19:42:10 -0400
Received: by gyg13 with SMTP id 13so2329944gyg.19
        for <linux-ide@vger.kernel.org>; Tue, 25 May 2010 16:42:09 -0700 (PDT)
In-Reply-To: <1274299824-15691-2-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 05/19/2010 04:10 PM, Tejun Heo wrote:
> Now that BMDMA EH ops are separated out from SFF ops, mv5_ops doesn't
> have to explicitly reset ->error_handler() and ->post_internal_cmd().
> Drop them.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/sata_mv.c |    2 --
>   1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index f3471bc..16bacd3 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -675,8 +675,6 @@ static struct ata_port_operations mv5_ops = {
>   	.freeze			= mv_eh_freeze,
>   	.thaw			= mv_eh_thaw,
>   	.hardreset		= mv_hardreset,
> -	.error_handler		= ata_std_error_handler, /* avoid SFF EH */
> -	.post_internal_cmd	= ATA_OP_NULL,

applied 1-6


