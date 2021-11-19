Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1690C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 19 Nov 2021 22:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhKSWMD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:12:03 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:65174 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhKSWMC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 Nov 2021 17:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637359740; x=1668895740;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AJS/HVJUYVMNIeWQV4eynWeZRF1kSLBU9rGtDb0qNhQ=;
  b=YWQvapkVqOWcDSis7qMY1b9TsDTlNem76pisN5Jdn1ouQ+q9Fhn4F2lr
   0our8/JnaagbQ89h4xu36HMAL5lyNT3OEzMj2CJMtYQLu//WN1SwgkX39
   zigns7dwf4+oyabLX4qcc1BDdA9Vy1JwQHbaQhGFSjPPzrUQ1zn/B8f6z
   1UBpj5+1WfWjG6cleZjHjtxKWulVt8a7iSoB0HzrjijNIKi0PvKdcOG8f
   NzgFpdICpmCw/W1qg36dg0YnT85/9BnMN8AvELxGoJPQo3wI6mFdXLs3N
   7NuKEkCBqXbiMXY53HJAr32PnbKW/JhCse5NI4BedMFnag8F6gnZ2CesL
   w==;
X-IronPort-AV: E=Sophos;i="5.87,248,1631548800"; 
   d="scan'208";a="185134227"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2021 06:09:00 +0800
IronPort-SDR: Lqzkwuy7WsIAagFQPf05bth7C0VsclXAK5A5JfynPCAoYCYUzvFevX2Gko27xngctxer2ziujL
 Amg1RUzqAxmTaJz4YYlIQ+hXmRB6Yr7T0XJxEWMiJwFdJ7HDrmRQv/qQaFNhWbVCwOqsdEnCFI
 6ByWsgaZln8tvhvQVwqqwggoXoNHljJESquyAW33qUSSEQvNxhnTHzwztjJSN0jq7YKGTbFALN
 ZrSwqIFj5olSI8oV6uFDak0baKtjyog+u4199AmLI6EbdhyLOrzELuXZc+AptEajGQLNfFG+Be
 0yGGjzum89CSZqlVsFcgkAf4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 13:42:25 -0800
IronPort-SDR: kz29SQSUh0Ks4u3BrS1TH6S2VKpHCNQLOfhAx2qd32sPEnKLzqCnbdQaMmbOaLHeBz9JuHe9BM
 oLddylpGQ9DHk0cBEyBbACWVNeYczS6WYCq4nLm+rOwSYYVGmKIgC8MxTz97CKjxAOuGo37QSv
 uAQ3EwpiLVn/p906pjfXNHBTeMo4o1IYWtlRT4TP5zNRr/bimEa2Qj94827ZXxOLotkQL2jbmI
 tE3BU0D6X55A5lcr+Ivl29gMRaI3vcXb5vArRsFwBAWuJ3Axob0rNFpeoeo5Bu+kAvc33cJKC0
 +b4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 14:03:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HwrJM5gs7z1RtVm
        for <linux-ide@vger.kernel.org>; Fri, 19 Nov 2021 14:02:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1637359379; x=1639951380; bh=AJS/HVJUYVMNIeWQV4eynWeZRF1kSLBU9rG
        tDb0qNhQ=; b=WCPX99Ws9FAeI9E+h+Deuzi3m7Sy6nde6XM3cBycMl2dJJex6kC
        UBRu7DQFzV0qtj0uceI4dio1hZGXPd0JVTFvBg3sfdbhxILOzcb9UNsDEUpBj2OO
        d+Cc6bmpH48rFiAhdmGgnJ/xnkgX6mhE0dlH1kZxRLtOI/nvQBHiNScDxi82H79j
        TGdJkAFdUm0CiqhzJYGa5o8WD97qfmHMwNruq8VVP9pHyfaMbODhUXzosrka9h14
        2rMPgQwQpJ4UdD1p2l7fY4v2xUg17lgs41TOxJSKRVtkNE6RG7ES16yzo9YemrN4
        IEZDTzT1LRTJ3ffOgomfoMbwADYTnk/aNDA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 90d6t9xU3Ens for <linux-ide@vger.kernel.org>;
        Fri, 19 Nov 2021 14:02:59 -0800 (PST)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HwrJM0C2dz1RtVl;
        Fri, 19 Nov 2021 14:02:58 -0800 (PST)
Message-ID: <12fc8470-cf81-791e-5b39-28b2508510fc@opensource.wdc.com>
Date:   Sat, 20 Nov 2021 07:02:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [GIT PULL] libata fixes for 5.16-rc2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     linux-ide@vger.kernel.org
References: <20211119084919.83906-1-damien.lemoal@opensource.wdc.com>
 <434d3413-2a58-2745-ae28-84ef3f9a7e7b@gmail.com>
 <CAHk-=wh3OuNk+3gkj-qd9CG8frCBQwpd8o+UewVuonsNXX6a+A@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHk-=wh3OuNk+3gkj-qd9CG8frCBQwpd8o+UewVuonsNXX6a+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/20/21 04:06, Linus Torvalds wrote:
> On Fri, Nov 19, 2021 at 7:46 AM Sergei Shtylyov
> <sergei.shtylyov@gmail.com> wrote:
>> On 19.11.2021 11:49, Damien Le Moal wrote:
>>> Baokun Li (2):
>>>        sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
>>>        sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl
>>
>>     At least this one needs fixing! You were too fast at merging... :-/
>>     Well, I guess this will need a follow-up fix now...
> 
> Hmm. I'm missing the context, but considering this note I have skipped
> this libata pull request.
> 
> Damien?

My apologies about that. I am going to update the PR and resend. The
read log patches need to go in. Without them, some drives fail to be
detected at boot time with some HBAs.

> 
>                Linus
> 


-- 
Damien Le Moal
Western Digital Research
