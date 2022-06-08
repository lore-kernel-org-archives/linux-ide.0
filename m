Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5059ACCA47B
	for <linux-ide@archiver.kernel.org>; Wed,  8 Jun 2022 07:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiFHHiw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 8 Jun 2022 03:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiFHHDz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jun 2022 03:03:55 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE917C693
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 23:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654670855; x=1686206855;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=VNYe600t/rvnJXRxfFvwmZFrF63fwpIclQWJloJr1Lg=;
  b=TR8knPwoTgvmO6YkIhL91yatFwD7tSmwwQVKNQ/btHEgFTgvkvB5JYva
   lEf92+fKvcBOvHcp2Es6pW/y/y2e60GBaU1bVOzQ/VWBNWiU4io+wA7U5
   DjAZ8uvRlRVlM5hKt3qzcXdAg5yjmjZJpo49kzQ1vOmLmHr4/nurQZEkc
   X60/zYzEpLN2xLxZyMlB1PAPEVbMuWuuq9QrhL0wjvD0mgKgmTEHL1bmh
   DDFTWK+fXD5uuQGpxGxT/jMe2Ll4mghVeO8aDpxYSzMotlKws8m/zrtH+
   o+cScQPWxxT5SiWgmjN4HirRiodNw6o/w4Mi4cqa1C1tDqoCdZbp7ebmA
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="203351866"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 14:47:31 +0800
IronPort-SDR: EvYwbptKud3fpmlRMDBTSyXPRXvI8nzKGVl5VM295GxDB/2/1qAezMYNBETOJwQKi9thtb/6Rr
 xRGB7q067i4nhdyvWxyK3tEQddNFVyTT1Srismw6BawXAFDpPiRUJd+yC5WE1ebe9CvJqm75qx
 aqwFo+AkuMxwgHYnERUTo2UZvtmDkQ375sY8092Sc3TKoOQFEauXy+dwLPbMgcygpIGGsUuNeQ
 b2zyf8rZhieEFENIIMeWEnPCtRUUn86M+hEniZ1WW6t2tNFpoYHPzsmUo9kqPjn/KoDM8CKJB1
 rOy8plocrQUUF7FKRa9TeAaA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 23:06:15 -0700
IronPort-SDR: 7v9wKcdOEg297kBeGw7NbpJ16biJtAEs2HCgo5EDmOU9vue5sUTQGZq4eGA5733/8MjS9r4znY
 4xYKEtDlmeUq0XfaCwdVUlwL9ILPcV06/JnhJoHK1PDXt9GTMhkA2dx5E1p7J7PUVraVtr0Ria
 7ClnxYtlnQtsQqlNI0zBH9ItkaDzhApa1JrZ/0SA45oXOBIow1rcapRZvxrL9JT67hQWrMvJs5
 xbNjrDKri9IVT9LhNkAKvSlFdstVCbVlgugnz6czoGpFv5Zrq+S/+1ZQSS0tqRDtKQxXELjoCa
 4k8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2022 23:47:27 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHyTB2f0Lz1Rvlx
        for <linux-ide@vger.kernel.org>; Tue,  7 Jun 2022 23:47:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654670846; x=1657262847; bh=VNYe600t/rvnJXRxfFvwmZFrF63fwpIclQW
        JloJr1Lg=; b=F2yTWgXDWhUFQxwZI8f4jUeN1cf8BHFrWzXnXijugSFxayiX8fg
        Sj9vPgQUOc6Rg8Wi7aNNDVR2TnxBnjFdgB95EhTq4VUCA9FKcJ3n00RYBcYX4Shp
        EXIukYHv3X+3QVJVr26HVI9XhBL1K1T8FfFbLLmG+XZpwxNSMwntdwKRQi1yKoJ0
        4YbXfbhrYC7Ud0PLmjBKGVVSMX2tRpM7jRROpJkBrvbJGSTfHGnMqTRFE2zY2gyt
        E7RmKptVFze9/6TPJljPFIHJtgwf+8LOW/VSjLs9COWhElaNRxBPpHVxQW/atTdu
        QrMZwGinVaErAcUMxmMY32+m7to+IQy5YBg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P9Id0IADjeap for <linux-ide@vger.kernel.org>;
        Tue,  7 Jun 2022 23:47:26 -0700 (PDT)
Received: from [10.225.163.72] (unknown [10.225.163.72])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHyT95Sm5z1Rvlc;
        Tue,  7 Jun 2022 23:47:25 -0700 (PDT)
Message-ID: <b7ca6700-1896-ec12-d298-c2341c79f169@opensource.wdc.com>
Date:   Wed, 8 Jun 2022 15:47:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] Unify PCI clock detection in the HPT37x/HPT3x2N
 drivers
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <20220515204126.4866-1-s.shtylyov@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220515204126.4866-1-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 5/16/22 05:41, Sergey Shtylyov wrote:
> Here are 4 patches against the 'for-next' branch of Damien Le Moal's
> 'libata.git' repo.
> The PCI clock frequency detection code in the HighPoint HPT37x/HPT3x2N drivers
> has needlessly diverged, so trying to unify it...
> 
> Sergey Shtylyov (4):
>   ata: pata_hpt37x: move claculating PCI clock from hpt37x_clock_slot()
>   ata: pata_hpt37x: factor out hpt37x_pci_clock()
>   ata: pata_hpt37x: merge hpt374_read_freq() to hpt37x_pci_clock()
>   ata: pata_hpt3x2n: pass base DPLL frequency to hpt3x2n_pci_clock()
> 
>  drivers/ata/pata_hpt37x.c  | 113 +++++++++++++++++++------------------
>  drivers/ata/pata_hpt3x2n.c |  19 ++++---
>  2 files changed, 70 insertions(+), 62 deletions(-)
> 

Applied to for-5.20. Thanks !


-- 
Damien Le Moal
Western Digital Research
