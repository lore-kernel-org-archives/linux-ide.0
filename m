Return-Path: <SRS0=E6CZ=VK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7D6C742A7
	for <linux-ide@archiver.kernel.org>; Sat, 13 Jul 2019 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4AB20838
	for <linux-ide@archiver.kernel.org>; Sat, 13 Jul 2019 13:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfGMNwL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 13 Jul 2019 09:52:11 -0400
Received: from enpas.org ([46.38.239.100]:52384 "EHLO mail.enpas.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfGMNwL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Sat, 13 Jul 2019 09:52:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id E0255FFDB4;
        Sat, 13 Jul 2019 13:52:09 +0000 (UTC)
Subject: Re: Legacy IDE driver for Buddha IDE is still in use
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ide@vger.kernel.org
References: <6c74d6b1-1dad-e76e-6499-b677991c40c4@enpas.org>
 <20190708214642.GA12227@infradead.org>
From:   Max Staudt <max-linux@enpas.org>
Message-ID: <5eaa08a0-6a10-8746-e776-e23e2ac797fb@enpas.org>
Date:   Sat, 13 Jul 2019 15:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190708214642.GA12227@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 07/08/2019 11:46 PM, Christoph Hellwig wrote:
> Linux 5.1 and newer have a libata driver for the Buddha controller
> (drivers/ata/pata_buddha.c, CONFIG_PATA_BUDDHA).  Please check if
> that works for you and if not report back to the list.

That's great news, thanks for pointing this out.
I've given it a try and so far it seems to work a treat.

I'll submit a patch to move Buddha detection from initcall to module_driver() autoprobing. That way, it's also no longer necessary to load the driver manually, and pata_buddha can be built right into the kernel.


Max
