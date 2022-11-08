Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460F9C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 06:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiKHGxI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiKHGxH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 01:53:07 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1133A26AFD
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667890386; x=1699426386;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4IovsOPUexF4CKRl2Awg9H0VAiIxWE4bO/gmwyZLHj0=;
  b=ngNDpd4IT0+Nqw204O5ByYFAOXtgDnNPu7u1+/dNfF/ptgCW0pLxzFAY
   tQTM2x2fTj9wc1Hx/zQWPFUozIrTed8Upwv3ZzqMBDPj7lR+P1nNWV2OG
   vu7nUzcV004RJ5F9O1G4o00tTs3hcgBHnwJTkH3PPAMUPI8oWx95CCbF1
   cIvhFBRfwFb9v3sM8b2Wo1LvQCcmHF3O3WqnnZFhD4D8X7yqSaaCVncFf
   aHX/pCKY/FhK8O/OvLwcEYwz+x9N6njNMdzLBHC38gHf+3kYAWzfT0Dqp
   e3J5KvV9krXl53CSOt8h1ONMncHAHaebeW6EpoxQHsRd/vgF+i21ASPcw
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="215735482"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 14:53:06 +0800
IronPort-SDR: V57s6GJNZmgw9lVn9Gi7h39G716j4GmTw9Kh21t44pfcY2c6VGGgcsbaYrPjDjQogeLYd6/LPP
 RnBBGD6OyWNCLXmNDY935hpPXD6rM4gUnFMXR1fxmRlU/hvn3/RNzLlm5vF+s0rXpif53OS6Uy
 YjK4DY7D2Fx0MExj8z0dflyjZToa+HN+VAspIOdR7ELNqXlZg8HscMCX+kLqTnB2soiHcIc9vv
 JsCAarCqKtauOSq+oxHAaHNt5k9jerKZhAT8nxVrSxFIsTxx1/sWePbXJw3Tkoy+39tYE5N1wi
 Zkc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:12:12 -0800
IronPort-SDR: uObBlGHATUG8W9f9/g2ZWwHJzTgt1C5KSj03rLIIOJgItxv6FaAeEiNkW7ZTe3X5d1e56p/Gjw
 LeVOr+UnYvb4skg4b8q2XrzaJhgKWZkx5aaw1k6VBRtP85KegtIefpAJh3xe9xJ1k7Ax2IqfR6
 PdLEJOfGXKnbGUPbCzO0QKvudvyNd2BcraUERR2spwn222kaOpCACviJRs2UTt6bK1IXCM5Hgk
 89ThpZan0JI4wHawPlQw1NqFm3VwhmMygdwRswENOnp3AQAo4df/4NIjnTB4KK+qXHgjMqgOmG
 0p0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:53:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5z6Y0KWMz1RvTr
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 22:42:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667889732; x=1670481733; bh=4IovsOPUexF4CKRl2Awg9H0VAiIxWE4bO/g
        mwyZLHj0=; b=k1i2ShS+LKnXFJlaznn4cdD3xawNpVmn7ZjGA9RMKJ3az1g47pq
        bm/lqgmUca7zd2BqDBcY6lAt8ENsW0Td4VBFuexA7WDKfxBzF/A5SyWT8JBPmWWP
        sJnpMRkDKfydDZdFdwdpBNDk2UK3s8cwhRtQUkzshCDcmeONnG076Rs8nntf0uHC
        VjsBMQG0RvmSYP0V6oNn55yaOJfaWPX2dAjhNrVFEBWvnA9yIshJFofBhQm/bauM
        +EIe1j8DqrEoxH5XZpv8Pr2zLxJjkkWRgD/hrjZB9ewMEZAthIJ5hGWEig7medM9
        r83kvtckpcJSVR16qPN051HcNPVbohZVnoA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Qas1DiRzT3Vu for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 22:42:12 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5z6X2sMSz1RvLy;
        Mon,  7 Nov 2022 22:42:12 -0800 (PST)
Message-ID: <97aaad89-d5f8-31c2-bd4d-8e5665b6cd44@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 15:42:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/3] ata: libata-transport: fix some error handing
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-ide@vger.kernel.org
References: <20221107125942.143769-1-yangyingliang@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107125942.143769-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 21:59, Yang Yingliang wrote:
> This patchset handle error case of transport_add_device(), if it's
> ignored, it will lead kernel crash because of trying to delete not
> added device in transport_remove_device()
> 
> Yang Yingliang (3):
>   ata: libata-transport: fix error handling in ata_tport_add()
>   ata: libata-transport: fix error handling in ata_tlink_add()
>   ata: libata-transport: fix error handling in ata_tdev_add()

It would be nice to have your earlier patch "ata: libata-transport: fix
double ata_host_put() in ata_tport_add()" in this series too. When
sending a v2, please include it.

> 
>  drivers/ata/libata-transport.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 

-- 
Damien Le Moal
Western Digital Research

