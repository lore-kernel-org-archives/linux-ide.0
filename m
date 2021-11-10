Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F50C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 10 Nov 2021 06:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F1B61078
	for <linux-ide@archiver.kernel.org>; Wed, 10 Nov 2021 06:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhKJGUV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 Nov 2021 01:20:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55631 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhKJGUV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Nov 2021 01:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636525053; x=1668061053;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Rmx3IGY2TerVYvGYfK3nui00T3aUS6JZpAwKjGBrc0=;
  b=KYBrUETo5/r7R3+B4TksCedgsUw0KITSItef8eTKo7SJBG7xipgFbbL7
   et7TDRV9XqeI3uRcp3w8ANuSb6QJ8dvPQoIYl/IrevjDFhclUvx9yktRK
   ICV+xNnxkzn11HaaRo5KVFl2Wx780JdxGXxExBtOKQngvSTz2+/u+jpsd
   H06cP2EYE1x6AzIoO5Lrpt7u5zMnqcmtVfTHOoJbP1s8BAR4gF8gWDVmD
   gYbniHb/CyMVZzflNBZ7bG3BGWQEhzzyjiVMW7nbrpN2yoVPzWwjKFn7e
   BiAe14YWtHgMcBxy0j1MQcKLLacMXQfLF8JzgXteY6mD64llMZAzb/3LH
   A==;
X-IronPort-AV: E=Sophos;i="5.87,222,1631548800"; 
   d="scan'208";a="185202126"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2021 14:17:32 +0800
IronPort-SDR: JjY56RnOUHKEiUtxzp0Rvb4SafkP29pZuwQPKSqKrHNZIsRrKNJgs5mf86elx8NMWhnocotGLD
 Tg1UlVL/AJmRQiVkDoNtLKzG2X71MtEv/jKX+IX+omQ25rUf/kwGj/o5pmXlmYKzB5hde3Lh30
 7D94ZsDA7OBoKbP/wdLGOpaIdw7hFKu8xm96XpGlFJmtzVxVHkhm4+/kWAORBVblrPvTpzYQwr
 tu1ICxbqvlnpVHSZ9iEP+ar+fjGE3o0jBNrFmUra5eKyv/utVzAThGxqJFd9tXckbQ1sQRukAS
 y8JyplV/btQdUSxSRUpFhWfQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 21:51:12 -0800
IronPort-SDR: DEPXBcENXMVmS0TJ34C3xy0f8oPFZLZY5k/AFmONxTtt8QRhETU1Zhx6biLae3FYgKpyZ6Ofrl
 Ld2vRl0HWcVZeunp8z58AGQeA9wOuN2gkuFXQChd2lpWsYhmRX4ktPDq5kz5B0hmwVCvUurimR
 ABo2pUUPrjN5pljAww5L6shbtNY/7ng5qXX3VADYpHNXEqacRF6+Wsg+ghz4CLHPmTKS1GHM7k
 Osd1i0LyLCH9UWuhLpQuqkEIwrMgIkt6CV9gt1Pqm1tniBMZ8fnDE4RfHJ+K1DgE1q2bqkTM2x
 mE8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 22:17:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hpvld4NxJz1RtVn
        for <linux-ide@vger.kernel.org>; Tue,  9 Nov 2021 22:17:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636525053; x=1639117054; bh=2Rmx3IGY2TerVYvGYfK3nui00T3aUS6JZpA
        wKjGBrc0=; b=DgRcJZo1cTnZH5+caQ75NP67TJe1COrE3rIw+ZkKqXGsc6DDZi3
        AZj8AquqlKKEG4WlGFjseAhWHClKg/Svdj6YfX45FWbJFMVpinct3O0dCAjOWTvK
        qIaNHwVqPVcruUPmaTxYuHCLTWNVuqhJmbC6OCNtyui//lUrobDky/0z95zr7YMY
        YtekU3GULSX7LYpG5gKX0mMx4qy0YoNdJsfLtxHtMzKEstzjr9LJBw2vRqmBTKf7
        Czgx15wmHd2GGoCMEL362FC8LI6o919n9yOPM781N/xnl4w4WKQV2gYsviS24uZe
        ZarsnKntlH7N6xRuO63hEQUce3UomNxF9iw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jDpXb6BVEoaK for <linux-ide@vger.kernel.org>;
        Tue,  9 Nov 2021 22:17:33 -0800 (PST)
Received: from [10.89.81.216] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.81.216])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hpvlc5nD2z1RtVl;
        Tue,  9 Nov 2021 22:17:32 -0800 (PST)
Message-ID: <1030065c-1ec2-991e-10a0-c01231b9b664@opensource.wdc.com>
Date:   Wed, 10 Nov 2021 15:17:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH] libata: add horkage for missing Identify Device log
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ide@vger.kernel.org
References: <20211108235723.408711-1-damien.lemoal@opensource.wdc.com>
 <YYo3N/dwJmOxCBHE@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <YYo3N/dwJmOxCBHE@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/11/09 17:54, Christoph Hellwig wrote:
> On Tue, Nov 09, 2021 at 08:57:23AM +0900, Damien Le Moal wrote:
>> ACS defines the ATA Identify Device Data log as mandatory. A warning
>> message currently signals to the user if a device does not report
>> supporting this log page in the log directory page. However, it is
>> useless to constantly access the log directory and warn about this lack
>> of support once we have discovered that the device does not support
>> this mandatory log page.
>>
>> Introduce the horkage flag ATA_HORKAGE_NO_ID_DEV_LOG to mark a device as
>> lacking support for the Identify Device Data log page. Set this flag
>> when ata_log_supported() returns false in ata_identify_page_supported().
>> The warning is printed only once on device scan and the log directory
>> not accessed again to test for Identify Device Data log page support.
> 
> Should we also just set it by default for older devices?  I'd need to
> look up when it was introduced, but I think it is a somewhat recent
> addition.

It is marked as mandatory at least since ACS-3.
Need to check before that. Will do.



-- 
Damien Le Moal
Western Digital Research
