Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE97EC433EF
	for <linux-ide@archiver.kernel.org>; Fri, 24 Dec 2021 17:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353367AbhLXR4m (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:56:42 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:44274 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353366AbhLXR4l (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2021 12:56:41 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru DC2AB20A921E
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3 01/10] ata: pata_platform: Make use of
 platform_get_mem_or_io()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        <linux-ide@vger.kernel.org>
References: <20211224131300.18198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224131300.18198-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b2bb45db-d0ab-a816-a50c-cdef0c125761@omp.ru>
Date:   Fri, 24 Dec 2021 20:56:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211224131300.18198-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 12/24/21 4:12 PM, Lad Prabhakar wrote:

> Make use of platform_get_mem_or_io() to simplify the code.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>  drivers/ata/pata_platform.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> index 028329428b75..cb3134bf88eb 100644
> --- a/drivers/ata/pata_platform.c
> +++ b/drivers/ata/pata_platform.c
> @@ -198,22 +198,16 @@ static int pata_platform_probe(struct platform_device *pdev)
>  	/*
>  	 * Get the I/O base first
>  	 */
> -	io_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (io_res == NULL) {
> -		io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (unlikely(io_res == NULL))
> -			return -EINVAL;
> -	}
> +	io_res = platform_get_mem_or_io(pdev, 0);
> +	if (unlikely(!io_res))

   You don't have to keep unlikely() here -- the first *if* doesn't have it anyway,
only the 2nd one does...

> +		return -EINVAL;
>  
>  	/*
>  	 * Then the CTL base
>  	 */
> -	ctl_res = platform_get_resource(pdev, IORESOURCE_IO, 1);
> -	if (ctl_res == NULL) {
> -		ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -		if (unlikely(ctl_res == NULL))
> -			return -EINVAL;
> -	}
> +	ctl_res = platform_get_mem_or_io(pdev, 1);
> +	if (unlikely(!ctl_res))

   Ditto.

> +		return -EINVAL;

MBR, Sergey
