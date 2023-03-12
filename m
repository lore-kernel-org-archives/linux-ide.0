Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B9C6FD1F
	for <linux-ide@archiver.kernel.org>; Sun, 12 Mar 2023 23:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCLXSG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Mar 2023 19:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLXSF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2023 19:18:05 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40E26CEA
        for <linux-ide@vger.kernel.org>; Sun, 12 Mar 2023 16:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678663065; x=1710199065;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=74R5irxjgYlSr4yhr9cCXldvYivv9NABOS/YyCLCL70=;
  b=Q5tYxawu78ANlY1zs7eG2PHvLfvwFN5o5isVTv7m3YvZ9DQOjNH1AdRU
   7OG57y9RG3G6d9QjI+/fXw2FjHTVcrJnKGOqpNtXyn/H5G6zv7r0e3lVl
   7mSABh4nrx25HwFrxRPkSniZ2Z3U8FDBsGv1AtBV4bkwqk7SeWn90zlJN
   Eusp7K7sY3OP/v3UTQcUg2KxrEjinZbR7TEGF25LkcVzOOUVEjtIr1GTN
   xdbmpm3k/MAdM2ieQ69C1zfF1uU87KBQTojalvW40A7q5B5pooVVEJHJO
   k1uqSzmtZskqdF88fdMKSdkcHVpbfeAt1npSvqtND+3jlKQ9TzjXqtLkJ
   g==;
X-IronPort-AV: E=Sophos;i="5.98,254,1673884800"; 
   d="scan'208";a="230404645"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 07:17:15 +0800
IronPort-SDR: xvL2SnszCf0+6k3glNPI5AEvOJnXKnvDB7QRxBiwdEjVtNqWXUdyT35rbtuKFTZW63E+zi70ve
 t+3cDSytsu6Gfp1A3FuYsjd4uxgCTyi2/y3VhIt+KbmUmpopNSLkdT7ILpicoOaLbzoepWEl2i
 9nsnKDEY/jAC3ko6fGjr3sveMcSF5KhL7v8VIMfU5UTl58XahMjaWT3f4N2tlRlfle1m0vCRGh
 URzOE6e/IpUayYy4HIIWfRR4SVsS0dI88WvmrV5HfviMmoEx48U0sXym4ESzKnPnBU4KpcIUPW
 nys=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 15:28:04 -0700
IronPort-SDR: VbtdVbfbmZRrEacgwSaWOZ3AFhMPRfH7JrlmffzIsVYfQFAzRqDcKgQMi3s4LCr1p1CWqr8gO6
 obmfwMFXHUpc6uWmRgSBccSkGJ/v60Xc2qZhZrnxQOFibook7jiUA8ubZzsXfSYWVDmM89TVOF
 ysvOsTDd/GjU/UhN5aofLmaaralEp+3kxrIx/4fgVKap0u1uZNBaPtzF5ZZ2ir07MEHUn9t/+P
 GbrftyGwu/Ea2np6tWFw+QnpvsG8TjQnyEYicah6ZD3kWD9TXPI6m2r6gQw8PdLjIawIItDI0r
 AAs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 16:17:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PZbKR1sLvz1RvTr
        for <linux-ide@vger.kernel.org>; Sun, 12 Mar 2023 16:17:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678663034; x=1681255035; bh=74R5irxjgYlSr4yhr9cCXldvYivv9NABOS/
        YyCLCL70=; b=KAgXTulmY3chQ2KGDIGycK03RqqXs7g/uxdMQ6PZremiZU64l7a
        TUjx47AwOI2hVxDbHTHf07O2O3DC6Xq514apEPpk+LX5qjXKnOVaqXLLksOrb2ig
        9ysTLRVOKvuW5+Gg5OzDK8BagcwUyX2jYVuYyFfY9Wn4X0On1jqQSGXHu0sGHDwb
        5hsvRp7PUYh6W/PJqy2vB4Wtpg4OEwIH7xE9vLucwh3G2c5+Ze58zji3VSqwf8JH
        nyxYEd107FwhZZxlm7M4MLrYrN2QpF2nkgC0/BIgQEJWBr0fU9RooZ5/rEhlWBNP
        d2BPSD7p940HG1JZ3f6xdr+01y8hE/WB9jg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s4pF4ckGGksH for <linux-ide@vger.kernel.org>;
        Sun, 12 Mar 2023 16:17:14 -0700 (PDT)
Received: from [10.225.163.79] (unknown [10.225.163.79])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PZbKP652jz1RvLy;
        Sun, 12 Mar 2023 16:17:13 -0700 (PDT)
Message-ID: <cf8c7b34-3c5d-2b9e-b410-d83f4af7274a@opensource.wdc.com>
Date:   Mon, 13 Mar 2023 08:17:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] pata_parport: fix possible memory leak
To:     Ondrej Zary <linux@zary.sk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202303112239.21234.linux@zary.sk>
 <20230311214447.7359-1-linux@zary.sk>
 <8b0eb4d0-ca10-35a5-a74c-fd0f7d11713c@opensource.wdc.com>
 <202303122224.29035.linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202303122224.29035.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/13/23 06:24, Ondrej Zary wrote:
> On Sunday 12 March 2023 01:56:25 Damien Le Moal wrote:
>> On 3/12/23 06:44, Ondrej Zary wrote:
>>> When ida_alloc() fails, "pi" is not freed although the misleading
>>> comment says otherwise.
>>> Move the ida_alloc() call up so we really don't have to free it.
>>
>> Certainly you meant: "so we really do free it in case of error.", no ?
> 
> I meant "so we don't have to free pi in case of ida_alloc failure".

That is better. Please rephrase the commit message to this.

>>>  	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
>>>  	pi->dev.parent = &pata_parport_bus;
>>>  	pi->dev.bus = &pata_parport_bus_type;
>>>  	pi->dev.driver = &pr->driver;
>>>  	pi->dev.release = pata_parport_dev_release;
>>> -	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
>>> -	if (id < 0)
>>> -		return NULL; /* pata_parport_dev_release will do kfree(pi) */
>>>  	pi->dev.id = id;
>>>  	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
>>>  	if (device_register(&pi->dev)) {
>>> @@ -571,7 +572,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
>>>  out_unreg_dev:
>>>  	device_unregister(&pi->dev);
>>
>> Same comment as Sergey: isn't this going to do the ida free ? So shouldn't you
>> return here ?
> 
> No. device_unregister() calls pata_parport_dev_release() which does only kfree(pi), not ida_free(). But it probably should do ida_free() too.

Yes, it should, otherwise you are leaking the ida with the normal (no errors)
case. Care to send a fix for that too ?



-- 
Damien Le Moal
Western Digital Research

