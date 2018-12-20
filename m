From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
Date: Thu, 20 Dec 2018 18:03:05 +0100
Message-ID: <b3331d3f-3bfd-f3ce-cea1-30c4b13e6374@samsung.com>
References: <CGME20181121130510epcas3p4498edc67a02f61a6aa8e55efa9349681@epcas3p4.samsung.com>
        <20181121130439.22255-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121130439.22255-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>, axboe@kernel.dk
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On 11/21/2018 02:04 PM, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

>  drivers/ata/pata_macio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index 9588e685d994..8cc9c429ad95 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -483,6 +483,8 @@ static int pata_macio_cable_detect(struct ata_port *ap)
>  		struct device_node *root = of_find_node_by_path("/");
>  		const char *model = of_get_property(root, "model", NULL);
>  
> +		of_node_put(root);
> +
>  		if (cable && !strncmp(cable, "80-", 3)) {
>  			/* Some drives fail to detect 80c cable in PowerBook
>  			 * These machine use proprietary short IDE cable
> 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
