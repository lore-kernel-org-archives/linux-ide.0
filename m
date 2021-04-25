Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC3CC433ED
	for <linux-ide@archiver.kernel.org>; Sun, 25 Apr 2021 10:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3A461396
	for <linux-ide@archiver.kernel.org>; Sun, 25 Apr 2021 10:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhDYK0e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 25 Apr 2021 06:26:34 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:35957 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhDYK0d (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 25 Apr 2021 06:26:33 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1labxY-002Ytb-3m; Sun, 25 Apr 2021 12:25:52 +0200
Received: from port-92-195-56-233.dynamic.as20676.net ([92.195.56.233] helo=[192.168.178.129])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1labxX-003D7W-NG; Sun, 25 Apr 2021 12:25:52 +0200
Subject: Re: [PATCH] m68k/mac: Replace macide driver with generic platform
 driver
To:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Joshua Thompson <funaho@jurai.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <ba908b1d-eab5-a4e5-0c0a-2c745287d121@physik.fu-berlin.de>
Date:   Sun, 25 Apr 2021 12:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 92.195.56.233
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/25/21 11:06 AM, Finn Thain wrote:
> This was tested on my Quadra 630. I haven't tested it on my PowerBook 150
> because I don't have a RAM adapter board for it.
> 
> Apparently, the hardware I tested doesn't need macide_clear_irq() or
> macide_test_irq() -- if it did, the generic driver would not have worked.
> It's possible that those routines are needed for the PowerBook 150 but
> we can cross that bridge if and when we come to it.
> 
> BTW, macide_clear_irq() appears to suffer from a race condition. The write
> to the interrupt flags register could easily have unintended side effects
> as it may alter other flag bits. Fortunately, all of the other bits are
> unused by Linux. Moreover, when tested on my Quadra 630, that assignment
> (*ide_ifr &= ~0x20) was observed to have no effect on bit 5.

Shouldn't we switch to a libata driver instead with legacy IDE been slated
for removal from the Linux kernel?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
