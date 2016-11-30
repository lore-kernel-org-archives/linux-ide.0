From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH,v2] pata_legacy: Allow disabling of legacy PATA device
 probes on non-PCI systems
Date: Wed, 30 Nov 2016 20:24:56 +0300
Message-ID: <a4bf2511-c9bc-1680-6c91-81af0805ac40@cogentembedded.com>
References: <1480440386-20400-1-git-send-email-tedheadster@gmail.com>
 <1480526456-15797-1-git-send-email-tedheadster@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35164 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758554AbcK3RZB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 30 Nov 2016 12:25:01 -0500
Received: by mail-lf0-f44.google.com with SMTP id b14so151956713lfg.2
        for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2016 09:25:00 -0800 (PST)
In-Reply-To: <1480526456-15797-1-git-send-email-tedheadster@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Whitehead <tedheadster@gmail.com>, linux-ide@vger.kernel.org, tj@kernel.org, b.zolnierkie@samsung.com, gnomes@lxorguk.ukuu.org.uk

Hello.

On 11/30/2016 08:20 PM, Matthew Whitehead wrote:

> If there is no PCI bus detected in drivers/ata/pata_legacy.c, it registers all
> the common legacy PATA devices. This includes I/O ports (0x1f0, 0x170, 0x1e8,
> 0x168, 0x1e0, 0x160) and also their associated interrupts (14,15,11,10,8,12).
>
> Unfortunately, on such systems those interrupt lines are at a premium because
> there is no PCI alternative. This patch allows you to disable individual
> port/interrupt pairs by providing a list of ports to skip allocating.
>
> modprobe pata_legacy ignore_ports=0x1e8,0x168,0x1e0,0x160
>
> Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
> ---
>  drivers/ata/pata_legacy.c |   30 ++++++++++++++++++++++++------
>  1 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
> index 4fe9d21..65a33b4 100644
> --- a/drivers/ata/pata_legacy.c
> +++ b/drivers/ata/pata_legacy.c
> @@ -130,6 +130,8 @@ static struct legacy_data legacy_data[NR_HOST];
>  static struct ata_host *legacy_host[NR_HOST];
>  static int nr_legacy_host;
>
> +static int ignore_ports[NR_HOST];
> +static int ignore_ports_count;

    It's ignore_port_count if my grammar serves still. :-)

>
>  static int probe_all;		/* Set to check all ISA port ranges */
>  static int ht6560a;		/* HT 6560A on primary 1, second 2, both 3 */
> @@ -1168,6 +1170,16 @@ static __init void probe_qdi_vlb(void)
>  	}
>  }
>
> +static bool port_ignored(int port)
> +{
> +	int i;

    Need empty line here.

> +	for (i = 0; i < ignore_ports_count; i++) {
> +		if (port == ignore_ports[i])
> +			return 1;

    s/1/true/.

> +	}
> +	return 0;

    s/0/false/.

[...]

MBR, Sergei

