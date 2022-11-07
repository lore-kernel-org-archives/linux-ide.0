Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61164C433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 12:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiKGMdE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiKGMdD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Nov 2022 07:33:03 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF7B20
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 04:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667824382; x=1699360382;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CaEWyVkrQu7bNxv5fsYpUFQ28pAMyICWbup2FdM6iZ4=;
  b=NNmUspTZKjc6cPQBV0/bLMzEy84VJ0oW1Tmiuewde6/z8t1tsSs8qFSQ
   XjbgmYUS5IuhiQwythBsYOaaHMqaxaQvovfXzfJdsGHKg0lkvOnHiEGTk
   ZRNNOt5UHZ0yDuH6M6cuIFIfIL1nVRTfeMldONA5SIVFqWw87A33fJpuz
   8IBR/CPmBrKuZaVCRRbhN3FMVEnhgAOAMbbnHZGU5Qc6bv7bK6XbTOsV9
   nn1Ewv8k4NXerMkd1ag3T1cG/nCv8zmhYa1So4M3YvTF1XKVS9vZ8cc5s
   FlNmH/Znx7RGnaka0i6Fz79XHZXSBU9EeW1VGsLDcKe4d+Wez/OstPnoj
   w==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="213948734"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 20:33:00 +0800
IronPort-SDR: 6poNwuj9Et4dMrjcKXLcRMdnNVl163U18cUA2fj9iitqop01fS14uoK4THgZ8/S2GIrNgurR8U
 4orsH43qnya0opR5brUpG9hLyLJJBtorbh8ra3Se7kLq59l0FZXeq5n9T1NYmNbPtD4RJX2e3i
 9vsO7q+3+8v0O7T49IWT2yAJz003Bnq0/TguD+XM//UPrvOdkNrXhRoZQ3T5L4mLpw8JNTUjJu
 NJzF4RBzBUE10rk3fHdJskiv+t02V7ZnNIpL4KJlVhmsrqeJqSlcP2nJfHONcupl3hrZgSAFdk
 wsc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 03:52:07 -0800
IronPort-SDR: PUcZbTtZ+bBimzzH9magqO6yM/En39KZFrsSnWx/kWvwLPsm9DLaCCOrPDEYOr7vbjaFrLPGpi
 E480wMKNwR182JZsmrMT7O5zoaQSW8Wk/2BtF1Pihsu2aCnFH7GVSvbKtA4WVxEH4PiTfm6yYt
 8tURTnIY/L2Neg5Y5YG2nkZ6zUfxqlUsH8L5BB1vgOtNVLpnIOznFMNZCVhsXzLstyu0syDwTT
 ViSUK76cCKSnnZHfJ1J84BqkhD+5dw8obWMJEONGeYcHbzwS70YyV4rsIbRaD7CIHVAgxxTv7M
 V8o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 04:33:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5Vxl1Tynz1Rwrq
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 04:32:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667824378; x=1670416379; bh=CaEWyVkrQu7bNxv5fsYpUFQ28pAMyICWbup
        2FdM6iZ4=; b=QYY/yZKEHkgbOA93C9mI/xIU8vgHduxLBOlXdtT/ZEQB0Sz/qGc
        GGAmaMUV6GgF6/Oze0sbLi4WDocPstzoDApF+RW4Qcj26lWTrkV6m1m1fqcok2BN
        9gtqq7qazkJmpeht0ymiy2EvNd8PDCOB5/ftie2A+xhfHIZ1254yxXNSqjPGpFeF
        UwAKiq0PC8AStJoNa2OhpAHcyWSxdpTazUv3aJQaHi/Q9uqpvbdxjXhQxGMiPJ6S
        L+moDhXo4mi0w+0E0yASqAvHIs3S94Z7dwThPK55S4NgybkFj5daSS/EfMD5CMJw
        wxPoqyzF/ssm3J6npp6NXD9BnOv6DxiFjFg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2RixKmq495ej for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 04:32:58 -0800 (PST)
Received: from [10.225.163.31] (unknown [10.225.163.31])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5Vxj4kjHz1RvLy;
        Mon,  7 Nov 2022 04:32:57 -0800 (PST)
Message-ID: <e4f4f8a6-34e1-428a-7e1f-dc66ded93887@opensource.wdc.com>
Date:   Mon, 7 Nov 2022 21:32:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
 <20221107005021.1327692-6-damien.lemoal@opensource.wdc.com>
 <20221107055000.GD28873@lst.de>
 <ca10f501-0d3e-fcae-2b98-d39ca1822a67@opensource.wdc.com>
 <20221107121627.GA17441@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221107121627.GA17441@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/7/22 21:16, Christoph Hellwig wrote:
> On Mon, Nov 07, 2022 at 09:12:57PM +0900, Damien Le Moal wrote:
>> On 11/7/22 14:50, Christoph Hellwig wrote:
>>> On Mon, Nov 07, 2022 at 09:50:19AM +0900, Damien Le Moal wrote:
>>>> Finally, since the block layer should never issue a FUA read
>>>> request, warn in ata_build_rw_tf() if we see such request.
>>>
>>> Couldn't this be triggered using SG_IO passthrough with a SCSI 
>>> WRITE* command that has the FUA bit set?
>>
>> Yes indeed. Should I drop the warn ?
> 
> I think the warn needs to go.  But don't we also need to handle the
> non-NCQ fua case if we don't want to break pure passthrough appliations?
> Or do we simply not care?  In the latter case we'll at least need a
> comment documenting that tradeoff.

I am tempted to say "not care" since it has been like this since forever,
silently letting FUA read through that do not do FUA at all...

I am also tempted to say "let's add a check and fail those FUA reads that
are not supported", that is, essentially stop hiding errors to the user.
Bad passthrough applications that were working would stop working. Is that
considered breaking the app if it was bad in the first place ?

-- 
Damien Le Moal
Western Digital Research

