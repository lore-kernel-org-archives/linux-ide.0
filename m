Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669DEC43334
	for <linux-ide@archiver.kernel.org>; Thu, 16 Jun 2022 00:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbiFPAYQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jun 2022 20:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347032AbiFPAXf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jun 2022 20:23:35 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110A1EED2
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655339015; x=1686875015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zZ9XlC7/d8yGFVGGImcAjZu6pedLsVXV7Ze6hqnSWA8=;
  b=grHp2xL9hoSZMPy7TRqMFnB5MdkHXA4/zS0IIkE58ucrx7k/9vJaQQ9o
   74sp/KojgIuLNtVoeG73TAN/riT1f6GU2svrjrCdG3VNA/sl/UElIpHZn
   jGCv1wyYQFvpg2OKiUw/3jDw6F6I66gSfiwgZKLyYoufKWxaZUnC0/8OL
   Nu+m+K0Qv/X3f5lWulo6E2/DV6fGgriLetd1mZZKyNY1Sy/TrpJX8mlYR
   L239HQKMG54HTAv6W+n709NSQJyrMcry+pGzWY/5ECr0bAZzoSchWR4K5
   oCVVTFnHaeYbid3kk2bsrx2L+VP2PXW/gl4wrmAaQRO0ZzEIYRolKL1dX
   A==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="204038061"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 08:23:33 +0800
IronPort-SDR: 9QvH7HdRiPRiYYCAsSFv8oMrTEDPFTrKLpe9fyHGsWALCH62OaRn8zTAmD5mKfCIGroAyfX6dI
 vr7r09K4SWXhb3K2AAH3qZFfA+LDKsNz3p363hZHv43zkHxteRZQK9di0pgo/oyU3yN6U64BYk
 ckx2jbo/Oz5F/46Vqf29J9zNO063s/63q2wkU/NkK7/3E8ZqGbUOxtt9TEzdhYyeg3JX76VpLS
 hxtSniYtr76Ed2BQJEijhVw9gBaalauO2/xIsO64s1N4F8hCOyj6KvE40ZDHHbhwyGR8b3XGkd
 XsutYMqPvcVwYJujpBKbij6a
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 16:41:56 -0700
IronPort-SDR: ctIpqTGWjsMt1ykHxrzlUGzU+kuxoc6zvsLy/56NdZdeEE2AgUKJFAaKNv7Cvb8JGVsqxjRU05
 bVvZQzrfvyRfGonHaYwdQeRR5nmAMllvj1woRzG7IUDsDH4E0M024tM6asBvHUhTETuIC/dtFc
 0c1hvUAvcQ87e1woC2FfQHdOSnwt0LkSMkVQqMcYy5x6zDDwHOfaQfyjBbVy54BUM1RD7MK7E9
 EsMjfMuvivqw+xgcmq6TKXz9utiX0zPkppPcTPfjJRZrWr0621/YZB/zZ5STNcdZTH463UxjSI
 RwY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 17:23:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNjZW65z5z1SVp3
        for <linux-ide@vger.kernel.org>; Wed, 15 Jun 2022 17:23:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655339011; x=1657931012; bh=zZ9XlC7/d8yGFVGGImcAjZu6pedLsVXV7Ze
        6hqnSWA8=; b=TEqAgS/hsApCNwl+CHO+6SoIkPpK4yadlxMSKbvnsWr5u+1VXOr
        ymFIk6PgOMjbnMFJ3+L91utl1WBhUhJ626wWWPVzMBequEDL22TvFlB3fQUEBVYd
        gsjbE6gE3kUNNAF9560R4uvZ9N/VKc17841muTB6cF+jJ11N3iokeL2egcbzFur6
        Kx3Blsu89K3oR4EX99B7TuOASebdKyVWyachP9ZeMyX669Dw2qh7yUWudFGYubKt
        02LA9LglJLXCDRh84iyTD2oYZ5V5t+5YOrjL91fHypjuSnwmGWbuGvoOuvds8xBb
        0+jN4VI+kTjLgQD+G1YoPQX/2p8i9nTeP2Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WXd1eyLX1K7n for <linux-ide@vger.kernel.org>;
        Wed, 15 Jun 2022 17:23:31 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNjZT1QXqz1Rvlc;
        Wed, 15 Jun 2022 17:23:29 -0700 (PDT)
Message-ID: <0dcebae2-5e4e-a0d3-181d-37bb9b40d564@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 09:23:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 07/23] ata: libahci_platform: Convert to using devm
 bulk clocks API
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-8-Sergey.Semin@baikalelectronics.ru>
 <3bf20887-6e2f-41f4-e4ec-5c2278f6cb18@opensource.wdc.com>
 <20220615204509.siz54h4vbgvb3zkm@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615204509.siz54h4vbgvb3zkm@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/06/16 5:45, Serge Semin wrote:
[...]
>>> +		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
>>> +		if (!hpriv->clks) {
>>> +			rc = -ENOMEM;
>>> +			goto err_out;
>>> +		}
>>> +		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
> 
>>> +		if (IS_ERR(hpriv->clks->clk)) {
>>> +			rc = PTR_ERR(hpriv->clks->clk);
>>> +			goto err_out;
>>> +		} else if (hpriv->clks->clk) {
>>
>> Nit: the else is not needed here.
> 
> Well, it depends on what you see behind it. I see many reasons to keep
> it and only one tiny reason to drop it. Keeping it will improve the
> code readability and maintainability like having a more natural
> execution flow representation, thus clearer read-flow (else part as
> exception to the if part), less modifications should the goto part is
> changed/removed, a more exact program flow representation can be used
> by the compiler for some internal optimizations, it's one line shorter
> than the case we no 'else' here. On the other hand indeed we can drop
> it since if the conditional statement is true, the code afterwards
> won't be executed due to the goto operator. But as I see it dropping
> the else operator won't improve anything, but vise-versa will worsen
> the code instead. So if I get to miss something please justify why you
> want it being dropped, otherwise I would rather preserve it.

An else after a goto or return is never necessary and in my opinion makes the
code harder to read. I am not interested in debating this in general anyway. For
this particular case, the code would be:

		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
		if (IS_ERR(hpriv->clks->clk)) {
			/* Error path */
			rc = PTR_ERR(hpriv->clks->clk);
			goto err_out;
		}

		/* Normal path */
		if (hpriv->clks->clk) {
			...
		}

Which in my opinion is a lot easier to understand compared to having to parse
the if/else if and figure out which case in that sequence is normal vs error.

As noted, this is a nit. If you really insist, keep that else if.

> 
> -Sergey
> 
>>
>>> +			hpriv->clks->id = __clk_get_name(hpriv->clks->clk);
>>> +			hpriv->n_clks = 1;
>>>  		}
>>> -		hpriv->clks[i] = clk;
>>>  	}
>>>  
>>>  	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
>>
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
