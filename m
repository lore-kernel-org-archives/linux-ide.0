From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-sff: Don't scan disabled ports when checking for
 legacy mode.
Date: Fri, 20 Jan 2017 15:41:36 -0500
Message-ID: <20170120204136.GD9280@mtj.duckdns.org>
References: <497610a8448.441e0a10@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36852 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbdATUlj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2017 15:41:39 -0500
Received: by mail-pg0-f49.google.com with SMTP id t6so26200531pgt.3
        for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2017 12:41:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <497610a8448.441e0a10@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>
Cc: linux-ide@vger.kernel.org

Hello,

On Fri, Jan 20, 2017 at 05:58:21PM +0000, Darren Stevens wrote:
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

The patch is damaged and maybe just using two if statements would read
easier?

Thanks.

-- 
tejun
