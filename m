Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D439EDE9A1
	for <linux-ide@archiver.kernel.org>; Thu, 14 Sep 2023 10:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjINKiw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbjINKiv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Sep 2023 06:38:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28C71BFB
        for <linux-ide@vger.kernel.org>; Thu, 14 Sep 2023 03:38:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669C5C433C8;
        Thu, 14 Sep 2023 10:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694687927;
        bh=5ay8htv5a0eNhE4wnkGO34AcFiqCovdgjP0r1L1E+XQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PYk9JPtND5aCLbhm1GEHdgEQoeMHiMBlZhT7EC9FSD4GdyYYcBHssSauiD8ReKSGO
         dQhqc+fBjqvSRSthgyzMqESfnQjnRLJGwrG2+Y8f/Ood8FAXxKaaGGB2/5iB60JL4O
         K6kwnljKay0M8dnWnaIcoXVUM83XLweZPgqzakn/gtonFOcF4zaorZafn65aUddXhW
         CwK+cfLTmu3r0UIzv6mXqc2C+YZhoLXmJsuxvKL6t3dqu/iUk/fXs4mGWNaWujWu5x
         ZF0UmN38J4CeafX32qhC2G08w7SXNet5LJPatXNbf+Mencn6/KFJgoSrpz16VarLo8
         YF1N5BcFVpTpA==
Message-ID: <426f3efe-1b95-4db4-5419-6820b0ad4b20@kernel.org>
Date:   Thu, 14 Sep 2023 19:38:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] ata: libata-eh: do not thaw the port twice in
 ata_eh_reset()
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Niklas Cassel <nks@flawful.org>, Li Nan <linan122@huawei.com>,
        Li Nan <linan666@huaweicloud.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20230913221917.1217856-1-nks@flawful.org>
 <20230913221917.1217856-2-nks@flawful.org>
 <1da815e4-1335-83dd-f625-7fdcbec348eb@kernel.org>
 <ZQLNJf9qr5FjpgM2@x1-carbon>
 <2bc9d113-1119-12c3-f459-4dab8d8f6aa6@kernel.org>
 <ZQLcYP2a/og3mCN4@x1-carbon>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZQLcYP2a/og3mCN4@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/14/23 19:11, Niklas Cassel wrote:
> On Thu, Sep 14, 2023 at 07:02:38PM +0900, Damien Le Moal wrote:
>> On 9/14/23 18:06, Niklas Cassel wrote:
>>> On Thu, Sep 14, 2023 at 08:51:06AM +0900, Damien Le Moal wrote:
>>>> On 9/14/23 07:19, Niklas Cassel wrote:
>>>>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>>>>
>>>>> commit 1e641060c4b5 ("libata: clear eh_info on reset completion") added
>>>>> a workaround that broke the retry mechanism in ATA EH.
>>>>>
>>>>> Tejun himself suggested to remove this workaround when it was identified
>>>>> to cause additional problems:
>>>>> https://lore.kernel.org/linux-ide/20110426135027.GI878@htj.dyndns.org/
>>>>>
>>>>> He and even said:
>>>>> "Hmm... it seems I wasn't thinking straight when I added that work around."
>>>>> https://lore.kernel.org/linux-ide/20110426155229.GM878@htj.dyndns.org/
>>>>>
>>>>> While removing the workaround solved the issue, however, the workaround was
>>>>> kept to avoid "spurious hotplug events during reset", and instead another
>>>>> workaround was added on top of the existing workaround in commit
>>>>> 8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").
>>>>>
>>>>> Because these IRQs happened when the port was frozen, we know that they
>>>>> were actually a side effect of PxIS and IS.IPS(x) not being cleared before
>>>>> the COMRESET. This is now done in commit 94152042eaa9 ("ata: libahci: clear
>>>>> pending interrupt status"), so these workarounds can now be removed.
>>>>>
>>>>> Since commit 1e641060c4b5 ("libata: clear eh_info on reset completion") has
>>>>> now been reverted, the ATA EH retry mechanism is functional again, so there
>>>>> is once again no need to thaw the port more than once in ata_eh_reset().
>>>>>
>>>>> This reverts "the workaround on top of the workaround" introduced in commit
>>>>> 8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").
>>>>>
>>>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>>>
>>>> We need a fixes tag. Same for patch 1.
>>>
>>> The workaround introduced in commit 1e641060c4b5 ("libata: clear eh_info on
>>> reset completion") broke ATA EH retry logic, so the proper commit that we
>>> fix is that commit.
>>>
>>> However, if we put a Fixes tag with that commit, then this patch will get
>>> backported to all possible stable kernels that has that commit, something
>>> that we do _not_ want.
>>>
>>> We can only remove this workaround for kernels that has commit 94152042eaa9
>>> ("ata: libahci: clear pending interrupt status").
>>
>> Squash the 2 fixes together in a single commit ?
> 
> We can do that, but the problem would be the same.
> 
> commit 94152042eaa9 ("ata: libahci: clear pending interrupt status") is
> currently in your for-next branch. Patch 1 and patch 2 in this series
> depend on this commit.

That patch is in for next for testing only. I can remove it and change it.

> 
> Both of these fixes (patch 1 and patch 2 in this series) fix issues caused
> by commit 1e641060c4b5 ("libata: clear eh_info on reset completion"),
> a 14 year old commit.
> 
> We could add a Fixes that on 1e641060c4b5 ("libata: clear eh_info on reset
> completion").
> But might get this patch to get backported to all old kernels.
> We don't want that, as we depend on 94152042eaa9 ("ata: libahci: clear
> pending interrupt status").
> 
> 
> So... skip a Fixes tag or add a Fixes against on the commit that we depend
> on? (Even tough we are not "fixing" that commit.)

I can add the 2 patches to for-6.6-fixes without fixes tag and just cc stable.
There are not that many LTS versions. Oldest still maintained is 4.14.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

