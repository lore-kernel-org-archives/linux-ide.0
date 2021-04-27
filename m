Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B776C433B4
	for <linux-ide@archiver.kernel.org>; Tue, 27 Apr 2021 08:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1094C613B3
	for <linux-ide@archiver.kernel.org>; Tue, 27 Apr 2021 08:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhD0Igt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 27 Apr 2021 04:36:49 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:45515 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235037AbhD0Igs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 27 Apr 2021 04:36:48 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lbJCN-00276N-6C; Tue, 27 Apr 2021 10:36:03 +0200
Received: from p5b13a1ac.dip0.t-ipconnect.de ([91.19.161.172] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lbJCM-000MP0-S6; Tue, 27 Apr 2021 10:36:03 +0200
Subject: Re: [PATCH] m68k/mac: Replace macide driver with generic platform
 driver
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@fastmail.com.au>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Joshua Thompson <funaho@jurai.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <793432cca963b632709c4d1312baa9874d73e1d8.1619341585.git.fthain@telegraphics.com.au>
 <ba908b1d-eab5-a4e5-0c0a-2c745287d121@physik.fu-berlin.de>
 <10a08764-c138-9fe5-966c-ce68349b9b6@nippy.intranet>
 <65f01f42-31d9-522a-e690-73d286405a01@gmail.com>
 <dbd5ddaa-c0ee-5aad-20d9-7fae5e2618af@gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <80c3c2f2-baea-02f8-3ac6-da04a4b1c7d3@physik.fu-berlin.de>
Date:   Tue, 27 Apr 2021 10:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <dbd5ddaa-c0ee-5aad-20d9-7fae5e2618af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.161.172
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/27/21 10:11 AM, Sergei Shtylyov wrote:
> On 27.04.2021 4:51, Michael Schmitz wrote:
> 
>>> Was macide the only IDE driver in Debian/m68k kernels without a libata
>>> alternative? If so, this patch would allow you to finally drop CONFIG_IDE.
>>>
>> There's still q40ide.c (ISA IDE interface, byte-swapped, so would need treatment similar to Falcon IDE). Hasn't been updated to a platform device yet.
> 
>   ISA drivers shouldn't be "updated" to the platform drivers.

Why not?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
