From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [2.6 patch] make sata_set_spd_needed() static
Date: Fri, 25 Apr 2008 00:48:36 -0400
Message-ID: <481162A4.50500@garzik.org>
References: <20080421085117.GC26897@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46597 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757930AbYDYEso (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 00:48:44 -0400
In-Reply-To: <20080421085117.GC26897@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> sata_set_spd_needed() can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 
>  drivers/ata/libata-core.c |    2 +-
>  drivers/ata/libata.h      |    1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> bb4bcf58edb56a5fc9d7401046adcafcffff46a6 diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4b918d7..8c2bb65 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2761,7 +2761,7 @@ static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
>   *	RETURNS:
>   *	1 if SATA spd configuration is needed, 0 otherwise.
>   */
> -int sata_set_spd_needed(struct ata_link *link)
> +static int sata_set_spd_needed(struct ata_link *link)
>  {
>  	u32 scontrol;
>  
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 4aeeabb..ae2cfd9 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -101,7 +101,6 @@ extern int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
>  			      unsigned int readid_flags);
>  extern int ata_dev_configure(struct ata_device *dev);
>  extern int sata_down_spd_limit(struct ata_link *link);
> -extern int sata_set_spd_needed(struct ata_link *link);
>  extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
>  extern void ata_sg_clean(struct ata_queued_cmd *qc);
>  extern void ata_qc_free(struct ata_queued_cmd *qc);

applied


