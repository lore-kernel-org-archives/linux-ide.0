Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35173C54E76
	for <linux-ide@archiver.kernel.org>; Fri,  6 Jan 2023 06:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjAFGZq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 6 Jan 2023 01:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjAFGZj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jan 2023 01:25:39 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF80B6E0C4
        for <linux-ide@vger.kernel.org>; Thu,  5 Jan 2023 22:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672986338; x=1704522338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OSh6iG/oZQCvISR52oSqMQP40dJuSBVTYSD1idAC9QE=;
  b=jp8tQfV+6F8WcjLAZQKru5l+5Q5R0PtlxnyvqdOjkzi0CLqLF9TZqv6N
   oqJueotd3TpP18szhwoG05Q8NPlwFbqPV7SWVT0tWWi9AftndvYei3e7P
   npKfIhsL/jkFomTrOh3iNLXXi/001r4+ZJkmpyrxyWCOi6OSPA8m5yoi+
   iKVIpxwr7acmoQANJ48Uo0o8Jj24nIxwppP9PKgXQDELYZcsidW099g5I
   EU99oRY+wnXTZ6YNG2E7XBbYa3t+xlCj0y/1xwtsu+/tlQAo+Duxb9kRQ
   oh863zxgLq4PCS1Jw3xVvVtSo7s14NerGts9Ev6myxkip+DWjJyf8D0Yl
   A==;
X-IronPort-AV: E=Sophos;i="5.96,304,1665417600"; 
   d="scan'208";a="218417433"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 14:25:36 +0800
IronPort-SDR: X0BbIt2MgHHAqYHsM4tsqoxCz1UP3Yv47KqXoAH8lXfSI1M3ZnG8xmdRProwlB90LfDFW5OBvO
 4xybwnPoJ+Q1wE9ew4KLC2ygBxISKBN94BWsCDgcaIcWcayqtZpESRCgfjDsbNIfTHj7zgw4B0
 D6cTGa2tWIqSKzQuxHir0XuUI+KoudZ7hgibgFojgpemdXoAT/Fp7fGfxNKkEdPqj5wpvhNWVa
 wkEUpDt2oyFBdsVeUHb/u4sNBzrIpUJng9OlA8mmztfutNrE1deJYpOKyZkD/OZo9/oHHAQhPl
 kek=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jan 2023 21:43:31 -0800
IronPort-SDR: HAHg+YB3w2K+Cr51pAHnnXNeGTi99xonEzHSWI1L1B5SYmJOK4f3kpfVdxUT6Pq0lrEu2YOdJ6
 7SBFxOnONgpZrTUshMvq8g3fWjvLRPCcCoswUEhhtOzehZV06WmR5GCGte0AppoJvc9Wg7hllp
 sMjZpCI7zjaQh7WvRSHF7oEP8B4sFrrh3xUU+xKPkrniyLsjgfIdaKY4+XK5ZCNHUOpT5KTjjz
 5hbXcZt4Js0pleohuUNNAgjC1C/F/E0K6si8yL8iTshFGpSHOBOw7aSXwLhoDaOrXEbTLxWmB/
 Rgk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jan 2023 22:25:37 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpCy75VfFz1Rwtl
        for <linux-ide@vger.kernel.org>; Thu,  5 Jan 2023 22:25:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672986334; x=1675578335; bh=OSh6iG/oZQCvISR52oSqMQP40dJuSBVTYSD
        1idAC9QE=; b=tL5usHqaa2eswcXq8vAuBvAvrB8x7hZAcO4nXPqFh8OUfs+VcDL
        BNxXLIosK4QFXyuF67qObvHerSwPm5FB0wMf8MVK+cfVXjvF0i3qII0lNOjjHRtT
        dVr3EN2cf9LK1Fqp15lArx8+Aa/hrtihNPsXgEGbzxqiVLyT0fMffDbxN8v3qGwg
        sfQ3V3yScUOJ8le/60ePrFV4aYTA+op5rvfhEmsZ1AvHIUtB94SKg77ZIG3sqM3p
        OS18vVQYoX8uokbWEHbpWJT+qqimr6F+6YuxhUN6crEPhpMZiP+wd0Cf5/JRku9+
        kbq5Jhe5zjXsALtltDsF7OTZIvO9Ip0ynSw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dyJuEyRopYX9 for <linux-ide@vger.kernel.org>;
        Thu,  5 Jan 2023 22:25:34 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpCy50ZVpz1RvLy;
        Thu,  5 Jan 2023 22:25:32 -0800 (PST)
Message-ID: <2f5efafb-058c-566c-0b2e-a5dd8f4ae2ef@opensource.wdc.com>
Date:   Fri, 6 Jan 2023 15:25:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 08/27] ata: remove palmld pata driver
To:     Arnd Bergmann <arnd@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marek Vasut <marek.vasut@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-9-arnd@kernel.org>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230105134622.254560-9-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/5/23 22:46, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The PXA palmld machine was removed, so the pata driver is no
> longer used and can be removed. There is a chance that some of
> this code might be useful for turning some of the other PXA
> PCMCIA host drivers into PATA drivers, but it's clear that
> it would not work unmodified, and it seems unlikely that
> someone would do this work.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Feel free to queue this through your tree. Thanks !

> ---
>  drivers/ata/Kconfig       |   9 ---
>  drivers/ata/Makefile      |   1 -
>  drivers/ata/pata_palmld.c | 137 --------------------------------------
>  3 files changed, 147 deletions(-)
>  delete mode 100644 drivers/ata/pata_palmld.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index e4d9e39b08dd..4aafb75bf0c3 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -1082,15 +1082,6 @@ config PATA_OPTI
>  
>  	  If unsure, say N.
>  
> -config PATA_PALMLD
> -	tristate "Palm LifeDrive PATA support"
> -	depends on MACH_PALMLD
> -	help
> -	  This option enables support for Palm LifeDrive's internal ATA
> -	  port via the new ATA layer.
> -
> -	  If unsure, say N.
> -
>  config PATA_PCMCIA
>  	tristate "PCMCIA PATA support"
>  	depends on PCMCIA
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 0a863e7f3c60..4ee5c0761d90 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -105,7 +105,6 @@ obj-$(CONFIG_PATA_MPIIX)	+= pata_mpiix.o
>  obj-$(CONFIG_PATA_NS87410)	+= pata_ns87410.o
>  obj-$(CONFIG_PATA_OPTI)		+= pata_opti.o
>  obj-$(CONFIG_PATA_PCMCIA)	+= pata_pcmcia.o
> -obj-$(CONFIG_PATA_PALMLD)	+= pata_palmld.o
>  obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
>  obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
>  obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
> diff --git a/drivers/ata/pata_palmld.c b/drivers/ata/pata_palmld.c
> deleted file mode 100644
> index 51caa2a427dd..000000000000

-- 
Damien Le Moal
Western Digital Research

