Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32A3EDE99E
	for <linux-ide@archiver.kernel.org>; Thu, 14 Sep 2023 10:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbjINKCp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbjINKCo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 14 Sep 2023 06:02:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908971BE8
        for <linux-ide@vger.kernel.org>; Thu, 14 Sep 2023 03:02:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7552EC433C7;
        Thu, 14 Sep 2023 10:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694685760;
        bh=S7IARjgGcx7CYNSqHubU0kFR5gIAxz1kt0mj0H26lIo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AvQSvw6wvK3zVbQMM/JN8neTTPZnAa3ZUV/B011xXDX6eGZ7Je5EXVVBEQKTRxJGx
         xoMkVrdjTyc0YiQGh5ta50FsZgp4udIHYm882FRsNBXcDjoLg1q9jacZ1amddOuOPE
         ASx7WUaqmd3jH+/5efH/qd+JkRd2Y1+4eYDvBjbhUTwHwhYsJq29FWcwWN0ZRGI3BM
         Pj8Kug572esamrGm/IgZt7wnEn51jdWGqDcLCbryupiSjTwpZhlf9yeFPobQ717oKM
         lI5mRDDlftCIXiDuiUAtMpNO8Rq/TvBOa8MHiZ96MYuJo433rrCKTGyUZb3ed2slyv
         xj3365TZs6pnA==
Message-ID: <2bc9d113-1119-12c3-f459-4dab8d8f6aa6@kernel.org>
Date:   Thu, 14 Sep 2023 19:02:38 +0900
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
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZQLNJf9qr5FjpgM2@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/14/23 18:06, Niklas Cassel wrote:
> On Thu, Sep 14, 2023 at 08:51:06AM +0900, Damien Le Moal wrote:
>> On 9/14/23 07:19, Niklas Cassel wrote:
>>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>>
>>> commit 1e641060c4b5 ("libata: clear eh_info on reset completion") added
>>> a workaround that broke the retry mechanism in ATA EH.
>>>
>>> Tejun himself suggested to remove this workaround when it was identified
>>> to cause additional problems:
>>> https://lore.kernel.org/linux-ide/20110426135027.GI878@htj.dyndns.org/
>>>
>>> He and even said:
>>> "Hmm... it seems I wasn't thinking straight when I added that work around."
>>> https://lore.kernel.org/linux-ide/20110426155229.GM878@htj.dyndns.org/
>>>
>>> While removing the workaround solved the issue, however, the workaround was
>>> kept to avoid "spurious hotplug events during reset", and instead another
>>> workaround was added on top of the existing workaround in commit
>>> 8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").
>>>
>>> Because these IRQs happened when the port was frozen, we know that they
>>> were actually a side effect of PxIS and IS.IPS(x) not being cleared before
>>> the COMRESET. This is now done in commit 94152042eaa9 ("ata: libahci: clear
>>> pending interrupt status"), so these workarounds can now be removed.
>>>
>>> Since commit 1e641060c4b5 ("libata: clear eh_info on reset completion") has
>>> now been reverted, the ATA EH retry mechanism is functional again, so there
>>> is once again no need to thaw the port more than once in ata_eh_reset().
>>>
>>> This reverts "the workaround on top of the workaround" introduced in commit
>>> 8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").
>>>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>
>> We need a fixes tag. Same for patch 1.
> 
> The workaround introduced in commit 1e641060c4b5 ("libata: clear eh_info on
> reset completion") broke ATA EH retry logic, so the proper commit that we
> fix is that commit.
> 
> However, if we put a Fixes tag with that commit, then this patch will get
> backported to all possible stable kernels that has that commit, something
> that we do _not_ want.
> 
> We can only remove this workaround for kernels that has commit 94152042eaa9
> ("ata: libahci: clear pending interrupt status").

Squash the 2 fixes together in a single commit ?

> 
> Do we really need a Fixes tag?
> The workaround (which broke ATA EH retry logic) has been in the kernel for
> 14 years, since then, we've only seen two complaints..
> the one by Bruce Stenning 12 years ago (see commit log for this patch),
> and the complaint from Huawei folks this year..
> 
> I guess we could set the Fixes tag to 94152042eaa9 ("ata: libahci: clear
> pending interrupt status"), since we depend on that commit.
> However, that is basically a lie, since we are not fixing that commit.
> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

