From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: add Satellite U200 to broken
 suspend list
Date: Fri, 31 Aug 2007 04:01:08 -0400
Message-ID: <46D7CAC4.8060104@garzik.org>
References: <20070824233102.GA32505@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54096 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709AbXHaIBK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 04:01:10 -0400
In-Reply-To: <20070824233102.GA32505@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, john@nachtimwald.com

Tejun Heo wrote:
> Satellite U200 also shares the problem.  Add it to the broken suspend
> list.  Original patch from John Schember.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: John Schember <john@nachtimwald.com>
> ---
>  drivers/ata/ata_piix.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 071d274..b827def 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -908,6 +908,13 @@ static int piix_broken_suspend(void)
>  			},
>  		},
>  		{
> +			.ident = "Satellite U200",
> +			.matches = {
> +				DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +				DMI_MATCH(DMI_PRODUCT_NAME, "Satellite U200"),
> +			},
> +		},
> +		{

applied


