From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata-sff: Don't scan disabled ports when checking for
 legacy mode.
Date: Mon, 23 Jan 2017 11:29:18 +0300
Message-ID: <77dacb3d-3466-b8e9-c914-9b81cf0edfc9@cogentembedded.com>
References: <497610a8448.441e0a10@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33378 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWI3W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2017 03:29:22 -0500
Received: by mail-lf0-f43.google.com with SMTP id x1so2702879lff.0
        for <linux-ide@vger.kernel.org>; Mon, 23 Jan 2017 00:29:22 -0800 (PST)
In-Reply-To: <497610a8448.441e0a10@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>, linux-ide@vger.kernel.org

Hello!

On 1/20/2017 8:58 PM, Darren Stevens wrote:

> libata-sff.c checks for legacy mode by testing if both primary
> and secondary ports on a controller are in legacy mode and selects
> legacy if either one is. However on some southbridge chips (e.g

    South bridge.

> AMD SB600/SB700) the secondary port is not wired, and when it is
> disabled by setting the disable bit in the PCI header it appears
> as a fixed legacy port.
> Prevent incorrect detection by not testing ports that are marked
> as 'dummy'
>
> Signed-off-by: Darren Stevens <darren@stevens-zone.net>
> ---
>
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 051b615..05f688a 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -2429,9 +2429,16 @@ int ata_pci_sff_activate_host(struct ata_host *host,
>     if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
>         u8 tmp8, mask;
>
> -       /* TODO: What if one channel is in native mode ... */
> +       /*
> +        * ATA spec says we should use legacy mode when one
> +        * port is in legacy mode, but disabled ports on some
> +        * PCI hosts appear as fixed legacy ports, e.g SB600/700
> +        * on which the secondary port is not wired, so
> +        * ignore ports that we've marked as 'dummy' during
> +        * this check
> +        */
>         pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
> -       mask = (1 << 2) | (1 << 0);
> +       mask = (! ata_port_is_dummy(host->ports[1]) << 2) | (!
> ata_port_is_dummy(host->ports[0]) << 0);

    In addition to what Tejun said: no need for spaces after !.

[...]

MBR, Sergei

