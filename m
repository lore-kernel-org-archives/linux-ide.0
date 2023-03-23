Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A58AC6FD1C
	for <linux-ide@archiver.kernel.org>; Thu, 23 Mar 2023 21:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCWVBV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCWVBS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2023 17:01:18 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2EE623113
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2023 14:01:07 -0700 (PDT)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id AD4797A004B;
        Thu, 23 Mar 2023 22:01:05 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 1/2] ata: pata_parport-bpck6: Remove dependency on 64BIT
Date:   Thu, 23 Mar 2023 22:01:02 +0100
User-Agent: KMail/1.9.10
Cc:     linux-ide@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>
References: <20230323033836.352672-1-damien.lemoal@opensource.wdc.com> <20230323033836.352672-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230323033836.352672-2-damien.lemoal@opensource.wdc.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202303232201.02920.linux@zary.sk>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thursday 23 March 2023 04:38:35 Damien Le Moal wrote:
> There is no reason to have compilation of the bpck6 protocol module
> being dependent on 64BIT. Remove this dependency.

Great, I planned to do this but forgot. Thanks.
 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/pata_parport/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/Kconfig
> index 0893a13e7979..2c953f5d1396 100644
> --- a/drivers/ata/pata_parport/Kconfig
> +++ b/drivers/ata/pata_parport/Kconfig
> @@ -25,7 +25,7 @@ config PATA_PARPORT_BPCK
>  
>  config PATA_PARPORT_BPCK6
>  	tristate "MicroSolutions backpack (Series 6) protocol"
> -	depends on (PATA_PARPORT) && !64BIT
> +	depends on PATA_PARPORT
>  	help
>  	  This option enables support for the Micro Solutions BACKPACK
>  	  parallel port Series 6 IDE protocol.  (Most BACKPACK drives made


-- 
Ondrej Zary
