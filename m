From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Wed, 30 Nov 2016 14:12:58 +0100
Message-ID: <1963956.oQHPLFR1eb@amdc3058>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44126 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756170AbcK3NNC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2016 08:13:02 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHG0337DI1P7420@mailout3.samsung.com> for
 linux-ide@vger.kernel.org; Wed, 30 Nov 2016 22:13:01 +0900 (KST)
In-reply-to: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Whitehead <tedheadster@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>


Hi,

On Tuesday, November 29, 2016 12:53:02 PM Matthew Whitehead wrote:
> If there is no PCI bus detected in drivers/ata/pata_legacy.c, it registers all the
> common legacy PATA devices. This includes I/O ports (0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160)
> and also their associated interrupts (14,15,11,10,8,12).
> 
> Unfortunately, on such systems those interrupt lines are at a premium because there is no
> PCI alternative. This patch allows you to disable individual port/interrupt pairs by providing
> a list of ports to skip allocating.
> 
> modprobe pata_legacy ignore_ports=0x1e8,0x168,0x1e0,0x160
> 
> Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
> ---
>  drivers/ata/pata_legacy.c |   32 +++++++++++++++++++++++++-------
>  1 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
> index 4fe9d21..753c7ce 100644
> --- a/drivers/ata/pata_legacy.c
> +++ b/drivers/ata/pata_legacy.c
> @@ -130,6 +130,8 @@ static struct legacy_data legacy_data[NR_HOST];
>  static struct ata_host *legacy_host[NR_HOST];
>  static int nr_legacy_host;
>  
> +static int ignore_ports[NR_HOST];
> +static int ignore_ports_count;
>  
>  static int probe_all;		/* Set to check all ISA port ranges */
>  static int ht6560a;		/* HT 6560A on primary 1, second 2, both 3 */
> @@ -1168,6 +1170,17 @@ static __init void probe_qdi_vlb(void)
>  	}
>  }
>  
> +int find_port(int port)

this should be static

> +{
> +	int i;
> +	for (i = 0 ; i < ignore_ports_count; i++) {
> +		if (port == ignore_ports[i])
> +			return 1;
> +	}
> +	return 0;
> +}
> +		
> +
>  /**
>   *	legacy_init		-	attach legacy interfaces
>   *
> @@ -1212,17 +1225,22 @@ static __init int legacy_init(void)
>  	if (winbond == 1)
>  		winbond = 0x130;	/* Default port, alt is 1B0 */
>  
> -	if (primary == 0 || all)
> +	if ((primary == 0 || all) && (!find_port(0x1F0)))

extra parentheses are not necessary

>  		legacy_probe_add(0x1F0, 14, UNKNOWN, 0);
> -	if (secondary == 0 || all)
> +	if ((secondary == 0 || all) && (!find_port(0x170)))
>  		legacy_probe_add(0x170, 15, UNKNOWN, 0);

ditto

>  	if (probe_all || !pci_present) {
>  		/* ISA/VLB extra ports */
> -		legacy_probe_add(0x1E8, 11, UNKNOWN, 0);
> -		legacy_probe_add(0x168, 10, UNKNOWN, 0);
> -		legacy_probe_add(0x1E0, 8, UNKNOWN, 0);
> -		legacy_probe_add(0x160, 12, UNKNOWN, 0);
> +
> +		if (!find_port(0x1E0))

I believe it should be 0x1E8

> +			legacy_probe_add(0x1E8, 11, UNKNOWN, 0);
> +		if (!find_port(0x168))
> +			legacy_probe_add(0x168, 10, UNKNOWN, 0);
> +		if (!find_port(0x1E0))
> +			legacy_probe_add(0x1E0, 8, UNKNOWN, 0);
> +		if (!find_port(0x160))
> +			legacy_probe_add(0x160, 12, UNKNOWN, 0);
>  	}
>  
>  	if (opti82c46x)
> @@ -1272,6 +1290,6 @@ module_param(qdi, int, 0);
>  module_param(winbond, int, 0);
>  module_param(pio_mask, int, 0);
>  module_param(iordy_mask, int, 0);
> -
> +module_param_array(ignore_ports, int, &ignore_ports_count, 0444);

please leave a newline before module_init()

>  module_init(legacy_init);
>  module_exit(legacy_exit);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

