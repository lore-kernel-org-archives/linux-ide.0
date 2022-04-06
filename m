Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEE9C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  6 Apr 2022 12:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiDFM0P (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiDFM0B (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Apr 2022 08:26:01 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4533129856
        for <linux-ide@vger.kernel.org>; Wed,  6 Apr 2022 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649232649; x=1680768649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OXlW7XMsm7YkB8BmULX0rKO6acP3cTihzhxzw0jjfqc=;
  b=bZ+w3H8WdFuqy0awlNM5fNPxz/xi/7YNpWFXnpargvawsB3QThyEIHrk
   1gqsZAnETUGago0cC6/O5dW9/MTE4ic8KXQ0FXJ6D86M8B4KQCXNiYSki
   KH3Kd9JJF1g0d6UZWzjL8s24LbVafa9mcHDUReBbROuLfE6cKlN6srQoa
   Re+nig2U/Tbg0UoS6y7OBNs0JA85fT2l/oXzi8oVBNrAmmXqlgNt3MoQz
   XTT4b8N/JmAtNDAKS2nr2Ini8/UrYHL0u0TMMjOCx74QVsWh1NcaWTGlN
   S2khN8LxFw+b5lHaoA4lCKijydQH8DQuNNXA6fHLDsb1FtnLRARs+hZ1F
   w==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643644800"; 
   d="scan'208";a="197220757"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 16:10:47 +0800
IronPort-SDR: KYEdStogTrnUoqG3ZtDNojCjv3Oa5fJsZn58te4/GUXqf7JqiriOOGLIOboA6czQuX1/l8jK4o
 LKT3QKU7VfH+zle3vOQyY5ADbdXxWRWQSyMaXKNy6UOfB2ShJQQP3dDSsWnJQm1wHX8ucs8x5m
 inufR8BgZ/9CrGKv5TBDmryOpAMkLJ/RPmWQXq4AOLz0N0bB6gd4QfHiMadPol4KZU/o8OaYlK
 fIcW3wDn4j1TqPJ2Xlb69eNv9o0l4Hf0L6uQIwb9oCF0Kpmd2dmX2cajqVtSJCYSh6T5rBeIzW
 HjUy2Qqovls9m0Hc1MGSl9Y2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 00:41:30 -0700
IronPort-SDR: 0bp5tRAVfadkJ50ecrsucmXgzeknyLDoCjdpFesyH6yLWxmR9TN/TthieQxmx7s1nhmb4ZKHn8
 Sk2giMX8s0Dpwfi/IRO55Ig49jY/M7butb9AnPMiuQz0gteFckgwekUNN08vV/rjZvYziz4pKr
 NBSFQLb5dp0KYBmvXNdXJUYG2PSIcQ4mXFF29LsvyWhCIoyp/gI+8IjQqlKeRvPqz1QksX3wZu
 zHBRk1GQuZofmH5zbXJaYXDGB28/WuaKc3fs4Cpx8gZ257lhfY8vXEoWV+ouMO8+RMC6jOGlmE
 Okg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Apr 2022 01:10:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KYHJS2KJjz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed,  6 Apr 2022 01:10:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649232647; x=1651824648; bh=OXlW7XMsm7YkB8BmULX0rKO6acP3cTihzhx
        zw0jjfqc=; b=o4BCjSaKcmUeC3V/ysxboezAk7mt0Fxzqh0MWkY8sT2l+gU7jPB
        Kdld9C6XDIdwdhu6MiqU1d/sFMaFZp1s88kGT8889lanvnwC5C8AIwciYM+n0oHv
        v8DNdpfzNAnjxkMmWc8SAOte06L8HEC5Aaq0RJ3++HsG5s0JRjox/1O/RVWyl8QV
        csjgkizdLNStKiwYAn6XM9sdJYrB3kTdTlk3xh1VqjcLqZnatbHvvIiBNcoawOPo
        TlPhnPSSi8mM80a14xE+5tRgZNdUKq+STK7pG4aKau780AYeHKeAm1wTs8z6wem3
        vskcmDgDMic33lD85Uly6zeGQTyojauhR1A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vA63Td53Byxs for <linux-ide@vger.kernel.org>;
        Wed,  6 Apr 2022 01:10:47 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KYHJR0CwQz1Rvlx;
        Wed,  6 Apr 2022 01:10:46 -0700 (PDT)
Message-ID: <a984b4d6-bc7d-ef81-8bd6-34d50127174d@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 17:10:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] libata: Inline ata_qc_new_init() in
 ata_scsi_qc_new()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
References: <1649083990-207133-1-git-send-email-john.garry@huawei.com>
 <1649083990-207133-3-git-send-email-john.garry@huawei.com>
 <20220405055252.GA23698@lst.de>
 <f7bbb09f-562f-fce2-cd16-a1c67fc334b5@opensource.wdc.com>
 <febb03e4-ea1d-c7e1-58a6-fa564c902af0@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <febb03e4-ea1d-c7e1-58a6-fa564c902af0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/6/22 16:16, John Garry wrote:
> On 06/04/2022 02:48, Damien Le Moal wrote:
>> On 4/5/22 14:52, Christoph Hellwig wrote:
>>> On Mon, Apr 04, 2022 at 10:53:10PM +0800, John Garry wrote:
>>>> From: Christoph Hellwig <hch@lst.de>
>>>>
>>>> It is a bit pointless to have ata_qc_new_init() in libata-core.c 
>>>> since it
>>>> pokes scsi internals, so inline it in ata_scsi_qc_new() (in 
>>>> libata-scsi.c).
>>>>
>>>> <Christoph, please provide signed-off-by>
>>>> [jpg, Take Christoph's change from list and form into a patch]
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>
>>> Although I still think merging the two patches into one to avoid all
>>> the churn would be much better.
>>
>> I agree. Let's merge these 2 patches.
> 
> I'd say that they are distinct changes.
> 
> Anyway, if that is the preference then who shall be the author? 
> Considering I did most effort I will be and add Christoph as 
> co-developed-by - please let me know if not ok.

Works for me.

> 
> thanks,
> John


-- 
Damien Le Moal
Western Digital Research
