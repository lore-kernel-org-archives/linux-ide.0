Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE94BC433EF
	for <linux-ide@archiver.kernel.org>; Tue, 22 Feb 2022 11:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiBVLaP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiBVLaO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Feb 2022 06:30:14 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D80128669
        for <linux-ide@vger.kernel.org>; Tue, 22 Feb 2022 03:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645529391; x=1677065391;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=4XJ/A0A4cJL9TX/9ubPmG23L8B6gRo8bAYMfxCZnBQM=;
  b=STg7h0AlYtnR8wpgSG5/r/0eyxpYUNUn2MCik/T/rwFB/4FHKVU4SkVK
   m01ks8RZ5teb62Nkhsv3GeiRdEsq/r3s30aY2vL3opugeL+IDJNS4RG/j
   yw62jyCJkuZNYMop3Fixp1W5fS5vF6Nf8eO9nCCYp3xH2908HCK+ge4Zf
   M/Jrn8gaAo6etzPQwiwOB/4GmM+WPBjoQ6olhfoMuvcQsYFl7UuyWBCPD
   9MnMGYBVgUI01X+lqNa0lnRd7BfFGbZUnT4EFDrWisxAtnU127bPhGrvG
   sBsyxzY0T3BvLJD2nNx2Ig2KkRbFYxLfWDa8TnN0Kjt98+iWOATuXX5Uk
   A==;
X-IronPort-AV: E=Sophos;i="5.88,387,1635177600"; 
   d="scan'208";a="194601931"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2022 19:29:50 +0800
IronPort-SDR: frDdlxDdsSrSABeY4WhDPPexBk+4JKohN8Kns4uVRHIlshaU4mDFqXgb7wsRfR5iHW3nAC8xN9
 gcF/xSx+BRwbia7ROdrwvkwJS1Kx57LsFAJ8O7Clm8cn6/Jki7Gby/9LkAAv5kWjvd4PAfYj6G
 Vv5Y0XmaaCquM9CXuvk4xl3GVp9zPy/5nuok8Uyu12hcmYYnWoDPRWI9HDJxM7YZ9o2XhofTh7
 xDGa02YRfJpgXQrv7Y/HNtYtrksk5tZs6OTDKhTJG7skJrd70Hz0nTI9GrRlTG7qGfiPH196YJ
 1OQSD9E1UvmIir44XUMIEiT5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 03:02:27 -0800
IronPort-SDR: O9mmk/c6DCVL0eqTg5rkatn6jBm1sODsyQK75XvOJPwHKG2/prRYlJWAN+Ki5Ge871S1j0z8E9
 gcuvhDI8UtZscvXQ8QqKiwlqLFgfWMj7tkjeTUyBPCDmwL7rGpMphYUgo/Uu1R7I2QJGUTHLOV
 Mw+rjOuwfYnJuFWNn1lWe2gG+BsXJZke2NFC7IqnSJjnCImLFYEJei3Oq0L2ffEeVD7R47NIFc
 5YwAUiuPWH4WbgL6OqrIXKt0sgQwiLoG5aEAbzJUGIeXuLu+o//iotkFRs0NrV8AC8mhD2MAr8
 4kA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 03:29:49 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K2xlw5tRcz1SHwl
        for <linux-ide@vger.kernel.org>; Tue, 22 Feb 2022 03:29:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645529388; x=1648121389; bh=4XJ/A0A4cJL9TX/9ubPmG23L8B6gRo8bAYM
        fxCZnBQM=; b=FqFGRwBuQ88MtTD1d8KRiXNURyu6klygc4jb585x6R5h0B8eRIt
        +s8Ky+7ywdyzv/UE8JPcJv8mYZpDnC2GOqQMS8hHj85LlYysi9CK2vSkbFvqg/yJ
        ABZDW3oaIxidQatCxWbFs2Ew61IixWb8Ch0bIUMxoZXaB++xELfeGNTAauq1n4B4
        69l9S761Md8qndrPakg77BlvflI2mpaV/wjR+ZjCpMlZzFCah5HG7GfOF3W6BArQ
        3SumMpl53WqoiPZUlrc/LqnpblxZihMff8cHjhi7wf0aVj1bhRD1T1koELTJu+OE
        YMqvRukLXl5pRmPLkjCz9t2/TaTzZGqAi3g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sc1kRvBj4dYW for <linux-ide@vger.kernel.org>;
        Tue, 22 Feb 2022 03:29:48 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K2xlw1H9fz1Rvlx;
        Tue, 22 Feb 2022 03:29:48 -0800 (PST)
Message-ID: <c6da4641-a811-155c-eb48-3a6c26b0d61c@opensource.wdc.com>
Date:   Tue, 22 Feb 2022 20:29:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_hpt37x: disable primary channel on HPT371
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org
References: <e398d6e3-05f2-409f-6818-812f24e325eb@omp.ru>
 <feb0d6ba-baa2-6482-e6b4-eb5baed2a728@opensource.wdc.com>
 <6604b1f6-adcf-96f6-f736-4ade3642f6f7@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <6604b1f6-adcf-96f6-f736-4ade3642f6f7@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2/22/22 18:48, Sergey Shtylyov wrote:
> On 2/22/22 3:37 AM, Damien Le Moal wrote:
> 
>>> HPT371 chips physically have only one channel, the secondary one, however
>>> the primary channel registers do exist!  Thus we have to manually disable
>>> the non-existing channel (if the BIOS hasn't done this already).  Alan Cox
>>> has only added such code to the 'pata_hpt3x2n' driver, forgetting about
>>> this one... :-/
>>
>> No need to assign blame by name :) Something more neutral like:
>>
>> "Similarly to the pata_hpt3x2n driver, always disable the primary channel."
> 
>    Should I now repost?

I will fix it up. No need to resend.

> 
>> will do. Also, do you have a fixes tag for this one ? Is it again:
>>
>> Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")> ?
> 
>    Yes.
> 
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
