Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9D5C433EF
	for <linux-ide@archiver.kernel.org>; Thu,  3 Feb 2022 18:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353592AbiBCSyF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:54:05 -0500
Received: from relay.hostedemail.com ([64.99.140.27]:57843 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiBCSyE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2022 13:54:04 -0500
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 7D1AD22CC3;
        Thu,  3 Feb 2022 18:54:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id BE33980013;
        Thu,  3 Feb 2022 18:53:40 +0000 (UTC)
Message-ID: <5d0c792dd4aadb2eb68ea23da18e77a7411f59a3.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add myself as Renesas R-Car SATA driver
 reviewer
From:   Joe Perches <joe@perches.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Thu, 03 Feb 2022 10:54:01 -0800
In-Reply-To: <6c1f0131-fb02-f30a-86ed-63ce3788901b@omp.ru>
References: <6c1f0131-fb02-f30a-86ed-63ce3788901b@omp.ru>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yswek7bhw7j4xstjd6tif85jfdqky1z6
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: BE33980013
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Npjq01u40wENQV1uE14Iwb1CtNvD5Y68=
X-HE-Tag: 1643914420-85847
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, 2022-02-03 at 20:51 +0300, Sergey Shtylyov wrote:
> Add myself as a reviewer for the Renesas R-Car SATA driver -- I don't have
> the hardware anymore (Geert Uytterhoeven does have a lot of hardware!) but
> I do have the manuals still! :-)

Thanks.

> --- libata.orig/MAINTAINERS
> +++ libata/MAINTAINERS
> @@ -16469,6 +16469,13 @@ F:	Documentation/devicetree/bindings/i2c
>  F:	drivers/i2c/busses/i2c-rcar.c
>  F:	drivers/i2c/busses/i2c-sh_mobile.c
>  
> +RENESAS R-CAR SATA DRIVER
> +R:	Sergey Shtylyov <s.shtylyov@omp.ru>
> +L:	linux-ide@vger.kernel.org
> +L:	linux-renesas-soc@vger.kernel.org
> +F:	Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> +F:	drivers/ata/sata_rcar.c

I believe it's better for every section to have an S: entry


