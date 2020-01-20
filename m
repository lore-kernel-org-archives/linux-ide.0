Return-Path: <SRS0=+4Y/=3J=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CA6C2D0DB
	for <linux-ide@archiver.kernel.org>; Mon, 20 Jan 2020 13:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B327A22314
	for <linux-ide@archiver.kernel.org>; Mon, 20 Jan 2020 13:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATNkq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:40:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56852 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATNkq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jan 2020 08:40:46 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 84A0B14EAD059;
        Mon, 20 Jan 2020 05:40:43 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:40:42 +0100 (CET)
Message-Id: <20200120.144042.1810086369376110530.davem@davemloft.net>
To:     dan.carpenter@oracle.com
Cc:     linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] cmd64x: potential buffer overflow in
 cmd64x_program_timings()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200107130441.y3owvcnxdljailt5@kili.mountain>
References: <20200107130441.y3owvcnxdljailt5@kili.mountain>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jan 2020 05:40:44 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 7 Jan 2020 16:04:41 +0300

> The "drive->dn" value is a u8 and it is controlled by root only, but
> it could be out of bounds here so let's check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.
