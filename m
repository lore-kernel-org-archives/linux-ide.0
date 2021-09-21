Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DCFC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 21 Sep 2021 00:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8AD361166
	for <linux-ide@archiver.kernel.org>; Tue, 21 Sep 2021 00:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhIUA4D (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Sep 2021 20:56:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3033 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhIUAyD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Sep 2021 20:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632185555; x=1663721555;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r3UqcrYjGRRowHHJUDRiYhEBq/N8xDC7JNN8kQ0QfVw=;
  b=qWcf69wwQOZx/l6Gl1zMrQV4VLc2pF595Tdk7tRaZEFpIfHAU9zKIIv2
   pHZYXdEBKFmz4i8skWyG/y7CsDvWPeAFXimPHREeB8UAlDetjy1Yd9jZ9
   cK/oBo66cuhDKblspGah/XsT0k9ZCCwCvlYpY9kR8+n/QDKHE81lPo1W0
   Q7EEXUoDg4h7UVQY8ZSc5iua5C6wcciOWrlYDk0Mb+nwGehfHlvuRpo17
   U3Co/8Y223dvNE+kEXD1fgWN0ZBYUm/ZqNpv+JXU4zsQ/d91FZVXS1+zt
   ilahnZ/jPmfGUqDudGKaiN/iGevqc399OFkgJOCvNPzrkWUF5Vi2xtFMx
   g==;
X-IronPort-AV: E=Sophos;i="5.85,309,1624291200"; 
   d="scan'208";a="185282137"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2021 08:52:35 +0800
IronPort-SDR: A3RGLhrXkL8MjtoE0L+egDgkqOXnDBrvXfxrNcDK5oTuVRTC6FgahKuDyJ1XtU1FjG4JrEwS8I
 m+wmvLcMQatckTUrPPmSjE1rmQVSzoLrTO8qvfpUFgJvpY46g/GB9JclJjsymUuYI2JEV2uRwK
 0KlRAAptGppyETlyfoejM00gIGZ2WpZql3r+9kMdYXBcBn5BYwYSYqy0r/bARHIfz1i80ZO6vi
 Ywj1MM83gbe7bK6MnPsF/HfQ/g/0+SvZd2M+r+54+DLtcUyigv7qLeRPmumWkgONCisDRojGpJ
 D0gJ39j2ziTEj476RI8c8cjZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 17:28:50 -0700
IronPort-SDR: mYdnrUmTxJly698qQPp4PHENDXN9K4qoGnUIGqH497Hsrs91PE+ytVn3nLPAqnnV9s09S514On
 GMlULsjIPIjDClLOWgiFRevX1ifk3BTbCqtLt4gzKlVIa61ECHOXLIZMGXdwGSXw4mi4y6BnBD
 3lrCF1jDjjN3fiEBoeIieoFKUCmBZ1lGec6slAqnhgKmNUJfEPritaGhR35FFdfT+BneiZbzCY
 15M2MIf3F0bTrsk4T0H0Eqk4sTMs2+Wm6FHiOaY7TOulH8NdpEYqE3v5dMJYrRjo3l2Dv5g+SB
 LQQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 17:52:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HD2vl2jY5z1Rws8
        for <linux-ide@vger.kernel.org>; Mon, 20 Sep 2021 17:52:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632185554; x=1634777555; bh=r3UqcrYjGRRowHHJUDRiYhEBq/N8xDC7JNN
        8kQ0QfVw=; b=geN6vjEYJHsUO/CfbTs+sGlvs2crRqYQ/pltlZUoysLINBeNnCj
        yo6ySK/L4HdN36Qu/uYyUJ01X4hd47/yeKCH0LhmGzjTz+j7ae+Uhx8jzap+AetZ
        e2yXLXZPVv/dAv/9gLrokr1rcu0XxCcHVP7gD4RujDC7prVqSX6IlAiDGzGtCioE
        VS13nATYlo1KMe9d80QQIXuDHF7daK1OLWJ4APpzX9p4gRQ69weow++IOnDHLcKv
        qNeo5Bojy50mQTTOqpXL36psHTkeoS1SwB++l7Iec7Y4/CR6oAOQTsOdAX/urc4r
        CDMwKvS2YHxksqh70z92XP3+KA5OrV1I7ew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NomsJA5vOJMj for <linux-ide@vger.kernel.org>;
        Mon, 20 Sep 2021 17:52:34 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HD2vj4t0Bz1Rwry;
        Mon, 20 Sep 2021 17:52:33 -0700 (PDT)
Message-ID: <aba1ddad-0450-f4f8-796f-abcfed25403b@opensource.wdc.com>
Date:   Tue, 21 Sep 2021 09:52:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] ahci: remove duplicated PCI device IDs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandra Yates <alexandra.yates@linux.intel.com>
References: <20210919094313.52666-1-krzysztof.kozlowski@canonical.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20210919094313.52666-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 9/19/21 18:43, Krzysztof Kozlowski wrote:
> Intel devices 0x2822, 0x2823, 0x2826 and 0x2827 are already on the list
> as Lewisburg AHCI/RAID.  They use same configuration except 0x2822 which
> has board_ahci_nosntf (for ICH8).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied to for-5.16. Thanks !

-- 
Damien Le Moal
Western Digital Research
