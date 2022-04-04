Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D5BC433EF
	for <linux-ide@archiver.kernel.org>; Mon,  4 Apr 2022 01:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbiDDBCZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Apr 2022 21:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbiDDBCX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Apr 2022 21:02:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C87A34B94
        for <linux-ide@vger.kernel.org>; Sun,  3 Apr 2022 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649034029; x=1680570029;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0K6ruvmklZtAmW547wtc3rLaKjWJpUK4emO6PT/fVYQ=;
  b=gSZaI6nK0yNc8z1uIGCacmHpEvZqn00mNVA+HDz/wMHDKT2OPW6hwMiR
   ju2UVDWCFUP5pgvSh4qV1JN3GHM/HPfQgKPEVzEuh2iCsxEhGe2qRpKi2
   ARLfz1E1TfJ+JeiSWuchPng8pzm/bQHl6QCc1WAoD+AfM2f8rZ4NKHX6F
   2PtARmxVyOti1SdD0swi5xkisEXdp4aTNpBJ5HW8GRH+MNofbXTC9DMn7
   WmnxLaCighTw5qCQdAT5PVqHhBrt5MAC44TCD9CkCx7de/puGh3USGs81
   CvwuZ0DhF4yLKyombTBFJz32ybd3WAyocfBimBRufeFDIvhIehk2V/kVU
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,233,1643644800"; 
   d="scan'208";a="197884342"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2022 09:00:28 +0800
IronPort-SDR: kGPKapNaJ13S6iIp1z53ONQ+d0yiusxkasnTg4idrDvGE5Ku5mkVw3/9/GW0n6y8UIk75o7btC
 chA3AB9k8aT2Rmc11FGptNVQB6wOmWugUDyX+t9prT1eWrOftK+vubay4jvRwISix9UO51swZ/
 K+8SebClEUGMRFuHXo7M+5qSheZlQGMDwQI/oyuvsbyuv02flUBqRCsoWMWGriWAmdSgAYi/qP
 0Oi8t+xpng7sTwgpqRpFtwH4H7jcSkluXrRZkh7gHd7fyZaG1d2kUatpGiEtlZWAu531p+802r
 bLEbi61NbVwkUGM9oVYPzqTV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 17:32:03 -0700
IronPort-SDR: daYwA+M8WLUMaHqBy1oCTRencFmyUyt/P4ht0uVID+h0tOwMU81H7tpsrUtFXIQxqIFbjvAoGP
 dQ/vF6PFWMCyz+Kb0Xnf22j6u8fDTIZ76N9Jr5vAhP4AWXKG1E/fI8+PrUaNDyDYlMw9ulsIWK
 pHaeQqSN8iDaP5wy7sX1ms0XCNc4uh+HW5eFj0YMcpj6jmcy80xfxZa2vQqyS905R4/oKHfu4G
 eP8BBgx8fwm9q41kQ60z5BQLzA6T/Wx9iVNiPXSM2E5HI6Tyons6CbuWhB/x/geXP4n+QvgO+G
 Y1A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 18:00:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KWsrp6Kgjz1Rwrw
        for <linux-ide@vger.kernel.org>; Sun,  3 Apr 2022 18:00:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649034026; x=1651626027; bh=0K6ruvmklZtAmW547wtc3rLaKjWJpUK4emO
        6PT/fVYQ=; b=Q9Jvb/XbnkXnpP1Rq35bYLmAwH0CE8ndC0obuy7jszu2ap/R0QU
        DgNfaCrapvN+nd9SPxq6rePauTF8sH+/MaxVK8/3jTejLptw3jwQwUZyAWzx5R33
        OWeGeNAsywzFCbiKC9gLFlivCbZDqMzZSYzc028Zsiv7ACbs10HEe0Nge/AeybVQ
        FLIXS8itGEyflXlKjkmEzKymVICXGS6APzGJCwYCzWuSmXd4myN6yLWAmo1LnJq9
        gBaIopCKSBabpf8DIg07A/pgzOz/ziPHOssBPml0iIUV76I2CJw4oWJ5N2kAOCu2
        BT57l2LCme1y67ZrihMDo2XAsAKxQSGx//w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7JFKgst5Lbc1 for <linux-ide@vger.kernel.org>;
        Sun,  3 Apr 2022 18:00:26 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KWsrn698jz1Rvlx;
        Sun,  3 Apr 2022 18:00:25 -0700 (PDT)
Message-ID: <38a1a8c7-704d-4d88-7cc7-3ca483d1e04b@opensource.wdc.com>
Date:   Mon, 4 Apr 2022 10:00:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: libata-core: Disable READ LOG DMA EXT for
 Samsung 840 EVOs
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>, linux-ide@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
 <fe2ff41a52ce2647fd12f69a0d6eba8e3cf05b06.1647720651.git.chunkeey@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <fe2ff41a52ce2647fd12f69a0d6eba8e3cf05b06.1647720651.git.chunkeey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/20/22 05:11, Christian Lamparter wrote:
> Samsung' 840 EVO with the latest firmware (EXT0DB6Q) locks up with
> the a message: "READ LOG DMA EXT failed, trying PIO" during boot.
> 
> Initially this was discovered because it caused a crash
> with the sata_dwc_460ex controller on a WD MyBook Live DUO.
> 
> The reporter "Tice Rex" which has the unique opportunity that he
> has two Samsung 840 EVO SSD! One with the older firmware "EXT0BB0Q"
> which booted fine and didn't expose "READ LOG DMA EXT". But the
> newer/latest firmware "EXT0DB6Q" caused the headaches.
> 
> BugLink: https://github.com/openwrt/openwrt/issues/9505
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
> v1 -> v2: removed Reported-by Tag (Damien)
> 	  opened up a issue + added BugLink (Andy)
> ---
>   drivers/ata/libata-core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0c854aebfe0b..760c0d81d148 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4014,6 +4014,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>   						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>   	{ "Crucial_CT*MX100*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
>   						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +	{ "Samsung SSD 840 EVO*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_NO_DMA_LOG |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>   	{ "Samsung SSD 840*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>   						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>   	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |

Applied to for-5.18-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
