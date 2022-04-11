Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6461BC433EF
	for <linux-ide@archiver.kernel.org>; Mon, 11 Apr 2022 22:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244215AbiDKWvN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 11 Apr 2022 18:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiDKWvL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2022 18:51:11 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F6E2ED73
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649717335; x=1681253335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sU/ZOAq3Zhx+cNy7Kisbffx9HGFTvONOYugeUf6D9Wg=;
  b=YJmDoscMAVwjAPOytVomwA3nGM5R8vLupku0eYvclrNJoRP6TEt/Txrq
   A8sWsr29pInBp/rvONFIe1XWfjOBEKVtf01UDrxZS+cYShbf6+znskH26
   6aRezjMO0W923p8nx7TaXISh7QlphFJHjeQjIvjJGnGlhKMKY2q3LP16x
   hTb6s0YZqYVrVoDk80lzbwPNZpVB4Ijq2wsg9W0joTQMmr1jxAAM4Ll2O
   DNwDWruAQ6fqiOEk4EY/zDg6+DCHpTj1TlFbnvsp+C2kbWSrFI5AzzauH
   UQp5DwrLlkU2Cpz23/FOhUaJ5yCMTXfB2sA+aD5TdKpPAWP1EA5vCvf/m
   g==;
X-IronPort-AV: E=Sophos;i="5.90,252,1643644800"; 
   d="scan'208";a="301849852"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2022 06:48:54 +0800
IronPort-SDR: L9I2AJFYCYHIQ9n03YkK34lHdiNvgcuxQ98jyzb6ybTJddarkUj55XTmVVWnskOxuMPE8BlTTq
 v3l6hFtM4cHdQYn95zJdwvLhqec8iRfHfKI/jkE5VIhYfDy3mvIN1qiMkFutvNcB1l/4FUtDfs
 Q/jQ8DrHfPhxPHfXrfzhAda7r1AA/2n/hS+qpHP6LFwJ2lWrKfWBWVawjrqePAoKdWRhQkUAlj
 J7JyUNL8SNFZTsYTn1R527u3r7+bzyIGDRB9HlpyZs83PAHwEklb0ajlW10yGj7A7FBXjTf0Ck
 YOoJ6Z1zMkGnzReII5TPTpv3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 15:20:11 -0700
IronPort-SDR: 5L4U16JzyKTxnzh6dRamYbq0w8etzzEXoBWcfTM2w3XhGlfquVDU982vlyqlNv+78fAgKhtfjR
 TdMyoyrseCUZ69hSCqyJxcQlGVk4S6Hywfji0PDP2Cyr2eDpkhnvpkRUmxmJ0p8SJoG1qvlhl5
 KmsnhBaAeGJt9n1nkvcpm7IWLBN2oZ9+XEw+fh4Gcw6ZDKYqyTPV6SOOlV7XD2vyz+hNmiiJjs
 vZzDNoG0slf7M739SWmoqt39PiW7ukCTwt3Q4jJQzb5S9meS2bKOr/lncKKKMumtXngvrxFQW6
 ais=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2022 15:48:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KckYL1ZTXz1SHwl
        for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2022 15:48:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649717333; x=1652309334; bh=sU/ZOAq3Zhx+cNy7Kisbffx9HGFTvONOYug
        eUf6D9Wg=; b=qidKUV31MocT0RrE1UOp/tosJ2pgPBI2P560GwpOnx1onGII2de
        AtWCsMkU2Nc7TwtY8JIu/OCMJ3cAWmOQmH+fIgAUNbucueZ6VvbLrb010Vh5TP4k
        BtO91/UuoP9Q43Z2UGZ/tSqGZ7frsRl1ut+CI8mf23geVHoYWVbVQutbDsjR4IuU
        d3YBFM79XkmwXRCB41+97BckNrhBLo2kjZUO+pqMFndYEZOgaJa9A9uOOSqs3SRa
        CGt8n1asXGK1w2mdW5dzycc1HDiey8CLDgDiqp1c6PYV3+aOkQV1eLkGT6GPKLQx
        kS8MkuRJTSMd+UKUeOroDFk0gdKsWeVAu7g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oEgv4XRErRmF for <linux-ide@vger.kernel.org>;
        Mon, 11 Apr 2022 15:48:53 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KckYH5f7Rz1Rvlx;
        Mon, 11 Apr 2022 15:48:51 -0700 (PDT)
Message-ID: <5ae5764f-ca51-9c2d-c13f-cfe855bda45e@opensource.wdc.com>
Date:   Tue, 12 Apr 2022 07:48:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 12/21] ata: libahci: Discard redundant force_port_map
 parameter
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-13-Sergey.Semin@baikalelectronics.ru>
 <b06a8382-d5c1-e3a5-8577-692fa82cb3c1@opensource.wdc.com>
 <20220411121151.vm6wmtalbl2lgtgo@mobilestation>
 <bde34952-e244-a1c3-fc33-251d618d2bb4@opensource.wdc.com>
 <20220411205205.p5vnqvscgfb2siej@mobilestation>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220411205205.p5vnqvscgfb2siej@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/12/22 05:52, Serge Semin wrote:
> On Mon, Apr 11, 2022 at 09:25:03PM +0900, Damien Le Moal wrote:
>> On 4/11/22 21:11, Serge Semin wrote:
>>> On Thu, Mar 24, 2022 at 11:05:58AM +0900, Damien Le Moal wrote:
>>>> On 3/24/22 09:16, Serge Semin wrote:
>>>>> Currently there are four port-map-related fields declared in the
>>>>> ahci_host_priv structure and used to setup the HBA ports mapping. First
>>>>> the ports-mapping is read from the PI register and immediately stored in
>>>>> the saved_port_map field. If forced_port_map is initialized with non-zero
>>>>> value then its value will have greater priority over the value read from
>>>>> PI, thus it will override the saved_port_map field. That value will be then
>>>>> masked by a non-zero mask_port_map field and after some sanity checks it
>>>>> will be stored in the ahci_host_priv.port_map field as a final port
>>>>> mapping.
>>>>>
>>>>> As you can see the logic is a bit too complicated for such a simple task.
>>>>> We can freely get rid from at least one of the fields with no change to
>>>>> the implemented semantic. The force_port_map field can be replaced with
>>>>> taking non-zero saved_port_map value into account. So if saved_port_map is
>>>>> pre-initialized by the glue-driver/platform-specific code then it will
>>>>
>>>
>>>> glue-driver == LLDD (low level device driver), for the entire series please.
>>>
>>> Why? It's a normal term and well known amongst developers. I've used it
>>> in a plenty of my patches before and none of them has been questioned in that
>>> part so far.
>>
> 
>> This term is not used in libata, nor do I remember seeing it used in SCSI
>> or block subsystem either. We always talk about mid-layer (ahci platform)
>> and LLDD (adapter driver).
> 
> Great, do we need to learn the subsystem-specific dictionary now
> before submitting the patches for it? =)
> Really, you are asking me to change one term to its synonym just
> because it's mainly unused here. Now you know what it means, the
> others can easily google it and get to learn something new. Win-win.)

I already knew what it meant, but it was unclear if my idea of what you
meant was actually the same as yours. Sticking with the vocabulary already
used since *a long time ago* makes life easier for reviewers and avoids
confusion.

-- 
Damien Le Moal
Western Digital Research
