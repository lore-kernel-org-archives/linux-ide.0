Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081A9C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 31 Jan 2022 00:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbiAaAiY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Jan 2022 19:38:24 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60695 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiAaAiX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Jan 2022 19:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643589503; x=1675125503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AERiGtZOwFJzxtYUptzeMEeHyCGma/ltw+rWxDLXW+Q=;
  b=MjFva/Af/x00YheOqvchrEURSUACUfY1HmYb/v9wOazgvQtZanC+puCi
   Y2okeOmtZ0dKE2cY1fKaFqjd4CoDCEP3WiB1rRJO+1Rvn3JGDhDXl0Oi0
   YX3xKOkjY8DXLolOA2MxrVe5d6yD0ctp4IFC/3fHEmRw811O3H/N/W8wc
   bXoNbvlTc4RS+Hw7YOrDnrTjtd2cMPzy/jB/Xk4ZsNITdv4UbXqV+4JVR
   7CX/TO+t8vqSA6LueJfnMfsgfKN5YYtABWR9vDJiNvlRcn3pHdv35uHhu
   8KefZtNUcxvRDbN5zl9SXP8e4LN4BPI87bGsoQfUIJ8Q+OaLcfOJpOnpL
   g==;
X-IronPort-AV: E=Sophos;i="5.88,329,1635177600"; 
   d="scan'208";a="303645437"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2022 08:38:22 +0800
IronPort-SDR: ZRbacUWa7oIp0HAKMGfJcN010S3w7QQTAtCV6QR3jul+XOSKuVGKkzzxEISxcTJofb3AU1uxXS
 eyTLyPeSzOzrsk6ThFLm9zl7wagyHBn679Q4Eu0cavggiIPbguEMQzim2df3F0ijy/+2YRSWd2
 93CXUBS8kQ9WAEF/w1afeUSAc1sTn5kS3DESF1WeyeR8LyezqtX/yNFFrfW7EZb++eo3OZnKsP
 XXyzl/EntYiaiWRBCdMZM5AUphaplgjr2EkuhT640VU+HKsUx6UG5uZNq5JXoScK+wOemtw+FQ
 6zFHT6J/Nul9q40eSn3OJwEQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 16:11:35 -0800
IronPort-SDR: iTNKRm+EPefTyJOxj38cCkPl/I+KuvHUDZ/M85cKjQgeNlW7wL7dcf2LzuldpL7254K5cYBYZr
 KbGaLQTtfUL0xEz50NJ4p/VYjtENWaEzZ//NACbKkfcNVOJUH76izrvNKRZ8S2RYrlFlylRSRm
 2Q1YoDh2fYC2pRdsarZtBnRX15cWvGBn/80x8QuX/XxYEvMk+FiRcxH4J2nYXR/hQqv8m2nf62
 08GzW59lZV3vd0+trEgob8N2twDsBoauUcCcaJPWgGaBBmJXWGV9xdtSiUD2f3zJXtJb26tdmw
 BcE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 16:38:23 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jn8LQ1tw6z1SVnx
        for <linux-ide@vger.kernel.org>; Sun, 30 Jan 2022 16:38:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643589501; x=1646181502; bh=AERiGtZOwFJzxtYUptzeMEeHyCGma/ltw+r
        WxDLXW+Q=; b=drs9TV2heAJeEGVC1R+RZ+SBZswgmscL14F2Q+KLBww/3UjxZ7y
        H9SV6GrdUWlSV4BnUcJdoXZiWI5AGKtG9kUNlvmfhneATB8c0nqoMbqIVSqJK9dr
        ROuJ7FPuZ6udl8hx2swNoBdhSIIDkDa3ljCQy+sHVeYTahWttI2FMAYiAaRpKCgN
        +1oR+HZJAM4RkLTC4YxPNv5Hp1+27X00MtwmBFlsd2VjVL75q8kZwfIJ+2dIZfIE
        hxxAyJ4DmLmxCTiOAkz7A5YHdbN689Z3vamxqdG1AlKrnW2oJRilFr4pvpGC+6Lw
        uP9hxtYo3yUAMb7AyW4KvOo1SIb/ByZi1BA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1PJEQWEf2dxM for <linux-ide@vger.kernel.org>;
        Sun, 30 Jan 2022 16:38:21 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jn8LN4qtXz1RvlN;
        Sun, 30 Jan 2022 16:38:20 -0800 (PST)
Message-ID: <1616d043-69e0-abac-f70a-95d8ef2f0555@opensource.wdc.com>
Date:   Mon, 31 Jan 2022 09:38:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [GIT PULL] Revert ata fix for 5.17-rc2
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ide@vger.kernel.org
References: <20220128121008.46586-1-damien.lemoal@opensource.wdc.com>
 <CAHk-=wj2uzk6iKhu2qnOOAqaT6pQ99oaY89RvEmAqHS1XP1rvQ@mail.gmail.com>
 <YfTluSca/ye+lmrn@kroah.com>
 <CAHk-=wjAajZDJoqy93DVLQ+ZJQ+w1ScCxsnS-ELdL12kqYM_Gg@mail.gmail.com>
 <YfagEeprzcZnbWjg@sashalap>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <YfagEeprzcZnbWjg@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/01/30 23:28, Sasha Levin wrote:
> On Sat, Jan 29, 2022 at 09:07:14AM +0200, Linus Torvalds wrote:
>> On Sat, Jan 29, 2022 at 8:59 AM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> It's up to you all, if you think the patch is correct, keep it for now.
>>
>> In the fixed form (ie with Damien's fix for the wrong test polarity),
>> it's certainly not wrong, and matches a lot of our standard patterns -
>> including our documentation in
>>
>>    Documentation/driver-api/driver-model/design-patterns.rst
>>
>> I did a quick visual grep, and all the cases of
>> devm_kzalloc(..GFP_KERNEL) I grepped for did indeed have that "if
>> (!..)" error handling pattern for the return value, including other
>> cases in the ATA subsystem.
>>
>> That was very much a "quick visual grep" though, so no guarantees, and
>> I stopped looking after it was so obvious. IOW, it was just a
>>
>>   git grep -1 devm_kzalloc.*GFP_KERNEL
>>
>> and then looking at the output and saying "yup, they all seem to do
>> that allocation failure test".
> 
> I think that in this case the issue isn't the correctness of the
> devm_kzalloc() allocation test itself, but rather the context in which
> it's made in:
> 
>          host = ata_host_alloc(dev, 1);
>          if (!host)
>                  return -ENOMEM;
>          ap = host->ports[0];
> 
>          ap->ops = devm_kzalloc(dev, sizeof(*ap->ops), GFP_KERNEL);
>          if (!ap->ops)
>                  return -ENOMEM;
> 
> My reading of ata_host_alloc() is that it allocates a refcounted 'struct
> ata_host', but due to how we handle the failure of the following
> devm_kzalloc(), we will never invoke ata_host_release() because the ref
> won't be dropped anywhere.

As explained in my reply to Greg email, the path is:

ata_devres_release() -> ata_hot_put() -> ata_host_release()

But for that to happen, the last ref on the dev must be dropped.

> So yes, the patch looks correct in the context shown by the patch
> itself, but once we look at the entire function I think it's incorrect
> (or, at least, I would expect more reasoning beyond "the static checker
> told us so" around why it might be correct in the patch message itself
> if I'm wrong).

As long as the dev last ref is dropped if there is a probe error, I think there
are no issues here. If that is not the case and the dev is not dropped on probe
error, then there is a leak, but then that leak likely exist for most ata
drivers. I will spend some time checking all this.

-- 
Damien Le Moal
Western Digital Research
