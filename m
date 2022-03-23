Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B2C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 23:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbiCWXwp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiCWXwp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 19:52:45 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435C3FD82
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648079473; x=1679615473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8hh/8yqDJ7o/CQ9mjXi8TMolLbXprjEkmR1JdlBVq/g=;
  b=UXsJ1dunevMJ0N2iv7jvwoXUlvG07Krmup6DNWr871VerECVf5kx0Azl
   kQFjMF9nhMUCooYkjmfqSMf2V+qJOmhHVl/Oc/A8gmIBawu0uugtjtBtF
   BbTq2uGw8MtPPfYrrYEXd3zTgbkBB3Q0vcA9ZmFj8pV5WUKqLu6cFAE2J
   dDuGP08XGF4HRGt5v0KnJ7MsuRcuBgTECWT3t+XeLI3I+iZGRJ39rrdGk
   i4/ksuOVCNBcPKwHUS/gIB8l8PXLmbMbQLQzelF0GDMNn1MB2jTYmd3dx
   895TQ3ghhJSMwg1rTmO4mDBW0qUyyQULL6pYsgaIjMj0Pk4EUqw7iirOQ
   A==;
X-IronPort-AV: E=Sophos;i="5.90,205,1643644800"; 
   d="scan'208";a="196115601"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 07:51:13 +0800
IronPort-SDR: MerU6uixIkJ+odZ2xrOd+Kb2lnCmf5HB/P5DqGhGXleRh+m6E1pa6NtyX9jTUXu3jrSIa+j1ve
 722dN3JBebPRYH1xmpEbl/CkpZSJqaIrLgDH1R9lT31kCimQW7A5koeLzLcp78I7MmqPrcg1n1
 p8DUkjISAHO+6g6+zbtEK3xSG+BWIiTf5Ka/YFQxPXJyG8L2alEP7nTDEnVgmPY11zYtCru7aS
 U5i5ngFXMvHwr5pV6ods2fFpBSTXg1fstrUZVPLMirIzdmhJnXodwwuZAoXmKBAfI1kg4bbTU4
 OoF48/uiobb9d6rH///gdNj9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:22:11 -0700
IronPort-SDR: OiQkHe0yxxBhSzOJ1KCCx7CCAreZYTtIRPT63U8ux7J7UEFWvWWJezVASpBjVIt8QcHxfDTAL7
 7YnLdyfQHbsHrL6mZsGGIb6+rxypMxhB475U07JNLhy9B5wF1na5Xrs2MJv1iSL5NJs9dt4UEs
 0m+btC8xZF0+uqKCYLkkxdmpvH8mTozPyfNHnK8+rjXl0AVeg/zoMMLiCZIRV5o2Q7UmHXFi06
 msuaJVqrwWpUU+86Vz7aePaTrjfVXcezXlFF/ms/EAAPRbcZpyLnXDUEn18Nf33w+zKhjRbjRa
 9Yg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 16:51:15 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KP4r16Cdxz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 16:51:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648079473; x=1650671474; bh=8hh/8yqDJ7o/CQ9mjXi8TMolLbXprjEkmR1
        JdlBVq/g=; b=bP9zmFbLc9EcgENgBO8D65pqSO5c7d8uKxsO27twMJGL97PTEEG
        PtwJGgPoN9uUJ1yUh/Pk/N8Oi6Pz8Zx1e9zLsezGIPceMRffMRLJ2QPUagzvRen3
        V8GMaaWK7yZk/YXqQeroat6vdE2xJ2wTnrrgmUO4vgmZx+9uuh+VOgZFanfBzL3N
        EH2cHVaOCEGUM8lU/iwr8w8t2JRrkztr/3cAyHFJr4+/XHuaXZzNqcASuXC59xgw
        H8mNwdlCBV/xG2su+KHP82zBvvx8gtxxdy9Rc66AU5mg4dHZN/IBKsBOE/YfCciq
        m0FB7bf0sRHrLFF+bbG+9aAHGiDBgXa72RA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uEzoyIE4i8a9 for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 16:51:13 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KP4r10HWpz1Rvlx;
        Wed, 23 Mar 2022 16:51:12 -0700 (PDT)
Message-ID: <9fb79f48-837f-ed8a-6681-7055b5cfe7cd@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 08:51:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/4] ata: libata-sata: Introduce struct sata_deb_timing
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <20220323081740.540006-3-damien.lemoal@opensource.wdc.com>
 <c67343a7-ae8f-2460-665d-5dc5ee47db97@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c67343a7-ae8f-2460-665d-5dc5ee47db97@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/23/22 23:09, Paul Menzel wrote:
>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>> index 86f1475e5bca..be46833d77a6 100644
>> --- a/drivers/ata/libata-sata.c
>> +++ b/drivers/ata/libata-sata.c
>> @@ -16,12 +16,31 @@
>>   #include "libata.h"
>>   #include "libata-transport.h"
>>   
>> -/* debounce timing parameters in msecs { interval, duration, timeout } */
>> -const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
>> +/*
>> + * Debounce timing parameters in msecs.
>> + */
>> +const struct sata_deb_timing sata_deb_timing_normal =
>> +{
>> +	.interval	= 5,
> 
> I find it always useful to append the unit to the variable name: 
> `interval_ms`.

Yes, we can do that.


-- 
Damien Le Moal
Western Digital Research
