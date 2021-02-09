Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA31C433DB
	for <linux-ide@archiver.kernel.org>; Tue,  9 Feb 2021 09:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6696D64E3B
	for <linux-ide@archiver.kernel.org>; Tue,  9 Feb 2021 09:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhBIJLQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 9 Feb 2021 04:11:16 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42686 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230169AbhBIJA4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 Feb 2021 04:00:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UOHYi.4_1612861211;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UOHYi.4_1612861211)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Feb 2021 17:00:11 +0800
Subject: Re: [PATCH] ide: set missing QUEUE_FLAG_ADD_RANDOM
To:     Christoph Hellwig <hch@infradead.org>
Cc:     davem@davemloft.net, linux-ide@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20210209081013.38979-1-jefflexu@linux.alibaba.com>
 <20210209083220.GA1708073@infradead.org>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <fde2f52d-48a4-b193-adfc-8abbaeb5c04f@linux.alibaba.com>
Date:   Tue, 9 Feb 2021 17:00:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209083220.GA1708073@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 2/9/21 4:32 PM, Christoph Hellwig wrote:
> On Tue, Feb 09, 2021 at 04:10:13PM +0800, Jeffle Xu wrote:
>> While the whole block layer has migrated to mq framework,
>> QUEUE_FLAG_ADD_RANDOM is not included in QUEUE_FLAG_MQ_DEFAULT as the
>> default flags.
> 
> If you are using the legacy ide code anywhere please switch to libata
> ASAP as it is about to go away.
> 

Thanks for replying. I have not encountered any trouble in reality
world. Actually I just find that this code can't work well when I'm
search QUEUE_FLAG_ADD_RANDOM. I'm not familiar with ide world. Please
let me know if I miss something.

Also there are several device drivers still calling
'blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q)', though they have
migrated to mq and have no need clearing QUEUE_FLAG_ADD_RANDOM.

-- 
Thanks,
Jeffle
