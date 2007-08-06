From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] ata_piix: update map 10b for ich8m
Date: Mon, 6 Aug 2007 10:51:27 -0700
Message-ID: <20070806105127.6aa6300c.kristen.c.accardi@intel.com>
References: <20070806174327.GP13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3811 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760291AbXHFRyT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Aug 2007 13:54:19 -0400
In-Reply-To: <20070806174327.GP13674@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, stable@kernel.org

On Tue, 7 Aug 2007 02:43:27 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Fix map entry 10b for ich8.  It's [P0 P2 IDE IDE] like ich6 / ich6m.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: <Kristen Carlson Accardi> kristen.c.accardi@intel.com

Acked-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

> ---
> Many users can be hit by this.  Please consider for -stable.  Thanks.
> 
>  drivers/ata/ata_piix.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index a78832e..c5b4509 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -436,7 +436,7 @@ static const struct piix_map_db ich8_map_db = {
>  		/* PM   PS   SM   SS       MAP */
>  		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI) */
>  		{  RV,  RV,  RV,  RV },
> -		{  IDE,  IDE,  NA,  NA }, /* 10b (IDE mode) */
> +		{  P0,  P2, IDE, IDE }, /* 10b (IDE mode) */
>  		{  RV,  RV,  RV,  RV },
>  	},
>  };
> 
