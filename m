Return-Path: <SRS0=+4Y/=3J=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F71C2D0DB
	for <linux-ide@archiver.kernel.org>; Mon, 20 Jan 2020 13:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F242087E
	for <linux-ide@archiver.kernel.org>; Mon, 20 Jan 2020 13:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgATNkV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:40:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56834 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgATNkV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jan 2020 08:40:21 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4492214EAD059;
        Mon, 20 Jan 2020 05:40:20 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:40:18 +0100 (CET)
Message-Id: <20200120.144018.2001366678149022517.davem@davemloft.net>
To:     masahiroy@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide: remove unneeded header include path to drivers/ide
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200104164011.22189-1-masahiroy@kernel.org>
References: <20200104164011.22189-1-masahiroy@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jan 2020 05:40:20 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun,  5 Jan 2020 01:40:11 +0900

> I can build drivers/ide/ without this.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied.
