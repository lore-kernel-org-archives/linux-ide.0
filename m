Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F2FC77B7A
	for <linux-ide@archiver.kernel.org>; Thu,  1 Jun 2023 23:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjFAXr7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFAXr6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jun 2023 19:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FE318C;
        Thu,  1 Jun 2023 16:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E13F64AED;
        Thu,  1 Jun 2023 23:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A99C433EF;
        Thu,  1 Jun 2023 23:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685663276;
        bh=9SnYNz0oftD/gNj6449esXN/fwK+VLCPMPOd7S4wcRY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ejP+NwigTPbMtNUgyRRhQi4I0oOSjC+fVNj7HasLjE+vpzhOpNFZ8M3PVtntv0KZU
         5GFJTaFn689DnlOqANpQ0vqv9W1kzyDbjB2f0wgt/iePaLVva0ioapFCyQsNVer0BZ
         7UspADzZIISWD942y8VKdUlZFThP9xG9RGbAjTGY0WSKvfmN0bAoiiVl717OKV3Tps
         yDTNVKVYZjUsDirjydWPOplzNOYcOhSCjVNvGElNjDmMY4AtZ/aWmaNuSZi0xNdcKh
         +Bk6BESnjqxzkkvRhS3fHmzW/lqXlYhdWpvAAa4F6Qd+PG4wmOmE9oR0umuQ6rp3qb
         t1WV+O1Ogbfmg==
Message-ID: <f3493f7f-b144-d494-dabf-fdeb41fbd5ec@kernel.org>
Date:   Fri, 2 Jun 2023 08:47:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 26/43] pata: cirrus: add DT support for Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-8-nikita.shubin@maquefel.me>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230601054549.10843-8-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 6/1/23 14:45, Nikita Shubin wrote:
> - find register range from the device tree
> - get interrupts from device tree
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Please change the commit title to:

ata: pata_ep93xx: add device tree support

> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - fixed headers
>     - dropped coma in id table
> 
>  drivers/ata/pata_ep93xx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index c6e043e05d43..8d363bc71342 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -40,6 +40,7 @@
>  #include <linux/ata.h>
>  #include <linux/libata.h>
>  #include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/delay.h>
>  #include <linux/dmaengine.h>
>  #include <linux/ktime.h>
> @@ -1016,9 +1017,16 @@ static int ep93xx_pata_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id ep93xx_pata_of_ids[] = {
> +	{ .compatible = "cirrus,ep9312-pata" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ep93xx_pata_of_ids);
> +
>  static struct platform_driver ep93xx_pata_platform_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
> +		.of_match_table = ep93xx_pata_of_ids,
>  	},
>  	.probe = ep93xx_pata_probe,
>  	.remove = ep93xx_pata_remove,

-- 
Damien Le Moal
Western Digital Research

