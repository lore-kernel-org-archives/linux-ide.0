From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 1/3] ata: sata_mv: introduce compatible string "marvell,armada-370-xp-sata"
Date: Tue, 14 Jan 2014 15:59:35 +0100
Message-ID: <52D550D7.3000405@free-electrons.com>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org> <1389711007-7239-2-git-send-email-simon.guinot@sequanux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1389711007-7239-2-git-send-email-simon.guinot@sequanux.org>
Sender: stable-owner@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>, Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Simon, Jeff, Tejun,

On 14/01/2014 15:50, Simon Guinot wrote:
> The sata_mv driver supports the SATA IP found in several Marvell SoCs.
> As some new SATA registers have been introduced with the Armada 370/XP
> SoCs, a way to identify them is needed.
> 
> This patch introduces a new compatible string for the SATA IP found in
> Armada 370/XP SoCs.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Lior Amsalem <alior@marvell.com>
> Cc: stable@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/ata/marvell.txt | 2 +-
>  drivers/ata/sata_mv.c                             | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/marvell.txt b/Documentation/devicetree/bindings/ata/marvell.txt
> index b5cdd20cde9c..a52a5d018042 100644
> --- a/Documentation/devicetree/bindings/ata/marvell.txt
> +++ b/Documentation/devicetree/bindings/ata/marvell.txt
> @@ -1,7 +1,7 @@
>  * Marvell Orion SATA
>  
>  Required Properties:
> -- compatibility : "marvell,orion-sata"
> +- compatibility : "marvell,orion-sata" or "marvell,armada-370-xp-sata"

Usually we try to use the name of the first SoC instead of a family name.
So here it should be "marvell,armada-370-sata"

Thanks,

Gregory


>  - reg           : Address range of controller
>  - interrupts    : Interrupt controller is using
>  - nr-ports      : Number of SATA ports in use.
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 56be31819897..df35c521a141 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4209,6 +4209,7 @@ static int mv_platform_resume(struct platform_device *pdev)
>  
>  #ifdef CONFIG_OF
>  static struct of_device_id mv_sata_dt_ids[] = {
> +	{ .compatible = "marvell,armada-370-xp-sata", },
>  	{ .compatible = "marvell,orion-sata", },
>  	{},
>  };
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
