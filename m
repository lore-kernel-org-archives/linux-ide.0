Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3C4C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 03:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiJQDCb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Oct 2022 23:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiJQDCa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Oct 2022 23:02:30 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F01C4A13A
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665975749; x=1697511749;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ch6SmaYTvqf+qPB+4eYdtBEaIgZ6ol9EignZTTDeHCM=;
  b=UXEoX1IMac4ymimSMWEg3LqXJulllnPVqkqp3Z04Yht+UgEySFtm2GuO
   GVbeTWXJstyj9044PeAxx+KpRSi+kzCX0CK9TnWc1H1x0GGVd7G1Kvkc9
   cYpXKTNEVnM0bjKG8LWkKj4toiY148GFTTzRvaSmiV7OWKLRkkpI8Jqpq
   9KRLdlf3rXhipES47oFU7wbOyMsvP2gQGxO41/ouC7x+4XS/UMyxUa8cs
   oe4sXHSSdWTUULIHE1gA2fSCT+hyObdixsF6HyAnPaNLXUYnsmI5+A9Rc
   lOzsWJVfYw7uk9kBaX7Z0ynk6UrasZPe5Hc9dd+/IU1x3zntZaPM7N9t+
   g==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="212301789"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 11:02:28 +0800
IronPort-SDR: 3UQ+phamIDHy3YoVis2/YSW23dzNGjtleiE8eMoAlHdkyO97wQWvOioU9+bPDFRXDU2gMNbhNw
 kJDfzVEUsVZb4hCkkbeMPm3kyptwZGCpCX35LBbL2S4yw4DYotIGMZ0cwz17X8LZbiFBWKB+pP
 xhcb3S9yMN0mAEi0tKDb2cKctOvl34F9wnYuUqKaaSftup49XITWfnb43xnoMmRtol1wTrhvcl
 UYekE9Roc45rXSmqJ3iJiwu1C/B1Nu3UX8dMAdhu+Pu9vvkeLoW6lh6Pl1EC9W+vBoT7RI/zp1
 maBbjk7ggBq3WDDGAGekl2So
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:22:02 -0700
IronPort-SDR: g+glxcqZrpE40pKubHB/6+7zZED26yOFpNp9sfrQH93Hrei4fsAMK6isNiKve/Z8MSOHWx+dCG
 wQlLKOSJzgybYauSnYE2tkt9vVy95cbOcaA3NPSleOCo+hrOhFvvnD922R+gJ9dDnin38P9KHE
 VzXRdw882epNtqJ0afVeZCJ3KS/si/DRC3tqidqKks3+g+tbFJxx/ZwF6Cc/67zM/5BS3GTAzL
 pgJ95Q23v906ZRwlIAPMgpWPtoG1+5KEfC+n2Wx8iViMPpAJne5YEfEC/NSFr97pFenFWnGX1g
 Jrs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 20:02:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrMH84GzQz1RvTr
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:02:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665975748; x=1668567749; bh=ch6SmaYTvqf+qPB+4eYdtBEaIgZ6ol9Eign
        ZTTDeHCM=; b=E6gN5v0Kr+QLxBjIOQsq6/nMDMQz9gLFZe5qP1kI8cFLcLpoTSg
        iurMioeDq5eAosMyUm1uMzu/A5vT4SeW8ztjEgP14ibfFujKQMTk6blyDrdcD88k
        k6A4VEOubR32Xjf6xtgEAMa3F52e9MUsmFqCrPJ+VpR98epeTx9sC/Rj4U6liq6B
        z6w9nh0ecjaVLoeij7PN47bwRVujmgeXWmYQcNk6lkzvywX3CtzDkhzySqmHvta8
        0hVZR1DMeFgbxAOJyt0mlQClUZcJD2lQgOm0BPUzyH4aUDHr52Avat1pU8W7myTZ
        lHz+Pfy0fOaWTMdOo4Qtt/lENHpSO3vAKDQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DC67fuf5CLEx for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 20:02:28 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrMH66C6Jz1RvLy;
        Sun, 16 Oct 2022 20:02:26 -0700 (PDT)
Message-ID: <788c5ca3-666e-f7bf-10aa-fea8a8855e55@opensource.wdc.com>
Date:   Mon, 17 Oct 2022 12:02:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/1] ata: ahci-imx: Fix MODULE_ALIAS
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221012131105.725258-1-alexander.stein@ew.tq-group.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221012131105.725258-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/12/22 22:11, Alexander Stein wrote:
> 'ahci:' is an invalid prefix, preventing the module from autoloading.
> Fix this by using the 'platform:' prefix and DRV_NAME.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/ata/ahci_imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index b734e069034d..632caa301458 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -1235,4 +1235,4 @@ module_platform_driver(imx_ahci_driver);
>  MODULE_DESCRIPTION("Freescale i.MX AHCI SATA platform driver");
>  MODULE_AUTHOR("Richard Zhu <Hong-Xing.Zhu@freescale.com>");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("ahci:imx");
> +MODULE_ALIAS("platform:" DRV_NAME);

Applied to for-6.1-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

