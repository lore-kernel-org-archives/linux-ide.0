From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.6 patch] make sata_print_link_status() static
Date: Fri, 25 Apr 2008 00:48:29 -0400
Message-ID: <4811629D.3040601@pobox.com>
References: <20080421085111.GB26897@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46596 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753467AbYDYEsl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 00:48:41 -0400
In-Reply-To: <20080421085111.GB26897@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Mark Lord <mlord@pobox.com>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> sata_print_link_status() can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 
>  drivers/ata/libata-core.c |    3 +--
>  include/linux/libata.h    |    1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> 017dd9ea17af28a805e099c245ae1f8991eb6b5a diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 1686773..4b918d7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2605,7 +2605,7 @@ void ata_port_probe(struct ata_port *ap)
>   *	LOCKING:
>   *	None.
>   */
> -void sata_print_link_status(struct ata_link *link)
> +static void sata_print_link_status(struct ata_link *link)
>  {
>  	u32 sstatus, scontrol, tmp;
>  
> @@ -6197,7 +6197,6 @@ EXPORT_SYMBOL_GPL(ata_host_detach);
>  EXPORT_SYMBOL_GPL(ata_sg_init);
>  EXPORT_SYMBOL_GPL(ata_qc_complete);
>  EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
> -EXPORT_SYMBOL_GPL(sata_print_link_status);
>  EXPORT_SYMBOL_GPL(atapi_cmd_type);
>  EXPORT_SYMBOL_GPL(ata_tf_to_fis);
>  EXPORT_SYMBOL_GPL(ata_tf_from_fis);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2d8874b..84618df 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -847,7 +847,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
>  	return ap->ops == &ata_dummy_port_ops;
>  }
>  
> -extern void sata_print_link_status(struct ata_link *link);
>  extern void ata_port_probe(struct ata_port *);
>  extern int sata_set_spd(struct ata_link *link);
>  extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);

applied


