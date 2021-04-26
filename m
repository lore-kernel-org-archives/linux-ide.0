Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E21C433ED
	for <linux-ide@archiver.kernel.org>; Mon, 26 Apr 2021 07:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C696105A
	for <linux-ide@archiver.kernel.org>; Mon, 26 Apr 2021 07:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhDZHuA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:50:00 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:59925 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233805AbhDZHtS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Apr 2021 03:49:18 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lavyt-002jmy-7Y; Mon, 26 Apr 2021 09:48:35 +0200
Received: from p5b13a1ac.dip0.t-ipconnect.de ([91.19.161.172] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lavys-001VGa-Tl; Mon, 26 Apr 2021 09:48:35 +0200
Subject: Re: [PATCH] m68k/mac: Replace macide driver with generic platform
 driver
To:     Finn Thain <fthain@fastmail.com.au>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Joshua Thompson <funaho@jurai.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au>
 <ba908b1d-eab5-a4e5-0c0a-2c745287d121@physik.fu-berlin.de>
 <10a08764-c138-9fe5-966c-ce68349b9b6@nippy.intranet>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <aa712e6d-e69d-8a24-252a-7951161e74c6@physik.fu-berlin.de>
Date:   Mon, 26 Apr 2021 09:48:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <10a08764-c138-9fe5-966c-ce68349b9b6@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.161.172
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/26/21 9:37 AM, Finn Thain wrote:> If you enable CONFIG_IDE and CONFIG_BLK_DEV_PLATFORM, Quadras and 
> Powerbooks will use the kernel/drivers/ide/ide_platform.ko module.
> 
> If you enable CONFIG_ATA and CONFIG_PATA_PLATFORM, Quadras and
> Powerbooks will use the kernel/drivers/ata/pata_platform.ko module.
> 
> (If you enable all of the above, you may need to use a blacklist to ensure 
> that the preferred driver module gets loaded.)
> 
> Was macide the only IDE driver in Debian/m68k kernels without a libata 
> alternative? If so, this patch would allow you to finally drop CONFIG_IDE.

That's great to hear. It means that systems using the Mac IDE drivers will
survive the legacy IDE removal if it ever comes.

So, thanks a lot for addressing this!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
