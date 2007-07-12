From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata_piix: kill incorrect invalid map value warning
Date: Thu, 12 Jul 2007 16:10:14 -0400
Message-ID: <46968AA6.7000404@garzik.org>
References: <113a52882e6.buthysia@virgilio.it> <20070710085821.GC23568@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55535 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755189AbXGLUKS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 16:10:18 -0400
In-Reply-To: <20070710085821.GC23568@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "buthysia@virgilio.it" <buthysia@virgilio.it>, linux-ide@vger.kernel.org, tardyp@gmail.com

Tejun Heo wrote:
> The last two slots of MAP 00b of ich6m was incorrectly marked as
> reserved.  This is left over from converting the entry to allow 00b.
> This causes no real problem.  It only makes the driver print annoying
> warning message.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> --
>  drivers/ata/ata_piix.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 6a3bfef..21a7ca4 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -414,7 +414,7 @@ static const struct piix_map_db ich6m_map_db = {
>  	 */
>  	.map = {
>  		/* PM   PS   SM   SS       MAP */
> -		{  P0,  P2,  RV,  RV }, /* 00b */
> +		{  P0,  P2,  NA,  NA }, /* 00b */
>  		{ IDE, IDE,  P1,  P3 }, /* 01b */
>  		{  P0,  P2, IDE, IDE }, /* 10b */
>  		{  RV,  RV,  RV,  RV },

applied (with credit also to Pierre Tardy for spotting this as well)

