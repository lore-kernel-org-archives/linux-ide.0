From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH] pata_octeon_cf: use of_property_read_{bool|u32}()
Date: Mon, 28 Aug 2017 14:52:14 -0700
Message-ID: <d414cf99-2e53-eef8-9372-3900b0543a46@gmail.com>
References: <20170827195613.904715064@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33472 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdH1VwR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Aug 2017 17:52:17 -0400
Received: by mail-io0-f194.google.com with SMTP id s101so1583730ioe.0
        for <linux-ide@vger.kernel.org>; Mon, 28 Aug 2017 14:52:17 -0700 (PDT)
In-Reply-To: <20170827195613.904715064@cogentembedded.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, "open list:LIBATA PATA DRIVERS" <linux-ide@vger.kernel.org>
Cc: linux-mips@linux-mips.org

On 08/27/2017 12:55 PM, Sergei Shtylyov wrote:
> The Octeon CF driver basically  open-codes of_property_read_{bool|u32}()
> using  of_{find|get}_property() calls in its  probe() method.  Using the
> modern DT APIs saves 2 LoCs and 16 bytes of object code (MIPS gcc 3.4.3).
> 
> Signed-off-by: Sergei Shtylyov<sergei.shtylyov@cogentembedded.com>

It still works with this applied, so:

Acked-by: David Daney <david.daney@cavium.com>

> 
> ---
>   drivers/ata/pata_octeon_cf.c |   10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> Index: libata/drivers/ata/pata_octeon_cf.c
> ===================================================================
> --- libata.orig/drivers/ata/pata_octeon_cf.c
> +++ libata/drivers/ata/pata_octeon_cf.c
> @@ -840,7 +840,6 @@ static int octeon_cf_probe(struct platfo
>   	struct property *reg_prop;
>   	int n_addr, n_size, reg_len;
>   	struct device_node *node;
> -	const void *prop;
>   	void __iomem *cs0;
>   	void __iomem *cs1 = NULL;
>   	struct ata_host *host;
> @@ -850,7 +849,7 @@ static int octeon_cf_probe(struct platfo
>   	void __iomem *base;
>   	struct octeon_cf_port *cf_port;
>   	int rv = -ENOMEM;
> -
> +	u32 bus_width;
>   
>   	node = pdev->dev.of_node;
>   	if (node == NULL)
> @@ -860,11 +859,10 @@ static int octeon_cf_probe(struct platfo
>   	if (!cf_port)
>   		return -ENOMEM;
>   
> -	cf_port->is_true_ide = (of_find_property(node, "cavium,true-ide", NULL) != NULL);
> +	cf_port->is_true_ide = of_property_read_bool(node, "cavium,true-ide");
>   
> -	prop = of_get_property(node, "cavium,bus-width", NULL);
> -	if (prop)
> -		is_16bit = (be32_to_cpup(prop) == 16);
> +	if (of_property_read_u32(node, "cavium,bus-width", &bus_width) == 0)
> +		is_16bit = (bus_width == 16);
>   	else
>   		is_16bit = false;
>   
> 
> 
> 

