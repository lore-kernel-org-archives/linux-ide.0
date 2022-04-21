Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA93FC433F5
	for <linux-ide@archiver.kernel.org>; Thu, 21 Apr 2022 23:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376822AbiDUXvA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 21 Apr 2022 19:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382585AbiDUXuy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2022 19:50:54 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACF35A9C
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 16:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650584883; x=1682120883;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aLnaWWW4HT7zs56Y0tP2WjF+Iqt8JvrkaqoMfHMqaqM=;
  b=IEptc7tnCkwQ6mdr2XpqZAOMjEBCLB9BnhyTYZF/JEBidoSBF1mvILbY
   7W1/RzovBaO9jiG1Mk2kp5pAJL0QG8FKg0AAHO7x02ZW/LWClXkpJBVkA
   j/fUD+lt1Oy/W9ZYo3wRSib0JK5cEwyz0KkMyFdlQDl5UgBFpsAX7H5/u
   FFr4JdatQegfxG6EOzHBYMO7V8xDl2EKZY3DQ4pLHluQrPJizrM66AR2A
   kFQoQomePuL4smMEtguyuyhhCxdHz+OZwOTIDNiY4s6EQ9ouzZzJ/BK4R
   xLepqBU2ZxbqB8gMxVU0dtLEfqadWD5vAatsf/4CtmOPITRNoZr8TGG9p
   g==;
X-IronPort-AV: E=Sophos;i="5.90,280,1643644800"; 
   d="scan'208";a="310479701"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2022 07:48:02 +0800
IronPort-SDR: ufHdnpxivvtT1N/0IGWWjS8HfD2x54iJO6X34+4o2g4/ukE8vLodCki6FBcyS21OdZiDkserNW
 AwDciMvYB1A/6tSczO2x5XoGEtqyD+w+KBTtk4KEU9U5omO5rxChD8BlJ5Xbao34LizG85c0kJ
 rtjS4lNNlgK47IYDTAES5+c8SNeDM7k6CfIC1W8cdXz76MDcNbYK1cNYnJhJ2Cj9+uXyEij/5E
 U0Lr0JT84zBAc5pI6fj28Ed+KfyoCGFSr6rKmWRigUCgcOUnNwI01+APPItGxgPOZZ3Xafm//j
 HOwHQ59wAl+cM+zM/oZ02wb+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:18:19 -0700
IronPort-SDR: sFZUzwW3oKSZdmZMkt0CPf8ovC0+Y2apwyTZ3fwM69zV3oVDKbHBk+KJhnxxzD+LKz5/uygIIM
 3w3osVv8n4uHlk336NAdg8qChQjJ1xps+mQ/Askb8t08GnVwnqA9Ja3SmVyBvgVey6jV40CUXd
 dYp0AC0fVNx3R9+GDysSFaGFffmJ+ciXLzzmqDuad/woajYCZVMEuqJhFWtRrv5PtNz84s3Hz2
 carxQ/Zn4fjScHmjCZBqz9hcJmMccvrjm06X9990/KBUGkE4S+ihD5LL94MKvVjhlUOtQNYFTZ
 dgM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:48:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkvNx5lhXz1SHwl
        for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2022 16:48:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650584881; x=1653176882; bh=aLnaWWW4HT7zs56Y0tP2WjF+Iqt8Jvrkaqo
        MfHMqaqM=; b=NAMCH+UC0tb+DPeaNhocqv2wZz7RvZoDiuoJQoJeGAWfaL3k1BE
        LuUkl4N7GTrUVV6l+HnS7W+Z9UEDCH5l2XGUfwIqjzaE5z1ftHCwQ+oUk1x4Plb/
        UYbZs2r8UlnnTQooYEEqPuwn9k0LuUlC6eTDtwa4Wto/djwYQw9PP3STJURB36S6
        738nyT0lFgbvMmlGE2OFxb2tkAS08ikveBE9v8NlPd0q9Bi7OSmyTONyqZonqcp/
        XjrDOK/wlu0bCAf2gVD9gLqd1KpaEcUTXma5ltHeq/Rembr0yzjVJTDTp/Ul8m8C
        kfuzXvJvTSMr3xkARW6Rtvc5uhtM7CGKpng==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GvHbnIGDe89h for <linux-ide@vger.kernel.org>;
        Thu, 21 Apr 2022 16:48:01 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkvNw4pZNz1Rvlx;
        Thu, 21 Apr 2022 16:48:00 -0700 (PDT)
Message-ID: <e29fd64e-62ea-746e-f0fb-02ce86b4e61e@opensource.wdc.com>
Date:   Fri, 22 Apr 2022 08:47:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] ata: pata_marvell: Check the 'bmdma_addr' beforing
 reading
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>, s.shtylyov@omp.ru
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220421013920.3503034-1-zheyuma97@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220421013920.3503034-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/21/22 10:39, Zheyu Ma wrote:
> Before detecting the cable type on the dma bar, the driver should check
> whether the 'bmdma_addr' is zero, which means the adapter does not
> support DMA, otherwise we will get the following error:
> 
> [    5.146634] Bad IO access at port 0x1 (return inb(port))
> [    5.147206] WARNING: CPU: 2 PID: 303 at lib/iomap.c:44 ioread8+0x4a/0x60
> [    5.150856] RIP: 0010:ioread8+0x4a/0x60
> [    5.160238] Call Trace:
> [    5.160470]  <TASK>
> [    5.160674]  marvell_cable_detect+0x6e/0xc0 [pata_marvell]
> [    5.161728]  ata_eh_recover+0x3520/0x6cc0
> [    5.168075]  ata_do_eh+0x49/0x3c0
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---Changes in v2:
>      - Delete the useless 'else'

Note for future contributions: The change log should be placed *after* 
the "---" that comes before the "diff" line below. Otherwise, the change 
log pollutes the commit message.

I fixed that and applied to for-5.18-fixes. Thanks.

> ---
>   drivers/ata/pata_marvell.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
> index 0c5a51970fbf..014ccb0f45dc 100644
> --- a/drivers/ata/pata_marvell.c
> +++ b/drivers/ata/pata_marvell.c
> @@ -77,6 +77,8 @@ static int marvell_cable_detect(struct ata_port *ap)
>   	switch(ap->port_no)
>   	{
>   	case 0:
> +		if (!ap->ioaddr.bmdma_addr)
> +			return ATA_CBL_PATA_UNK;
>   		if (ioread8(ap->ioaddr.bmdma_addr + 1) & 1)
>   			return ATA_CBL_PATA40;
>   		return ATA_CBL_PATA80;


-- 
Damien Le Moal
Western Digital Research
