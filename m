Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F923C433FE
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 00:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346968AbiCXBAM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238940AbiCXBAM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 21:00:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20E1BE07
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 17:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648083520; x=1679619520;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OTBnl5Cs2iyIhyA4xwKnzLy274oypsjBtyCg7TPtK4s=;
  b=h1/qJpPZrkydQNNmhK+2kkRTwqJD5JydAuVvCVRFeBp2oaDpoBNMh+BO
   1UHtjoC6g2TnTddpF4B7soF+Ci/uh7fPc5NVaehNEYkqggF7Fy5Tf0JEr
   JvjFZdozeJ4ZVRv0RqwEALxkrYTmgKuBeRVf4aX0zF3ZdO+wUcfJwJd1f
   sout0uvH3J96RUa7y4GXpusmVYTxktQ3vCLN74UOWBM9bHKOgkRSSvVQr
   FGtIHZjtlYTkilA1HF8F/i0Qg3sglCKIvt7bT+agoERAfnmd/sZ4penja
   SPLE7i4qtquHwEiaStxqVRXVoc4mLFoKP1VSU+Kli+XtYaf8xronQMfLS
   g==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="300264250"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 08:58:38 +0800
IronPort-SDR: rNdCSrQAbP+Re9nmIN6xZ4KV9DH6Z1slLrmJP1iBACn2r4qMBHDHRUxeqfuc2bVakx4wMEhRcj
 tP8CPapVdqUE10TY6NDgo9pHRgDL9T27hFL7t3SPAjajnu9AmlEop8z016eyNXW/oI0bLO+LzR
 LDfWPVvYaJ/r3vsGdy0gj/NcAeO5ywiDnz02kPb1UpcxmW/42sk0twiAXqOPGu4MZwL3t+uCRd
 gCi7mde/A2DTXIH8/1NwsppDGIFKW9k8ao58vXMoDb88k3X+SQgo8EYGZ/YO3s6x2GO+/MqRu4
 yB4NCesV7a2mnqef6y4FQeMM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:30:31 -0700
IronPort-SDR: 2hphGytCiuW+JHtpfQDzlQsqc3dvcltz2PT+3kB2HmX7Qg+xAXXpgI2wPZalorSGgh3DrPrte+
 U6BClPHQv6G7BBMULc8bDT5DEwmjurm/xNKNS3L5h13vi+0f5tsLC0X3TdwgM9p+46BTOmNZSR
 H6yqqPvf0PE6PhuNTpbS4ijRvAY3UsKgCNrpYXlOURVL9XDm35q5WTiUw19rbPruIGHBi6P3GH
 BiXcRipwOs6qQFJGCgOi5frTA0EamHaLdlqhkXrpcO4/Uq8GTCItxg1mIITRKiFAP1iw9V6jUb
 rFs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:58:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP6Kp22JKz1SVp1
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 17:58:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648083517; x=1650675518; bh=OTBnl5Cs2iyIhyA4xwKnzLy274oypsjBtyC
        g7TPtK4s=; b=rl0yHPhzOn7IhkdRtQt4dvoLgPKIMRnxDzb4OXrPrqNCcvhNvg1
        52d7VcIVnG1ujALfEOJmJu8BFwHxDMNyHbqG8seEJicX6SiPCPwAG8cyQ+Eixb4+
        IHWufkJa3sgVyJnYkNol2+DuYURUEQ2Rh1xoPYO3J8dIYzXk/Pj32frRWRhJaDZ5
        DdiWPAx83zNCWZfEG8SsFIHLRKBYU4tS7mnOZesdaU5VX1G3CeRubbEHemvXUqjO
        oWm+7IfrXlvl8RvaC8yXM8Ov8FcR0kJENrtXkKlFbDsGETwUl3JLOYTXLlR30nJx
        flXuWh26v0gZPpBz+COs1Q0j7QBRdL6RpGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IgOeXm7klToq for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 17:58:37 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP6Km0fgGz1Rvlx;
        Wed, 23 Mar 2022 17:58:35 -0700 (PDT)
Message-ID: <9128f850-fcc1-811e-b781-b7fbcb2403ba@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 09:58:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 03/21] ata: libahci_platform: Explicitly set rc on
 devres_alloc failure
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-4-Sergey.Semin@baikalelectronics.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220324001628.13028-4-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 09:16, Serge Semin wrote:
> It's better for readability and maintainability to explicitly assign an
> error number to the variable used then as a return value from the method
> on the cleanup-on-error path. So adding new code in the method we won't

No it is not. On-stack variable initialization is not free. So if
initializing the variable is not needed, do not do it.

> have to think whether the overridden rc-variable is set afterward in case
> of an error. Saving one line of code doesn't worth it especially seeing
> the rest of the ahci_platform_get_resources() function errors handling
> blocks do explicitly write errno to rc.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/ata/libahci_platform.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 18296443ccba..1bd2f1686239 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  	struct ahci_host_priv *hpriv;
>  	struct clk *clk;
>  	struct device_node *child;
> -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
> +	int i, enabled_ports = 0, rc = 0, child_nodes;
>  	u32 mask_port_map = 0;
>  
>  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> @@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  
>  	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
>  			     GFP_KERNEL);
> -	if (!hpriv)
> +	if (!hpriv) {
> +		rc = -ENOMEM;
>  		goto err_out;
> +	}

If you set rc to -ENOMEM here, then the 0 initialization of rc is not needed.

>  
>  	devres_add(dev, hpriv);
>  


-- 
Damien Le Moal
Western Digital Research
