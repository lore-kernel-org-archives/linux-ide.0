Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA79C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 11 Dec 2021 00:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243965AbhLKAIf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:08:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:12953 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243921AbhLKAIe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 10 Dec 2021 19:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639181098; x=1670717098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xEgeQ/Mk2e4FA08czcoHG5Hp46F5amIhTyxfqhk+t+k=;
  b=kMs9jUI41GYHHqXcp12aO6AACzZnwNkGU7Qqlxmux680bAxm2RmVmMJV
   MpNOCXW9pnYH+2f6KYuoGNp13YfuQwAD2ilVxRiuDKsID8tBZuhG1eXRA
   VE3u+kZx+rIjoPZcealroyaDz5TCkZupWkvdO/FRuQAUnV0TrqjvgrtJl
   AP0LdQJrZ2RV5OTP/RzxCGNkYVDN43qKOAlpXx1MqGqmPKKUC6ecke+WQ
   +Q6Bx3KihIsMg+9tdUhKh9yVsV6AYyUEejZzJqaeZW6IXCjPb7515rsyj
   sEQ5GCGYVNcLViTBl9y0+AqCO/AehfJrAkbSDkIkymbvQniNIefiPmxOj
   w==;
X-IronPort-AV: E=Sophos;i="5.88,197,1635177600"; 
   d="scan'208";a="192763313"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2021 08:04:57 +0800
IronPort-SDR: fvHm85ZU9IeFUHceVjW2E1GlkNKABjIBNUTGKMkUAsckWIqnB3Ok6OtLTjGgDAAuluxHRDeU8/
 3eJQ8iFUpt11t5fG/txjmgfR70wBjeXHxajN4/oXT1a79jLIxOmCOdW2wlZl29ufNYi9mrLe55
 npbHT8R2GUeU1cJ43JunGqIjqRuiglK/aLmbb/7+pdPmdFeDb/77GZfDoHq6FRnlHZ6dLl0Phm
 Ja7zHW12ApuAb8IngkCwqpsGwu4zjqvA9QP+jgJefTFTPTv9OMmRe2sQSfFsfOuR0SbsrFJBCS
 nAKLFA8ZW+ReNpk4ZYfuGy/Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 15:37:59 -0800
IronPort-SDR: 8mPdo+lidA0Uvd1lRwAoAljHQDBf9WuqDV+dezX/zlH7b5KGFuHZ1N17ZkF8qbSnelG4vnuTko
 ZsWj0Z3PQHRRrljb/yuovCyX94JY7womQ3kSWhAHczjiOJZ8q9LvdiuecUg3y+h4jG6nPHcVvE
 NmPz/64FtoUcnPPXccW7qekebu579O4MtgbNeq9gTSu2FGqSr0TK/XVmKJz+fg94xjbsJgmtr6
 GlO98WMYgCNw5A07Q7lbFZklPAdUOITPFv93r73D4Ewc1khczwjfxCBoQ1g3C7WNkvU76jJAZG
 IfY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 16:04:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J9p1Q4Glxz1Rwnv
        for <linux-ide@vger.kernel.org>; Fri, 10 Dec 2021 16:04:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639181098; x=1641773099; bh=xEgeQ/Mk2e4FA08czcoHG5Hp46F5amIhTyx
        fqhk+t+k=; b=H68JC5acb2gyp1NM51k/IDOW1mgoyM1B+LYvxYYnykfRHl4u1AB
        jjOh09dl9HiKwgYu5blzyrisA6k/Xul8PVjpAQw2WwaX9m8/Nra87hDp0bbjDclX
        8bY34UJlivO2BxJeniUOh8lWtI+5U4Pdy66VOnpVbzWXG556n5zB++9vtrjmyIEW
        NFggpTVNw9wJTn3O5opBHmXpID1XhiQR5QOaM7QWEXAVMzoW/yd4wmIf2JsfocGk
        rMISd4gdY6QftKjcMlFVGhOG//RleYJT4F2er9PmF/vjimAY8MGDPueKEW1JrSb3
        CvJp0KtFHE9Pit+fTjYTzM46xtcKP+UJF+A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4Be0oB7XSCtq for <linux-ide@vger.kernel.org>;
        Fri, 10 Dec 2021 16:04:58 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J9p1P2TPNz1RtVG;
        Fri, 10 Dec 2021 16:04:57 -0800 (PST)
Message-ID: <b5c109c5-9338-cd95-ae6d-b4bebd86a210@opensource.wdc.com>
Date:   Sat, 11 Dec 2021 09:04:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 2/2] ata: libahci_platform: Remove bogus 32-bit DMA
 mask attempt
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <20211209145937.77719-2-andriy.shevchenko@linux.intel.com>
 <YbOr0Y7qacDmCg73@smile.fi.intel.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <YbOr0Y7qacDmCg73@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2021/12/11 4:34, Andy Shevchenko wrote:
> On Thu, Dec 09, 2021 at 04:59:37PM +0200, Andy Shevchenko wrote:
>> If 64-bit mask attempt fails, the 32-bit will fail by the very same reason.
>> Don't even try the latter. It's a continuation of the changes that contains,
>> e.g. dcc02c19cc06 ("sata_sil24: use dma_set_mask_and_coherent").
> 
> I understand that some people have nothing besides bikeshedding, but this patch
> seems fine to everybody, am I right? Can it be applied (it's independent from
> patch 1 anyways)?
> 

Yes, this one seems fine to me. It would be good to get a different review
though (I know hard to get reviews on ata patches...).
I will queue it for 5.17.


-- 
Damien Le Moal
Western Digital Research
