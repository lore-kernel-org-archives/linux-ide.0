Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE99ECAAD5
	for <linux-ide@archiver.kernel.org>; Sat, 10 Sep 2022 08:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIJIYl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 10 Sep 2022 04:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIJIYi (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 10 Sep 2022 04:24:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D201BDF09
        for <linux-ide@vger.kernel.org>; Sat, 10 Sep 2022 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662798272; x=1694334272;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3Cx5V1X+W7yy5o4//P50VU22wRF+vaid1kU1sjxXoMk=;
  b=EH0diifuTUXKIynMD7TmFhc2xezMPrIPIjgtcSENQ1qvftfq9CE/wDEh
   7qpLbzXgn75wB6tcdNaR7dso9GCyYyPnFrCCsNujcwiOdt/Y46IKa8UQu
   kl0rEMy0dDSmlT2CPRggmtVEjMyVANb7xkh9pgB0ZCD0NqFaZbFACUks5
   b5PZ6d131G1CHPiTzw8GPB63Ond2ULQzfh6WnMDQ+MtCxVslsssJcXr2R
   NBsJi3Fb2LFbjtVeBfcGG9L6pOcrUf453wqDRUBX1tKY/f+YTii4lmMix
   jURkt7dHPeAB2tLpYJswKWM7bnWxR4mrQ4f4ksHrvCtfEz+1BbauhugSp
   g==;
X-IronPort-AV: E=Sophos;i="5.93,305,1654531200"; 
   d="scan'208";a="315286071"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2022 16:24:31 +0800
IronPort-SDR: TRM9qC43M0j5ZdRkwjO37hpEqMEOTkMorx4NnXOSJlgpkaXAaL1FP01DSoSFHe2n66+xEMFMwJ
 5AOpyupPY2MD5NEW62CmEBYJMcCJDfHB3LDxOFz6q9yDdx+UpSziSrA6eqZkujuMJlFZXHPVUP
 pLFTvFx0mDjKC3OM7Ig9vW1e5NvdEfGdzn70vZovMLXeJ8lvKw5oq9gtLJxXPqBveEJtXl+nw/
 JCqA4fqmy+lLaspYZjWKyM7JnM34AbOL36mLeUNiGe+C0piBHek5s+IYmcSvUQSW3eAgCophvO
 ih/yIW93bb+ntEmX38SKinVF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2022 00:44:49 -0700
IronPort-SDR: 1UffQOxJkg8oURyVozxqmIKjCPCFMTC9s/9223iLqlorWz9DJ0Bh2BQOjRk2AIcBa1Ih4wNWL+
 HKnq9FyXoLHXU6FT1s8M7G17BUoO5zUhBgorYprATBkLtC4mYvL/onQMWFJef1WGt8qEw6MAi2
 Dknejfo0NRGVnfALvs8lRH8GqUNzirD48zQqEK/WgRvZ6KOiof4EKQp76S8KhLBSMq6qqyyBcs
 T3Dxa67nHtpAr6W7W5gmyBh34OhbAUdtQX7sCzJaqJtqChRLXwkVmydm4HOR4fwD2dgasYDjmA
 JA4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2022 01:24:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MPm9q37Krz1RvTr
        for <linux-ide@vger.kernel.org>; Sat, 10 Sep 2022 01:24:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662798270; x=1665390271; bh=3Cx5V1X+W7yy5o4//P50VU22wRF+vaid1kU
        1sjxXoMk=; b=MsMJyhOp/GAMNKZ9LvKV2dWLG7YyCEJ4HiIcWvec9Jr7O42Q3dq
        iEm23hczQDhV9pAKyG0YIuvMmCLJSHsmk+PMtIcWvf4JrpfWrJTEaYiVb5gad8NJ
        igSEn41laJ12/i0+VDjsskBjhA3OkKMak4P5u/g6RZ2Oyoclf6zzJD4HArb1sx8R
        kyKuLiNQHPVT8UfkOw3ezbltXxWvpNpKhpYPw3uKCQeQu/A5rVWatX3IvugIf2AT
        spB3TwLOWJNamqYV2KUZ75N7gDqKfyY+LCWxIrs1nXzoPChxW3itZL3oTQ3WizHV
        DHY/zp0M3H7M7ClKjqOvL+5nN2qTM6dxGbQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yv4KOEsSZv68 for <linux-ide@vger.kernel.org>;
        Sat, 10 Sep 2022 01:24:30 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MPm9n38KCz1RvLy;
        Sat, 10 Sep 2022 01:24:29 -0700 (PDT)
Message-ID: <3597fe1a-aca3-b854-ae30-f5d069c5003b@opensource.wdc.com>
Date:   Sat, 10 Sep 2022 17:24:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH] drivers/ata: fix repeated words in comments
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Conor.Dooley@microchip.com, wangjianli@cdjrlc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220908124937.25962-1-wangjianli@cdjrlc.com>
 <e2f882f7-6871-a754-fbbd-6a5201f45f4a@microchip.com>
 <3a73cf7f02915891c77dc5a3203dc187f6d91194.camel@HansenPartnership.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <3a73cf7f02915891c77dc5a3203dc187f6d91194.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/09/08 22:02, James Bottomley wrote:
> On Thu, 2022-09-08 at 12:56 +0000, Conor.Dooley@microchip.com wrote:
>> On 08/09/2022 13:49, wangjianli wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>> know the content is safe
>>>
>>> Delete the redundant word 'in'.
>>>
>>> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
>>> ---
>>>   drivers/ata/libata-eh.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index 7c128c89b454..ca865a95cf24 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -863,7 +863,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list
>>> *t)
>>>    *
>>>    *     Set ATA_PFLAG_EH_PENDING and activate fast drain if
>>> @fastdrain
>>>    *     is non-zero and EH wasn't pending before.  Fast drain
>>> ensures
>>> - *     that EH kicks in in timely manner.
>>> + *     that EH kicks in timely manner.
>>
>> Hey wangjianli,
>> This does not look like the right fix to me.. To me, it looks like it
>> should be s/in in/in in a/.
>>
>> If you're using an automated tool, which I can only assume you are,
>> to find these typos it'd be a good idea to check the output for
>> correctness prior to sending patches.
> 
> And it would also have been nice to accommodate the exact same feedback
> last time these patches were posted:
> 
> https://lore.kernel.org/all/cec12e246d7151f6041bf553629a3047e81d4afe.camel@HansenPartnership.com/
> 
> It's really disappointing you haven't accommodated any feedback either
> into your bot or the patches it sends.  Not doing so really does render
> this work largely useless.

And another submitter sent a similar incorrect "fix", twice, ignoring my
comments. I am OK with applying such fixes, even though they have little value.
But the submitter has to be willing to listen and fix their patches. I will not
do that for them :)


-- 
Damien Le Moal
Western Digital Research

