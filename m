Return-Path: <SRS0=8+FM=BO=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E81C433E1
	for <linux-ide@archiver.kernel.org>; Tue,  4 Aug 2020 01:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8790D2073E
	for <linux-ide@archiver.kernel.org>; Tue,  4 Aug 2020 01:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgHDBtQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgHDBtP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 3 Aug 2020 21:49:15 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80E5C06174A
        for <linux-ide@vger.kernel.org>; Mon,  3 Aug 2020 18:49:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 423A5127928DE;
        Mon,  3 Aug 2020 18:32:30 -0700 (PDT)
Date:   Mon, 03 Aug 2020 18:49:15 -0700 (PDT)
Message-Id: <20200803.184915.1850382418234050518.davem@davemloft.net>
To:     andriy.shevchenko@linux.intel.com
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH v1] ide-acpi: use %*ph to print small buffer
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200730161042.41392-1-andriy.shevchenko@linux.intel.com>
References: <20200730161042.41392-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Aug 2020 18:32:30 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 30 Jul 2020 19:10:42 +0300

> Use %*ph format to print small buffer as hex string.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.
