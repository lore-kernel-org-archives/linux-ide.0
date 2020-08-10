Return-Path: <SRS0=g8lw=BU=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B358C433DF
	for <linux-ide@archiver.kernel.org>; Mon, 10 Aug 2020 20:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575F220838
	for <linux-ide@archiver.kernel.org>; Mon, 10 Aug 2020 20:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgHJUCD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:02:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47813 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgHJUCD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Aug 2020 16:02:03 -0400
Received: from marcel-macpro.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 20EF2CED43;
        Mon, 10 Aug 2020 22:12:03 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 3/3] drivers/clk/clk-asm9260.c
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <bdab839e-1aba-5b0f-e5de-52ddebc8b9ed@gmail.com>
Date:   Mon, 10 Aug 2020 22:01:58 +0200
Cc:     YourName <argoz1701@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        mturquette@baylibre.com, linux-ide@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>, linux-clk@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B73FCD9B-842F-440C-8BF1-16C9F415A341@holtmann.org>
References: <20200810005941.20581-1-argoz1701@gmail.com>
 <bdab839e-1aba-5b0f-e5de-52ddebc8b9ed@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

>> From: Daniel <argoz1701@gmail.com>
> 
>  Full name needed here.
> 
>> ---
>> drivers/ata/acard-ahci.c  |  6 +++---
>> drivers/bluetooth/bfusb.c |  5 ++---
>> drivers/clk/clk-asm9260.c | 12 ++++++------
>> 3 files changed, 11 insertions(+), 12 deletions(-)

please don’t intermix patches for different subsystems. And have a proper commit message explaining what is changed.

Regards

Marcel

