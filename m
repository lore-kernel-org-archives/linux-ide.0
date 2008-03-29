From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 2/2] pata_amd: fix sparse warning
Date: Sat, 29 Mar 2008 12:17:08 -0400
Message-ID: <47EE6B84.4070907@garzik.org>
References: <200803282133.m2SLXutE011470@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38342 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523AbYC2QRL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Mar 2008 12:17:11 -0400
In-Reply-To: <200803282133.m2SLXutE011470@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, harvey.harrison@gmail.com, alan@lxorguk.ukuu.org.uk

akpm@linux-foundation.org wrote:
> From: Harvey Harrison <harvey.harrison@gmail.com>
> 
> Current code is essentially choosing between dividing by 1 or
> dividing by two, make the conditions a little more obvious.
> 
> As a bonus, removes a sparse error:
> drivers/ata/pata_amd.c:59:11: warning: symbol '__x' shadows an earlier one
> drivers/ata/pata_amd.c:59:11: originally declared here
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/pata_amd.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/ata/pata_amd.c~pata_amd-fix-sparse-warning drivers/ata/pata_amd.c
> --- a/drivers/ata/pata_amd.c~pata_amd-fix-sparse-warning
> +++ a/drivers/ata/pata_amd.c
> @@ -56,7 +56,9 @@ static void timing_setup(struct ata_port
>  	u8 t;
>  
>  	T = 1000000000 / amd_clock;
> -	UT = T / min_t(int, max_t(int, clock, 1), 2);
> +	UT = T;
> +	if (clock >= 2)
> +		UT = T / 2;

Why assign UT twice, potentially?


