Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6253FC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 29 Nov 2021 11:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhK2LqM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 29 Nov 2021 06:46:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47222 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbhK2LoL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 29 Nov 2021 06:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638186054; x=1669722054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iOMJ4dvNQK4Me/uwxnZ2mPnknSGekZgo0zSNRQ430XE=;
  b=EStRLKfmvmeHtCjMEW5eQN9OStV89LLemldKtIwXk6DGXzCntGy+kLPx
   6/YbDRcUrdnFWxPyUIGoqJ1NxPT1i2ocjw92pWcYvb3pfB0jpoWGC6oHm
   3KNT1O3bxgo0UZ46xyZKz3X+q1p3CL+v3QXfWG4+BDSV/fNX9VpceZBWA
   rGlyVzT/ZxQtJHhUQK6DHOd36UtBa0xyk94HcQsjFqy5iMtZnyLbRbyJ0
   Pxyzo3MROC7q7g/Deh0q4S0rny+6Tets+YWKjm8264es0MGvu+JROa8IS
   Fpkh9jn7nbWF2NBtaXFPr5/zfQ5R4oHJBm/+OxXstjYcEkwxFsdO6Wq2B
   g==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; 
   d="scan'208";a="185939070"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 19:38:53 +0800
IronPort-SDR: sBxcWRS7/Jw8h8G2LvlRPsMqCrT4sUiTU2WGQuWlS7SDrbi48isM7nS7u2K1/4zAPFxqjARGDp
 lmlYTWf1LvvV75WjAj4GK3oNPlTUWwaU+lDSAB8lyipSF2WZyXpA39MLoWscXQTcw8yLdQdT8a
 8N5zexKeMIg6bhH9WhjeD7+trtJpZ5F71duANhOeoGwv9YyVBSwVGDPOGoeqpNeXuZBIBt+9Hp
 vul2w2Co7/DZ/01b3M8FvW+6yvewTuaAqQ6KcnOhuxSP4wNDTrjcItBmrAEKksb10zv0ZK+Qh3
 bFhyWfCFXf1h7FqgL0m4vmNA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:13:40 -0800
IronPort-SDR: puiWzLki7DHJub8kdkKffkda8eYH80oZg26AFCE1F9PqrOjX9KY7cG0JVe3z5SDxBkjZ7bAWf1
 sBIjz980t1A/DY1bwwZXQcw96MvGCo125fXAEe1964m+jyFSHo1mMqwZ87UfJPmeNBn4vsk4vj
 faDgLlxk4dKyPE/+4lCHJ/OzkuvzzVzLpYNXZiuAJiNGEruk82W2jXj5Pjj2D3TXtXOWTT6vJz
 UWiJEPk+UKZio+KzuPIDPbs+RTrFoDw/D4C42Xb5MbDuZlge4fwuod6PEyz7wMC2IM94ohzrdR
 1xo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:38:53 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J2jzd1L8Vz1RtVw
        for <linux-ide@vger.kernel.org>; Mon, 29 Nov 2021 03:38:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1638185932; x=1640777933; bh=iOMJ4dvNQK4Me/uwxnZ2mPnknSGekZgo0zS
        NRQ430XE=; b=eXllMQj7+o7eiG2MFQWT9vq2TFiKCGeBy1QqiSSSP4oyZf/jwaf
        gDoA60oDGPQkIzTBWh0X3N3s6wp6w9N0Mc1zAHZcligxgNue/oBatvErSy02riMo
        yJzzE3liwC6I7Ekx7bM6Cp+vOObZBlfxkpWOYmhPZfVNivM1Bouzu0Y3/GkvbJnC
        RNtobIlQ7HTwxQWbX8t48Y+mIGXKzc/9dO9mQ3VOER5DV33jrn7MRIOpk1r8WKP9
        BsGpj721NlwSKF+iOJwHkbBMg9lOlmxKcqsN8X8fjpMnlc+7UnX72hYXGzGU+mQK
        pnZIkYJogkjZx74qLJhT9fFXJPeV9rHu8XA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4108MM6ispxa for <linux-ide@vger.kernel.org>;
        Mon, 29 Nov 2021 03:38:52 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J2jzb3ndhz1RtVl;
        Mon, 29 Nov 2021 03:38:51 -0800 (PST)
Message-ID: <32ed5d27-e0ea-5926-c7ed-766936024991@opensource.wdc.com>
Date:   Mon, 29 Nov 2021 20:38:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH -next V5 0/2] fix two bugs when trying rmmod sata_fsl
Content-Language: en-US
To:     Baokun Li <libaokun1@huawei.com>, axboe@kernel.dk, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sergei.shtylyov@gmail.com, yebin10@huawei.com, yukuai3@huawei.com
References: <20211126020307.2168767-1-libaokun1@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211126020307.2168767-1-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/26 11:03, Baokun Li wrote:
> V1->V2:
> 	Fixed the check on the return value of platform_get_irq().
> 	And propagate errors up to sata_fsl_probe()'s callers.
> V2->V3:
> 	Add fixed and CC stable and modified the patch description.
> V3->V4:
> 	Use a single structure.
> V4->V5:
> 	Delete duplicate dev_err() message.
> 
> Baokun Li (2):
>   sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
>   sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl
> 
>  drivers/ata/sata_fsl.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 

Applied to for-5.16-fixes. Thanks.


-- 
Damien Le Moal
Western Digital Research
