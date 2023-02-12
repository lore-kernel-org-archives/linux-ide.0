Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9346BC636D3
	for <linux-ide@archiver.kernel.org>; Sun, 12 Feb 2023 12:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBLMSz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Feb 2023 07:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjBLMSw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2023 07:18:52 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B091F420B
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 04:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676204310; x=1707740310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U0pE+Um/t6PUndwLm9q+39ASUQUXQbmHYp5YVcs+D4w=;
  b=KksVW7Hpzp8RIACyTUz5Vhewn/wDFLyu8lrJe3l0fEXQE2dN34kQZlfs
   FLYKP+OKe/iFhRYxK8S8efOMkf+p7dGvsKn4Tf7qrei5G2e+oLQTud2yR
   28fBfNwUWkDUhpt80OkEBb4JV/dpLG7GA/dYPuJXuqL0JshS+rLNkHMEr
   9XMpeKG1KlzgmkRPI6jvzMkNnDxFVu+6hnBuS+E32OhEBvi/Qh7zxKxwj
   LutRzVpPgnhnjDW0kT0j97nM3bhXGZLhSFfccYLLe3jdMs2XTiC0658lA
   g58ZYeChnDFrqPkRVC7GsAZBF3j/7IkamxjMJxr5Yb0DOsyiTiJ5gcO+H
   g==;
X-IronPort-AV: E=Sophos;i="5.97,291,1669046400"; 
   d="scan'208";a="335072296"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2023 20:17:14 +0800
IronPort-SDR: 6ROX4vuk0Tbc1h1VEfa/KqhCRdoKZzwDTlmT2/K7SEkoq7D+Hbc/uRN+U6MOl6Ta8LCVXps0pZ
 3PJKfVJcCzmVyOTYmD3cY5wA4qbYvpKcUcm7HjCTYg2UEVa4ek9L7QFS4U6XhVJ29K319YSQOY
 1zLLmclJvNPrpD6R+eKsf8KPb1XawJ448+erJIYxzDJIFKKADfyI1QzI59l7tiZQZqtZvqq7d/
 xGYnbRaPU2AolEFIkwxAh6u2ubD0KGwdLDQmK9kRyveB8tYHrsSsVZ60EcBfOR7dXmAu4QNnS+
 7sY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 03:28:40 -0800
IronPort-SDR: RaH9dwSmGYjjycsf3DSIzyemj0Dw1sgROQAPkNdbGfDiA1mKMs5FEblsX+uD3wpyF/Hn6vNyLU
 DTwCYQ4Q5AQxTBPbTN5N4eaR3MZkczWewvKHxLIswap2prXhyeH18rzzI+5Rl5qE8Sdn4NP+pF
 k/qvr9GTv9m+lOsOXEQ8JsU2/NGEVf/NxScnbVLe0o3JkVQL25lX/VyLsEow50Xw+RHtww6vm8
 Q4Q8Zccs0VANZaojeM/FEPTEcGo784ayLtJZy+DZMI6UuITyvxWppotTMIOf0J7rVwFpRBO1zU
 lVE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 04:17:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PF60p05Vgz1Rwrq
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2023 04:17:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676204233; x=1678796234; bh=U0pE+Um/t6PUndwLm9q+39ASUQUXQbmHYp5
        YVcs+D4w=; b=Jkc4HP1D637Cnlsq19RfNmutENnCpgea27MZK2s6AqlIit04/EL
        XtD3WqThnbXbTq0SW1Qa+T9965ynEySzerKNrj15rHeWz8B3sVBej0VGpJBLb0Eo
        rAf1wZ2R5JukDzRn9MkUdH5XE63L69s/dKFng3Mm9GhZxjrBrdcibxPBRrTfeCda
        WZBnIeDTTTB9ZD8ZOxmMQYn8NcUrNthuKfFrU6MzsyrU+8ElY/6aeajlWgvNwhey
        AbbO255nVlw01tNXy/miZrKMhNfKpmZYFnt1Fe2AnEHoHwuDJwlfZr+6BDwVf9s1
        dsimiLf6U7KAMFHyOtHf5rg72SmyHrxgXFQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yvTrpQwXA1Eq for <linux-ide@vger.kernel.org>;
        Sun, 12 Feb 2023 04:17:13 -0800 (PST)
Received: from [10.225.163.109] (unknown [10.225.163.109])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PF60l5Lgwz1RvLy;
        Sun, 12 Feb 2023 04:17:11 -0800 (PST)
Message-ID: <16f5f350-5aae-8ba1-d72c-fded975fb5af@opensource.wdc.com>
Date:   Sun, 12 Feb 2023 21:17:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 03/12] pata_parport: remove devtype from struct pi_adapter
To:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211144232.15138-1-linux@zary.sk>
 <20230211144232.15138-4-linux@zary.sk>
 <909afe94-d786-a94c-5142-818e540705cc@omp.ru>
 <202302112147.50725.linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202302112147.50725.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/12/23 05:47, Ondrej Zary wrote:
> On Saturday 11 February 2023 20:11:06 Sergey Shtylyov wrote:
>> On 2/11/23 5:42 PM, Ondrej Zary wrote:
>>
>>> Only bpck driver uses devtype but it never gets set in pata_parport.
>>> Remove it.
>>>
>>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>>> ---
>>>  drivers/ata/pata_parport/bpck.c | 2 +-
>>>  include/linux/pata_parport.h    | 3 ---
>>>  2 files changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
>>> index b9174cf8863c..451a068fe28a 100644
>>> --- a/drivers/ata/pata_parport/bpck.c
>>> +++ b/drivers/ata/pata_parport/bpck.c
>>> @@ -241,7 +241,7 @@ static void bpck_connect ( PIA *pi  )
>>>  
>>>  	WR(5,8);
>>>  
>>> -	if (pi->devtype == PI_PCD) {
>>> +	if (1 /*pi->devtype == PI_PCD*/) {	/* FIXME */
>>>  		WR(0x46,0x10);		/* fiddle with ESS logic ??? */
>>
>>    Why not drop this entire *if* stmt? 
> 
> I decided to keep it (for now) as a marker of a possible bug. I currently don't have HW to test this driver.

Then leave that if as-is and only add a comment detailing what needs to be
done (rather than just "FIXME"). This "if (1)" is just too odd and will
likely trigger code checker warnings.

> 
>>
>>>  		WR(0x4c,0x38);
>>>  		WR(0x4d,0x88);
>> [...]
>>
>> MBR, Sergey
>>
> 
> 

-- 
Damien Le Moal
Western Digital Research

