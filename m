From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH 1/7] drivers/ide/ide-cs.c: adjust suspicious bit operation
Date: Fri, 08 Jun 2012 09:30:28 +0200
Message-ID: <4FD1AA14.1080808@bfs.de>
References: <1339018901-28439-1-git-send-email-Julia.Lawall@lip6.fr> <1339018901-28439-2-git-send-email-Julia.Lawall@lip6.fr> <20120607.144616.2224976714259476349.davem@davemloft.net> <alpine.DEB.2.02.1206080712510.1793@hadrien>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx01.sz.bfs.de ([194.94.69.103]:62985 "EHLO mx01.sz.bfs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757505Ab2FHHaa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jun 2012 03:30:30 -0400
In-Reply-To: <alpine.DEB.2.02.1206080712510.1793@hadrien>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org



Am 08.06.2012 07:14, schrieb Julia Lawall:
>> From nobody Wed Jun  6 21:48:37 CEST 2012
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> To: "David S. Miller" <davem@davemloft.net>
> Cc: linux-ide@vger.kernel.org,linux-kernel@vger.kernel.org,joe@perches.com
> Subject: [PATCH 1/7] drivers/ide/ide-cs.c: adjust suspicious bit operation
> 
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> IO_DATA_PATH_WIDTH_8 is 0, so a bit-and with it is always false.  The
> value IO_DATA_PATH_WIDTH covers the bits of the IO_DATA_PATH constants, so
> first pick those bits and then make the test using !=.
> 
> This problem was found using Coccinelle (http://coccinelle.lip6.fr/).
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  drivers/ide/ide-cs.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ide/ide-cs.c b/drivers/ide/ide-cs.c
> index 28e344e..f1e922e 100644
> --- a/drivers/ide/ide-cs.c
> +++ b/drivers/ide/ide-cs.c
> @@ -167,7 +167,8 @@ static int pcmcia_check_one_config(struct
> pcmcia_device *pdev, void *priv_data)
>  {
>      int *is_kme = priv_data;
> 
> -    if (!(pdev->resource[0]->flags & IO_DATA_PATH_WIDTH_8)) {
> +    if ((pdev->resource[0]->flags & IO_DATA_PATH_WIDTH)
> +        != IO_DATA_PATH_WIDTH_8) {
>          pdev->resource[0]->flags &= ~IO_DATA_PATH_WIDTH;
>          pdev->resource[0]->flags |= IO_DATA_PATH_WIDTH_AUTO;
>      }
> -- 

please patch until it is removed from the kernel code.
this will make checks happy and as fact of life such bug tend to show up
on surprising unpleasant times.

re,
 wh
