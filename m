Return-Path: <SRS0=B3X7=C2=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0764C433E2
	for <linux-ide@archiver.kernel.org>; Thu, 17 Sep 2020 19:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AA320717
	for <linux-ide@archiver.kernel.org>; Thu, 17 Sep 2020 19:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIQT6A (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 17 Sep 2020 15:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgIQT57 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 17 Sep 2020 15:57:59 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F0EC061222;
        Thu, 17 Sep 2020 12:44:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E0491359EF9C;
        Thu, 17 Sep 2020 12:28:01 -0700 (PDT)
Date:   Thu, 17 Sep 2020 12:44:45 -0700 (PDT)
Message-Id: <20200917.124445.1786301672047605176.davem@davemloft.net>
To:     mpe@ellerman.id.au
Cc:     wangwensheng4@huawei.com, benh@kernel.crashing.org,
        paulus@samba.org, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ide: Fix symbol undeclared warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87zh5oobnn.fsf@mpe.ellerman.id.au>
References: <20200916092333.77158-1-wangwensheng4@huawei.com>
        <87zh5oobnn.fsf@mpe.ellerman.id.au>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Thu, 17 Sep 2020 12:28:01 -0700 (PDT)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 17 Sep 2020 22:01:00 +1000

> Wang Wensheng <wangwensheng4@huawei.com> writes:
>> Build the object file with `C=2` and get the following warnings:
>> make allmodconfig ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-
>> make C=2 drivers/ide/pmac.o ARCH=powerpc64
>> CROSS_COMPILE=powerpc64-linux-gnu-
>>
>> drivers/ide/pmac.c:228:23: warning: symbol 'mdma_timings_33' was not
>> declared. Should it be static?
>> drivers/ide/pmac.c:241:23: warning: symbol 'mdma_timings_33k' was not
>> declared. Should it be static?
>> drivers/ide/pmac.c:254:23: warning: symbol 'mdma_timings_66' was not
>> declared. Should it be static?
>> drivers/ide/pmac.c:272:3: warning: symbol 'kl66_udma_timings' was not
>> declared. Should it be static?
>> drivers/ide/pmac.c:1418:12: warning: symbol 'pmac_ide_probe' was not
>> declared. Should it be static?
>>
>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
>> ---
>>  drivers/ide/pmac.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> TIL davem maintains IDE?
> 
> But I suspect he isn't that interested in this powerpc only driver, so
> I'll grab this.

I did have it in my queue, but if you want to take it that's fine too :)
