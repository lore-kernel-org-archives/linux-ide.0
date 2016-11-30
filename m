From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] pata_legacy: Allow disabling of legacy PATA device probes
 on non-PCI systems
Date: Wed, 30 Nov 2016 16:11:39 +0300
Message-ID: <84a95190-9e30-81ac-5f23-744243ba7fce@cogentembedded.com>
References: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36242 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756793AbcK3NLo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2016 08:11:44 -0500
Received: by mail-lf0-f49.google.com with SMTP id t196so146492130lff.3
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2016 05:11:43 -0800 (PST)
In-Reply-To: <1480441982-20992-1-git-send-email-tedheadster@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Whitehead <tedheadster@gmail.com>, linux-ide@vger.kernel.org

Hello.

On 11/29/2016 08:53 PM, Matthew Whitehead wrote:

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

    *bool* instead please. And better rename it as port_ignored() I think.

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

    parens around !find_port() not needed.

>  		legacy_probe_add(0x1F0, 14, UNKNOWN, 0);
> -	if (secondary == 0 || all)
> +	if ((secondary == 0 || all) && (!find_port(0x170)))

    Same here.

>  		legacy_probe_add(0x170, 15, UNKNOWN, 0);
>
>  	if (probe_all || !pci_present) {
>  		/* ISA/VLB extra ports */
> -		legacy_probe_add(0x1E8, 11, UNKNOWN, 0);
> -		legacy_probe_add(0x168, 10, UNKNOWN, 0);
> -		legacy_probe_add(0x1E0, 8, UNKNOWN, 0);
> -		legacy_probe_add(0x160, 12, UNKNOWN, 0);
> +
> +		if (!find_port(0x1E0))

    0x1E8 maybe?

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
[...]

MBR, Sergei

