From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] ide: add __init/__exit macros to
 drivers/ide/scc_pata.c
Date: Tue, 5 Jan 2010 11:25:13 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001051124150.2277@pobox.suse.cz>
References: <1261470564-23754-1-git-send-email-peterhuewe@gmx.de> <1261470564-23754-2-git-send-email-peterhuewe@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:49340 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab0AEKZT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Jan 2010 05:25:19 -0500
In-Reply-To: <1261470564-23754-2-git-send-email-peterhuewe@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Huewe <peterhuewe@gmx.de>
Cc: kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 22 Dec 2009, peterhuewe@gmx.de wrote:

> From: Peter Huewe <peterhuewe@gmx.de>
> 
> Trivial patch which adds the __init/__exit macros to the module_init/
> module_exit functions of
> 
> drivers/ide/scc_pata.c
> 
> Please have a look at the small patch and either pull it through
> your tree, or please ack' it so Jiri can pull it through the trivial
> tree.
> 
> Patch against linux-next-tree, 22. Dez 08:38:18 CET 2009
> but also present in linus tree.
> 
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
>  drivers/ide/scc_pata.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ide/scc_pata.c b/drivers/ide/scc_pata.c
> index 1104bb3..58c9c91 100644
> --- a/drivers/ide/scc_pata.c
> +++ b/drivers/ide/scc_pata.c
> @@ -872,14 +872,14 @@ static struct pci_driver scc_pci_driver = {
>  	.remove = __devexit_p(scc_remove),
>  };
>  
> -static int scc_ide_init(void)
> +static int __init scc_ide_init(void)
>  {
>  	return ide_pci_register_driver(&scc_pci_driver);
>  }
>  
>  module_init(scc_ide_init);
>  /* -- No exit code?
> -static void scc_ide_exit(void)
> +static void __exit scc_ide_exit(void)
>  {
>  	ide_pci_unregister_driver(&scc_pci_driver);
>  }

This code is commented out anyway. So we should either nuke it out 
completely if it is not needed, or uncomment and fix.

Bartlomiej, David?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
