Return-Path: <SRS0=+4Y/=3J=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EC7C2D0DB
	for <linux-ide@archiver.kernel.org>; Mon, 20 Jan 2020 13:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20DF2087E
	for <linux-ide@archiver.kernel.org>; Mon, 20 Jan 2020 13:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgATNjq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:39:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56804 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATNjq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jan 2020 08:39:46 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4DB9314E9DEF7;
        Mon, 20 Jan 2020 05:39:44 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:39:43 +0100 (CET)
Message-Id: <20200120.143943.2039981041531373204.davem@davemloft.net>
To:     wanghai38@huawei.com
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide: remove set but not used variable 'hwif'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191026015738.4865-1-wanghai38@huawei.com>
References: <20191026015738.4865-1-wanghai38@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jan 2020 05:39:45 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>
Date: Sat, 26 Oct 2019 09:57:38 +0800

> Fix the following gcc warning:
> 
> drivers/ide/pmac.c: In function pmac_ide_setup_device:
> drivers/ide/pmac.c:1027:14: warning: variable hwif set but not used
> [-Wunused-but-set-variable]
> 
> Fixes: d58b0c39e32f ("powerpc/macio: Rework hotplug media bay support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Applied.
