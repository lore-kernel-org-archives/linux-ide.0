Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD3C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3D220702
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA3KDw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:03:52 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52642 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgA3KDw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:03:52 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B0F4D15AB0D1A;
        Thu, 30 Jan 2020 02:03:50 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:03:49 +0100 (CET)
Message-Id: <20200130.110349.1758084246617103502.davem@davemloft.net>
To:     dan.carpenter@oracle.com
Cc:     b.zolnierkie@samsung.com, linux-ide@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ide: make drive->dn read only
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200121125942.hkr3zg77i5gtgc7v@kili.mountain>
References: <89d856ef-7c00-a2b7-bfcc-483c78092d20@samsung.com>
        <20200121125942.hkr3zg77i5gtgc7v@kili.mountain>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 30 Jan 2020 02:03:51 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 21 Jan 2020 16:06:42 +0300

> The IDE core always sets ->dn correctly so changing it is never
> required.
> 
> Setting it to a different value than assigned by IDE core is very likely
> to result in data corruption (due to wrong transfer timings being set on
> the controller etc.)
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks Dan.
